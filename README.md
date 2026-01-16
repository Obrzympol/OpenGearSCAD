# OpenGearSCAD: Parametric Gear System

**OpenGearSCAD** to zbiór w pełni parametrycznych, zoptymalizowanych pod druk 3D skryptów OpenSCAD, służących do generowania trzech najpopularniejszych typów kół zębatych o zarysie ewolwentowym.



## ⚙️ Wspólna Logika Projektowa

Wszystkie skrypty w tym repozytorium korzystają z ujednoliconego zestawu parametrów. Dzięki temu projektowanie całych przekładni jest intuicyjne – zębatki o tym samym **module (m)** i odpowiedniej **liczbie zębów (z)** zawsze będą do siebie pasować, niezależnie od typu zębatki.

### Kluczowe Funkcje:
* **Pionowe Okienka Ulżeniowe**: Nawet w zębatkach skośnych i daszkowych (V), otwory ulżeniowe są wycinane pionowo. Eliminuje to nawisy (overhangs) i ułatwia druk 3D bez podpór.
* **Dynamiczna Jakość**: Skrypty automatycznie wykrywają tryb podglądu ($F5$) i renderowania ($F6$), dostosowując parametry `$fn` oraz `slices` dla maksymalnej wydajności pracy.
* **Geometria Failsafe**: Automatyczne obliczanie promieni zapobiega błędom konstrukcyjnym przy dużych otworach na osie.

---

## 🛠️ Dostępne Typy Zębatek

### 1. Zębatka Walcowa Prosta (*Spur Gear*)
Podstawowy typ zębatki do prostych przełożeń. Najszybsza w druku i najłatwiejsza w montażu. Zęby biegną równolegle do osi wału.

### 2. Zębatka Walcowa Skośna (*Helical Gear*)
Zęby nachylone pod kątem (`kat_skosu`). Zapewnia znacznie cichszą pracę i płynniejsze przenoszenie momentu obrotowego dzięki większej powierzchni styku zębów.
> **Uwaga:** Aby para kół skośnych współpracowała na równoległych wałkach, jedno koło musi mieć skos dodatni (L), a drugie ujemny (P).



### 3. Zębatka Daszkowa / Strzałkowa (*Herringbone Gear*)
Zaawansowana konstrukcja typu "V". Łączy zalety kół skośnych, ale eliminuje siły osiowe działające na łożyska. Idealna do ekstruderów drukarek 3D i precyzyjnej robotyki.



---

## 📋 Parametry Konfiguracyjne

| Parametr | Opis |
| :--- | :--- |
| `m` | **Moduł** – podstawowy parametr wielkości zęba. |
| `z` | **Liczba zębów** – definiuje przełożenie i średnicę koła. |
| `grubosc` | Całkowita wysokość zębatki [mm]. |
| `kat_skosu` | Kąt pochylenia linii zęba (standard: 15-25°). |
| `otwor_os` | Średnica otworu centralnego pod wał [mm]. |
| `margines` | Grubość ścianek szprych i tarczy (wytrzymałość konstrukcji). |
| `liczba_okienek` | Ilość trapezowych otworów redukujących masę i czas druku. |

---

## 🚀 Instrukcja Użycia

1. Pobierz plik `.scad` odpowiadający typowi zębatki, której potrzebujesz.
2. Otwórz plik w programie [OpenSCAD](https://openscad.org/).
3. Dostosuj parametry w sekcji `PARAMETRY WEJŚCIOWE`.
4. Wciśnij **F5**, aby zobaczyć szybki podgląd.
5. Wciśnij **F6**, aby wygenerować finalną geometrię (proces może zająć chwilę ze względu na wysoką jakość).
6. Wyeksportuj plik do formatu `.STL` (**F7**) i prześlij do slicera.

---

### Autor
Projekt rozwijany w ramach biblioteki **OpenGearSCAD**.
