# OpenGearSCAD ⚙️

**OpenGearSCAD** to zaawansowany, w pełni parametryczny generator kół zębatych o zarysie ewolwentowym, stworzony w środowisku **OpenSCAD**. Projekt został zaprojektowany z myślą o inżynierach, hobbystach druku 3D oraz twórcach mechanizmów, którzy potrzebują precyzyjnych i lekkich komponentów.

## 🌟 Główne Funkcje

-   **Inteligentna Geometria Zęba**: Automatyczna korekcja profilu zęba (podcięcie) dla małych kół, zapobiegająca blokowaniu się przekładni.
-   **Zoptymalizowane Otwory Ulżeniowe**: System automatycznie oblicza optymalną liczbę i wielkość otworów redukujących wagę, zachowując bezpieczne odstępy konstrukcyjne.
-   **Pełna Parametryzacja**: Możliwość zmiany modułu, liczby zębów, otworu na oś oraz grubości koła w czasie rzeczywistym.
-   **Matematyczna Precyzja**: Szerokość zęba na linii podziałowej (`s`) jest precyzyjnie wyliczana i implementowana w modelu.
-   **Tester Osiowy (Jig)**: Dołączony moduł do generowania podstawy montażowej, pozwalający na testowanie zazębienia dwóch kół o różnych rozmiarach.

## 🛠️ Instalacja i Obsługa

1.  Zainstaluj [OpenSCAD](https://openscad.org/).
2.  Pobierz plik `rodzaj_zebatki.scad` (lub skopiuj kod z repozytorium).
3.  Otwórz plik w OpenSCAD.
4.  Dostosuj parametry w sekcji `KONFIGURACJA` po lewej stronie lub bezpośrednio w "Customizer" po prawej stronie.
5.  Użyj `F6`, aby wyrenderować model i `F7`, aby wyeksportować go do pliku **STL**.

## 📐 Kluczowe Parametry

| Parametr | Opis |
| :--- | :--- |
| `m` | **Moduł**: Decyduje o wielkości zęba i skoku przekładni. |
| `z` | **Liczba zębów**: Określa średnicę koła i przełożenie. |
| `otwor_os` | Średnica otworu centralnego (np. na wałek silnika). |
| `grubosc` | Szerokość (wysokość) koła zębatego. |

## 🧪 Przykładowe Obliczenia

Generator bazuje na klasycznych wzorach inżynierii mechanicznej:
-   **Średnica podziałowa**: $d = m \cdot z$
-   **Średnica wierzchołkowa**: $d_a = d + 2 \cdot m$
-   **Średnica stóp**: $d_f = d - 2.5 \cdot m$
-   **Szerokość zęba**: $s = \frac{\pi \cdot m}{2}$

## 📂 Struktura Projektu

-   `rodzaj_zebatki.scad` – Główny skrypt zębatki z inteligentnymi otworami i profilem.
-   `tester_rodzaj_zebatek.scad` – Skrypt generujący podstawkę do testowania dwóch współpracujących kół.

## 📝 Licencja

Projekt udostępniany na licencji **MIT**. Oznacza to, że możesz go swobodnie modyfikować i używać nawet w projektach komercyjnych, pod warunkiem zachowania informacji o autorze.

---
*Projekt stworzony z pasji do mechaniki i automatyzacji.* 🚀
