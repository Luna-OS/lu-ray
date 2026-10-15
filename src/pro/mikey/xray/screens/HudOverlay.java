package pro.mikey.xray.screens;

import net.minecraft.client.Minecraft;
import net.minecraft.client.gui.GuiGraphicsExtractor;
import net.minecraft.client.renderer.RenderPipelines;
import net.minecraft.resources.Identifier;
import pro.mikey.xray.XRay;
import pro.mikey.xray.core.ScanController;

/**
 * Lu-Ray: ersetzt den Text "XRay Active" durch ein Mond-Symbol unten rechts.
 */
public class HudOverlay {
    private static final Identifier MOON = XRay.assetLocation("gui/moon.png");

    private static final int SIZE = 12;
    private static final int MARGIN = 4;

    public static void renderGameOverlayEvent(GuiGraphicsExtractor graphics) {
        if (!ScanController.INSTANCE.isXRayActive() || !(Boolean) XRay.config().showOverlay.get()) {
            return;
        }

        Minecraft mc = Minecraft.getInstance();
        int x = mc.getWindow().getGuiScaledWidth() - SIZE - MARGIN;
        int y = mc.getWindow().getGuiScaledHeight() - SIZE - MARGIN;

        graphics.blit(RenderPipelines.GUI_TEXTURED, MOON, x, y, 0f, 0f, SIZE, SIZE, SIZE, SIZE, 0xFFFFFFFF);
    }
}
