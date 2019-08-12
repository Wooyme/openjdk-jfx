package com.sun.javafx.font.t2k;

import com.sun.javafx.font.Glyph;
import com.sun.javafx.geom.RectBounds;
import com.sun.javafx.geom.Shape;


class T2KGlyph
        implements Glyph {
    private T2KFontStrike strike;
    private int gc;
    private float userAdvance;
    private float deviceXAdvance;
    private float deviceYAdvance;
    byte[] pixelData;
    private int width;
    private int height;
    private int originX;
    private int originY;
    private boolean isLCDGlyph;
    private RectBounds b2d;

    public T2KGlyph(T2KFontStrike paramT2KFontStrike, int paramInt, float paramFloat) {
        this.strike = paramT2KFontStrike;
        this.gc = paramInt;
        this.userAdvance = paramFloat;
    }

    T2KGlyph(T2KFontStrike paramT2KFontStrike, int paramInt, long paramLong) {
        this.strike = paramT2KFontStrike;
        this.gc = paramInt;

        int[] arrayOfInt = getGlyphInfo(paramLong);
        this.width = arrayOfInt[0];
        this.height = arrayOfInt[1];
        this.originX = arrayOfInt[2];
        this.originY = arrayOfInt[3];
        int i = arrayOfInt[4];
        this.isLCDGlyph = false;
        if (i > this.width) {


            this.width = i;
            this.isLCDGlyph = true;
        }


        this.deviceXAdvance = getGlyphPixelXAdvance(paramLong);
        this.deviceYAdvance = getGlyphPixelYAdvance(paramLong);
        this.userAdvance = paramT2KFontStrike.getGlyphUserAdvance(this.deviceXAdvance, this.deviceYAdvance);


        this.pixelData = getGlyphPixelData(paramLong);
        freeGlyph(paramLong);
    }


    public int getGlyphCode() {
        return this.gc;
    }


    public RectBounds getBBox() {
        if (this.b2d == null) {
            this.b2d = this.strike.getGlyphBounds(this.gc);
        }
        return this.b2d;
    }


    private native int[] getGlyphInfo(long paramLong);


    private native byte[] getGlyphPixelData(long paramLong);


    void setAdvance(float paramFloat1, float paramFloat2, float paramFloat3) {
        this.userAdvance = paramFloat1;
        this.deviceXAdvance = paramFloat2;
        this.deviceYAdvance = paramFloat3;
    }

    private native float getGlyphPixelXAdvance(long paramLong);

    private native float getGlyphPixelYAdvance(long paramLong);

    private native void freeGlyph(long paramLong);

    public float getAdvance() {
        return this.userAdvance;
    }


    public Shape getShape() {
        return this.strike.createGlyphOutline(this.gc);
    }


    public float getPixelXAdvance() {
        return this.deviceXAdvance;
    }


    public float getPixelYAdvance() {
        return this.deviceYAdvance;
    }


    public int getWidth() {
        return this.width;
    }


    public int getHeight() {
        return this.height;
    }


    public int getOriginX() {
        return this.originX;
    }


    public int getOriginY() {
        return this.originY;
    }


    public byte[] getPixelData() {
        return this.pixelData;
    }


    public byte[] getPixelData(int paramInt) {
        return this.pixelData;
    }


    public boolean isLCDGlyph() {
        return this.isLCDGlyph;
    }
}
