// ==========================================
// SEKCJA 1: PARAMETRY WEJŚCIOWE
// ==========================================
m = 0.5;            // Moduł: decyduje o wielkości zęba (im większy, tym ząb potężniejszy)
z = 60;             // Liczba zębów: decyduje o średnicy całego koła
grubosc = 7;        // Grubość (wysokość) zębatki w osi Z
otwor_os = 8;       // Średnica otworu na wałek/oś silnika
$fn = 100;          // Jakość: liczba ścianek w okręgach (im więcej, tym gładszy model)

// ==========================================
// SEKCJA 2: OBLICZENIA INŻYNIERYJNE
// ==========================================
d  = m * z;         // Średnica podziałowa: miejsce, gdzie zęby stykają się z drugim kołem
da = d + 2 * m;     // Średnica wierzchołkowa: zewnętrzna krawędź zębów
df = d - 2.5 * m;   // Średnica stóp: dno zębów (podstawa)
s  = (PI * m) / 2;  // Teoretyczna szerokość zęba (tzw. grubości łuku)

// Promienie pomocnicze
r_stop = df / 2;    // Promień rdzenia (do dna zębów)
r_os = otwor_os / 2; 
h_zeba = (da - df) / 2; // Wysokość zęba od dna do czubka
overlap = 1;        // "Zakładka" wpuszczająca ząb w rdzeń (usuwa szpary)
h_podzialowa = (d/2) - r_stop; // Wysokość punktu styku (linia podziałowa)

// ==========================================
// SEKCJA 3: AUTOMATYKA OTWORÓW ULŻENIOWYCH
// ==========================================
promien_rozmieszczenia = (r_stop + r_os) / 2; // Środek tarczy między osią a zębami
miejsce_na_tarczy = r_stop - r_os;           // Ile mamy wolnego miejsca na dziury
srednica_otworu = miejsce_na_tarczy * 0.6;    // Dziura zajmie 60% miejsca (bezpieczne ścianki)

// Obliczanie liczby otworów na podstawie obwodu (rozstawienie co ok. 1.8 średnicy)
obwod_rozmieszczenia = 2 * PI * promien_rozmieszczenia;
liczba_otworow = floor(obwod_rozmieszczenia / (srednica_otworu * 1.8));

// ==========================================
// SEKCJA 4: DEFINICJA KSZTAŁTU ZĘBA (PROFIL)
// ==========================================
s_czubek = 0.4 * m;  // Szerokość na samym czubku (węższa, by łatwiej wchodził)
s_podst = s * 0.85;  // Szerokość u podstawy (solidna baza)
s_polowa = s / 2;    // Szerokość s/2 (od osi), co daje łącznie 's' na linii podziałowej

// ==========================================
// SEKCJA 5: BUDOWA BRYŁY 3D (LOGIKA CSG)
// ==========================================

// 'difference' odejmuje wszystko poniżej pierwszego obiektu
difference() {
    
    // 'union' łączy rdzeń i wszystkie zęby w jedną bryłę
    union() {
        // Rdzeń (główny krążek koła)
        cylinder(r = r_stop, h = grubosc, center = true);

        // Pętla tworząca 'z' zębów dookoła koła
        for (i = [0 : z - 1]) {
            rotate([0, 0, i * (360 / z)])  // Obrót o kąt wynikający z liczby zębów
            translate([r_stop, 0, 0])      // Przesunięcie na krawędź rdzenia
            linear_extrude(height = grubosc, center = true) // Wyciągnięcie w 3D
            
            // Rysowanie precyzyjnego kształtu zęba punkt po punkcie
            polygon(points = [
                [-overlap, -s_podst],     // Punkt wewnątrz rdzenia (lewy)
                [0,        -s_podst],     // Podstawa (lewa)
                [h_podzialowa, -s_polowa],// Punkt styku (lewy) - tu szerokość to 's'
                [h_zeba,   -s_czubek/2],  // Czubek (lewy)
                
                [h_zeba,    s_czubek/2],  // Czubek (prawy)
                [h_podzialowa,  s_polowa],// Punkt styku (prawy)
                [0,         s_podst],     // Podstawa (prawa)
                [-overlap,  s_podst]      // Punkt wewnątrz rdzenia (prawy)
            ]);
        }
    }

    // --- ELEMENTY WYCINANE (ODEJMOWANE) ---

    // 1. Otwór centralny na oś
    cylinder(d = otwor_os, h = grubosc + 2, center = true);

    // 2. Inteligentne otwory ulżeniowe (jeśli jest na nie miejsce)
    if (miejsce_na_tarczy > 4 && liczba_otworow >= 3) {
        for (j = [0 : liczba_otworow - 1]) {
            rotate([0, 0, j * (360 / liczba_otworow)])
            translate([promien_rozmieszczenia, 0, 0])
            cylinder(d = srednica_otworu, h = grubosc + 2, center = true);
        }
    }
}