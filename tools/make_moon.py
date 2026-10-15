"""Erzeugt die Mond-Textur (Sichel) fuer das HUD und das Mod-Icon."""
import sys
from PIL import Image, ImageDraw, ImageFilter

SIZE = 64
SS = 8  # Supersampling fuer glatte Kanten


def crescent(size):
    big = size * SS
    full = Image.new("L", (big, big), 0)
    d = ImageDraw.Draw(full)
    pad = int(big * 0.06)
    d.ellipse((pad, pad, big - pad, big - pad), fill=255)
    # Ausschnitt nach rechts oben verschoben -> Sichel zeigt nach links
    cut = Image.new("L", (big, big), 0)
    dc = ImageDraw.Draw(cut)
    off_x, off_y = int(big * 0.30), int(big * -0.12)
    dc.ellipse((pad + off_x, pad + off_y, big - pad + off_x, big - pad + off_y), fill=255)
    mask = Image.composite(Image.new("L", (big, big), 0), full, cut)
    return mask.resize((size, size), Image.LANCZOS)


def main(out_path, size=SIZE):
    mask = crescent(size)
    moon = Image.new("RGBA", (size, size), (255, 236, 160, 255))
    moon.putalpha(mask)
    # leichter Leuchtrand
    glow = Image.new("RGBA", (size, size), (255, 244, 200, 0))
    glow.putalpha(mask.filter(ImageFilter.GaussianBlur(size / 24)).point(lambda a: int(a * 0.6)))
    out = Image.alpha_composite(glow, moon)
    out.save(out_path, optimize=True)


if __name__ == "__main__":
    main(sys.argv[1], int(sys.argv[2]) if len(sys.argv) > 2 else SIZE)
