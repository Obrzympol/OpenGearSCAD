// ==========================================
// SEKCJA 1: PARAMETRY WEJŚCIOWE
// ==========================================
m = 1;                // Moduł (wielkość zęba)
z = 60;                 // Liczba zębów
grubosc = 7;            // Wysokość zębatki [mm]
otwor_os = 8;           // Średnica otworu na oś [mm]
$fn = 100;              // Jakość renderowania okręgów

// PARAMETRY KONSTRUKCYJNE:
wartosc_sciecia = 0.15; // Szerokość płaskiego czubka [mm]
margines = 3.0;         // Bezpieczna ścianka tarczy i szprych [mm]
steps = 20;             // Gładkość boku zęba (ewolwenty)
liczba_okienek = 5;      // Liczba trapezowych wycięć

// ==========================================
// SEKCJA 2: OBLICZENIA GEOMETRYCZNE
// ==========================================
alfa = 20;                      // Kąt przyporu
r = (m * z) / 2;                // Promień podziałowy
r_b = r * cos(alfa);            // Promień koła bazowego
r_f = r - 1.25 * m;             // Promień stóp (dno zębów)

// Korekta promienia wierzchołkowego dla płaskiego czubka
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
// SEKCJA 3: BUDOWA BRYŁY (GŁÓWNY PROGRAM)
// ==========================================

difference() {
    union() {
        // 1. Rdzeń tarczy
        cylinder(r = r_f, h = grubosc, center = true);

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
    t_start = sqrt(max(0, pow(r_f/r_b, 2) - 1)) * 180 / PI;
    t_end   = sqrt(max(0, pow(r_a/r_b, 2) - 1)) * 180 / PI;

    // Punkty ewolwentowe lewej strony (obrócone pionowo)
    pts_L = [for (i=[0:steps]) 
        let(t = t_start + (t_end - t_start) * (i/steps))
        let(p = involute(r_b, t))
        let(rx = p[1], ry = p[0]) 
        [ rx * cos(delta) - ry * sin(delta), 
          rx * sin(delta) + ry * cos(delta) ]
    ];

    // Odbicie lustrzane dla prawej strony
    pts_P = [for (i=[steps:-1:0]) [-pts_L[i][0], pts_L[i][1]]];

    polygon(concat(pts_L, pts_P));
}

module generuj_okienka_trapezowe() {
    r_os = otwor_os / 2;
    r_wew = r_os + margines;     
    r_zew = r_f - margines;      
    
    // Sprawdzenie, czy jest sens robić wycięcia
    if (r_zew > r_wew + 2) {
        for (j = [0 : liczba_okienek - 1]) {
            rotate([0, 0, j * (360 / liczba_okienek)])
            
            linear_extrude(height = grubosc + 2, center = true)
            // Magiczna funkcja offset tworzy zaokrąglone rogi wycięcia
            offset(r = 1.2, $fn=30) 
            offset(r = -1.2)
            
            intersection() {
                // Ograniczenie góra/dół (pierścień)
                difference() {
                    circle(r = r_zew);
                    circle(r = r_wew);
                }
                
                // Ograniczenie lewo/prawo (klin kątowy)
                // Obliczamy kąt szprychy tak, by miała szerokość zbliżoną do marginesu
                kat_szprychy = (margines / (r_wew * PI / 180));
                kat_wyciecia = (360 / liczba_okienek) - kat_szprychy;
                
                polygon([
                    [0, 0],
                    [r_a * 1.5 * cos(-kat_wyciecia/2), r_a * 1.5 * sin(-kat_wyciecia/2)],
                    [r_a * 1.5 * cos(kat_wyciecia/2), r_a * 1.5 * sin(kat_wyciecia/2)]
                ]);
            }
        }
    }
}