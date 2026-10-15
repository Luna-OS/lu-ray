#!/usr/bin/env bash
# Baut dist/lu-ray-<version>.jar aus dem Original-Jar + Lu-Ray-Aenderungen.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")" && pwd)"
ORIG="$ROOT/original/advanced-xray-fabric-26.3.0.4.jar"
VERSION="26.3.0.4"
OUT="$ROOT/dist/lu-ray-$VERSION.jar"
WORK="$(mktemp -d)"
trap 'rm -rf "$WORK"' EXIT

mkdir -p "$WORK/jar" "$WORK/classes" "$ROOT/dist"
unzip -q "$ORIG" -d "$WORK/jar"

# 1) HudOverlay neu kompilieren (gegen Stubs, Java 21 Bytecode laeuft auf Java 25)
javac -nowarn --release 21 -d "$WORK/classes" \
  -sourcepath "$ROOT/stubs" \
  "$ROOT/src/pro/mikey/xray/screens/HudOverlay.java"
cp "$WORK/classes/pro/mikey/xray/screens/HudOverlay.class" \
   "$WORK/jar/pro/mikey/xray/screens/HudOverlay.class"

# 2) Mond-Textur + Icon
cp -r "$ROOT/resources/." "$WORK/jar/"

# 3) Lizenz beilegen (MIT verlangt den Hinweis)
cp "$ROOT/LICENSE" "$WORK/jar/LICENSE-lu-ray"

# 4) fabric.mod.json anpassen
python3 -I - "$WORK/jar/fabric.mod.json" <<'PY'
import json, sys
p = sys.argv[1]
d = json.load(open(p))
d["id"] = "luray"
d["name"] = "Lu-Ray"
d["description"] = "Lu-Ray – eine Kopie von Advanced XRay, mit Mond-Symbol statt 'XRay Active'."
d["authors"] = ["ErrorMikey (Advanced XRay)", "Luna-OS (Lu-Ray)"]
d["contact"] = {"sources": "https://github.com/Luna-OS/lu-ray"}
d["icon"] = "assets/xray/icon.png"
json.dump(d, open(p, "w"), indent=2, ensure_ascii=False)
PY

rm -f "$OUT"
(cd "$WORK/jar" && zip -q -X -r "$OUT" META-INF && zip -q -X -r "$OUT" . -x 'META-INF/*')
echo "Fertig: $OUT"
