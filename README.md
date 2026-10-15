# 🌙 Lu-Ray

Eine Kopie des Fabric-Mods **[Advanced XRay](https://github.com/AdvancedXRay/xray-fabric)** (v26.3.0.4, MIT-Lizenz)
mit einer Änderung: Statt des grünen Punkts + Text **„XRay Active“** erscheint
**unten rechts ein Mond-Symbol**, solange XRay an ist.

## Download

👉 [`dist/lu-ray-26.3.0.4.jar`](dist/lu-ray-26.3.0.4.jar) in den `mods`-Ordner legen
(Minecraft 26.3, Fabric Loader + Fabric API).

> ⚠️ Nicht zusammen mit dem originalen Advanced XRay installieren – beide enthalten
> dieselben Klassen. Die Konfiguration (`config/xray/`) und Tastenbelegungen bleiben gleich.

## Was wurde geändert?

| Datei | Änderung |
|---|---|
| `src/pro/mikey/xray/screens/HudOverlay.java` | zeichnet `moon.png` (12×12) unten rechts statt Punkt + Text |
| `resources/assets/xray/textures/gui/moon.png` | neue Mond-Textur |
| `resources/assets/xray/icon.png` | Mod-Icon (Mond) |
| `fabric.mod.json` (im Build) | Name „Lu-Ray“, ID `luray` |

Alles andere ist 1:1 das Original-Jar aus `original/`.

## Selbst bauen

```bash
./build.sh            # braucht JDK 21+, python3, zip/unzip
python3 tools/make_moon.py resources/assets/xray/textures/gui/moon.png 64   # Textur neu erzeugen
```

`build.sh` entpackt das Original, kompiliert nur `HudOverlay.java` (gegen die Platzhalter
in `stubs/`), legt die Mond-Textur dazu und packt `dist/lu-ray-26.3.0.4.jar`.

## Lizenz

MIT – siehe [LICENSE](LICENSE). Original © ErrorMikey / AdvancedXRay contributors.
