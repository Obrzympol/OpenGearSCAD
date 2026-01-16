// ==========================================
// SEKCJA 1: PARAMETRY WEJŚCIOWE
// ==========================================
m = 0.5;                  // Moduł
z = 60;                 // Liczba zębów
grubosc = 7;            // Wysokość zębatki [mm]
otwor_os = 22;          // Średnica otworu na oś [mm]
$fn = 100;              // Jakość renderowania

// PARAMETRY KONSTRUKCYJNE:
wartosc_sciecia = 0.15; // Szerokość płaskiego czubka [mm]
margines = 3.0;         // Bezpieczna ścianka [mm]
steps = 20;             // Gładkość ewolwenty
liczba_okienek = 5;      // Liczba wycięć
overlap_zeba = 0.2;     // Dodatkowe wpuszczenie zęba w rdzeń dla spójności bryły

// ==========================================
// SEKCJA 2: OBLICZENIA GEOMETRYCZNE
// ==========================================
alfa = 20;                      
r = (m * z) / 2;                
r_b = r * cos(alfa);            
r_f = r - 1.25 * m;             

// Skorygowany promień wierzchołkowy dla płaskiego czubka
r_a = (r + m) - (wartosc_sciecia * 0.8); 

// Matematyka ewolwenty
inv_alfa = tan(alfa) - (alfa * PI / 180);
gamma = 90 / z; 
delta = gamma + (inv_alfa * 180 / PI);

function involute(rb, t) = [
    rb * (cos(t) + (t * PI / 180) * sin(t)),
    rb * (sin(t) - (t * PI / 180) * cos(t))
];

// ==========================================
// SEKCJA 3: BUDOWA BRYŁY
// ==========================================

difference() {
    union() {
        // 1. Rdzeń zębatki - musi sięgać co najmniej do dna zębów
        // Zapewniamy, że rdzeń zawsze "złapie" podstawę zęba
        r_rdzenia = max(r_f + 0.1, (otwor_os/2) + 0.5);
        cylinder(r = r_rdzenia, h = grubosc, center = true);

        // 2. Generowanie wieńca zębów
        for (i = [0 : z - 1]) {
            rotate([0, 0, i * (360 / z)])
                linear_extrude(height = grubosc, center = true)
                    profil_zeba_ewolwentowy();
        }
    }

    // 3. Otwór na oś
    cylinder(d = otwor_os, h = grubosc + 2, center = true);

    // 4. Zaokrąglone wycięcia trapezowe
    generuj_okienka_trapezowe();
}

// ==========================================
// SEKCJA 4: MODUŁY POMOCNICZE
// ==========================================

module profil_zeba_ewolwentowy() {
    // Startujemy ewolwentę nieco głębiej (r_f - overlap), by ząb wrósł w rdzeń
    r_start = r_f - overlap_zeba;
    t_start = sqrt(max(0, pow(r_start/r_b, 2) - 1)) * 180 / PI;
    t_end   = sqrt(max(0, pow(r_a/r_b, 2) - 1)) * 180 / PI;

    pts_L = [for (i=[0:steps]) 
        let(t = t_start + (t_end - t_start) * (i/steps))
        let(p = involute(r_b, t))
        let(rx = p[1], ry = p[0]) 
        [ rx * cos(delta) - ry * sin(delta), 
          rx * sin(delta) + ry * cos(delta) ]
    ];

    pts_P = [for (i=[steps:-1:0]) [-pts_L[i][0], pts_L[i][1]]];

    // Polygon zamykający ząb od środka koła (0,0), co gwarantuje brak przerw
    polygon(concat([[0,0]], pts_L, pts_P));
}

module generuj_okienka_trapezowe() {
    r_os = otwor_os / 2;
    r_wew = r_os + margines;     
    r_zew = r_f - margines/1.5; // Zostawiamy pas materiału pod zębami
    
    if (r_zew > r_wew + 1.5) { // Rysuj tylko jeśli jest bezpieczna przestrzeń
        for (j = [0 : liczba_okienek - 1]) {
            rotate([0, 0, j * (360 / liczba_okienek)])
            
            linear_extrude(height = grubosc + 2, center = true)
            offset(r = 1.2, $fn=30) 
            offset(r = -1.2)
            
            intersection() {
                difference() {
                    circle(r = r_zew);
                    circle(r = r_wew);
                }
                
                kat_szprychy = (margines / (r_wew * PI / 180));
                kat_wyciecia = (360 / liczba_okienek) - kat_szprychy;
                
                polygon([
                    [0, 0],
                    [r_a * 2 * cos(-kat_wyciecia/2), r_a * 2 * sin(-kat_wyciecia/2)],
                    [r_a * 2 * cos(kat_wyciecia/2), r_a * 2 * sin(kat_wyciecia/2)]
                ]);
            }
        }
    }
}