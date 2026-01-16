# OpenGearSCAD ⚙️

**OpenGearSCAD** to zaawansowany, w pełni parametryczny generator kół zębatych o zarysie ewolwentowym, stworzony w środowisku **OpenSCAD**. Projekt został zaprojektowany z myślą o inżynierach, hobbystach druku 3D oraz twórcach mechanizmów, którzy potrzebują precyzyjnych i lekkich komponentów.

## 🚀 Kluczowe Funkcje

* **Precyzyjna Geometria Ewolwentowa**: Zęby generowane na podstawie funkcji matematycznej inwoluty, co zapewnia płynną współpracę kół, stałe przełożenie i niskie tarcie.
* **Inteligentne Otwory Ulżeniowe**: Automatycznie generuje zaokrąglone okienka trapezowe, które redukują zużycie materiału i wagę, zachowując przy tym wysoką sztywność konstrukcji (szprychy).
* **Failsafe Design**: Skrypt dynamicznie oblicza promień rdzenia i okienek. Nawet przy ekstremalnych ustawieniach (np. bardzo duży otwór na oś względem małej liczby zębów), zęby pozostają solidnie zakotwiczone w materiale.
* **Optymalizacja pod Druk 3D**: Parametr `wartosc_sciecia` pozwala na płaskie zakończenie wierzchołka zęba, co eliminuje problemy z kruszeniem się zbyt ostrych krawędzi (tzw. *top land*).

## ⚙️ Główne Parametry

W sekcji `PARAMETRY WEJŚCIOWE` kodu możesz dostosować:

| Parametr | Opis |
| :--- | :--- |
| `m` | **Moduł** – podstawowy parametr wielkości zęba. |
| `z` | **Liczba zębów** – określa średnicę i przełożenie. |
| `grubosc` | Wysokość zębatki w osi Z [mm]. |
| `otwor_os` | Średnica otworu centralnego na wałek silnika lub oś [mm]. |
| `wartosc_sciecia` | Szerokość płaskiego czubka zęba (poprawia trwałość wydruku). |
| `margines` | Minimalna grubość ścianek tarczy i szprych. |
| `liczba_okienek` | Liczba trapezowych wycięć ulżeniowych. |

## 🛠️ Jak używać?

1.  Pobierz i zainstaluj [OpenSCAD](https://openscad.org/).
2.  Otwórz plik `.scad` lub wklej kod do edytora.
3.  Dostosuj parametry w pierwszej sekcji skryptu.
4.  Podgląd: wciśnij `F5`.
5.  Renderowanie: wciśnij `F6`.
6.  Eksport: wciśnij `F7`, aby zapisać plik jako `.STL`.

## 📐 Logika Projektowa

Generator wykorzystuje standardowy kąt przyporu ($20^\circ$) oraz automatycznie wylicza:
* **Średnicę podziałową**: $d = m \cdot z$
* **Promień koła bazowego**: $r_b = r \cdot \cos(20^\circ)$
* **Wcięcie zębów**: automatyczny `overlap` zębów w głąb rdzenia eliminuje błędy topologii (manifold).



## 📄 Licencja

Projekt udostępniony na licencji MIT. Możesz go dowolnie modyfikować i używać w projektach komercyjnych.
