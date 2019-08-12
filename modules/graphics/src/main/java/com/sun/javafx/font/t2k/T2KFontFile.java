package com.sun.javafx.font.t2k;

import com.sun.glass.utils.NativeLibLoader;
import com.sun.javafx.font.Disposer;
import com.sun.javafx.font.DisposerRecord;
import com.sun.javafx.font.FontStrikeDesc;
import com.sun.javafx.font.PrismFontFactory;
import com.sun.javafx.font.PrismFontFile;
import com.sun.javafx.font.PrismFontStrike;
import com.sun.javafx.geom.Path2D;
import com.sun.javafx.geom.Point2D;
import com.sun.javafx.geom.RectBounds;
import com.sun.javafx.geom.transform.BaseTransform;

import java.security.AccessController;
import java.security.PrivilegedAction;


class T2KFontFile extends PrismFontFile {
    private static final int TRUETYPE_FONT = 1;

    static {
        AccessController.doPrivileged(new PrivilegedAction<Void>() {
            public Void run() {
                NativeLibLoader.loadLibrary("javafx_font_t2k");
                return null;
            }
        });
        initNativeIDs();
    }


    private long pScaler = 0L;
    private boolean scalerInited = false;
    private ScalerDisposer scalerDisposer;
    private boolean cacheCreated;
    private LayoutCache layoutCache;

    public T2KFontFile(String paramString1, String paramString2, int paramInt, boolean paramBoolean1, boolean paramBoolean2, boolean paramBoolean3, boolean paramBoolean4) throws Exception {
        super(paramString1, paramString2, paramInt, paramBoolean1, paramBoolean2, paramBoolean3, paramBoolean4);
        this.cacheCreated = false;
    }

    private void initScaler() {
        if (this.pScaler == 0L && !this.scalerInited) {
            byte b = 1;
            String str = getFileName();
            byte[] arrayOfByte = str.getBytes();
            this.pScaler = initNativeScaler(b, getFontIndex(), false, str, arrayOfByte, getFileSize(), null);
            this.scalerInited = true;
            if (!isRegistered()) {
                this.scalerDisposer = new ScalerDisposer(this.pScaler);
                Disposer.addRecord(this, this.scalerDisposer);
            }
        }
    }

    private void invalidateScaler() {
        this.pScaler = 0L;
        if (this.scalerDisposer != null) this.scalerDisposer.pScaler = 0L;
        clearLayoutCache();
    }

    protected void disposeOnShutdown() {
        if (this.pScaler != 0L) {
            disposeNativeScaler(this.pScaler);
            if (PrismFontFactory.debugFonts)
                System.err.println("pScaler freed: " + this.pScaler);
            this.pScaler = 0L;
        }
        freeLayoutCache();
        super.disposeOnShutdown();
    }

    LayoutCache getLayoutTableCache() {
        if (!this.cacheCreated) {
            this.layoutCache = new LayoutCache(this.pScaler);
            this.cacheCreated = true;
        }
        return this.layoutCache;
    }

    Point2D getGlyphPoint(long paramLong, int paramInt1, int paramInt2) {
        initScaler();
        if (this.pScaler != 0L) return getGlyphPointNative(paramLong, this.pScaler, paramInt1, paramInt2);
        return null;
    }

    static class ScalerDisposer implements DisposerRecord {
        long pScaler;

        public ScalerDisposer(long param1Long) {
            this.pScaler = param1Long;
        }

        public void dispose() {
            if (this.pScaler != 0L) {
                T2KFontFile.disposeNativeScaler(this.pScaler);
                if (PrismFontFactory.debugFonts) System.err.println("ScalerDisposer=" + this.pScaler);
                this.pScaler = 0L;
            }
        }
    }

    static class CacheDisposer implements DisposerRecord {
        long layoutTablePtr;

        public CacheDisposer(long param1Long) {
            this.layoutTablePtr = param1Long;
        }

        public void dispose() {
            if (this.layoutTablePtr != 0L) {
                T2KFontFile.freeLayoutTableCacheNative(this.layoutTablePtr);
                this.layoutTablePtr = 0L;
            }
        }

        long getCachePtr() {
            return this.layoutTablePtr;
        }
    }

    static class LayoutCache {
        private T2KFontFile.CacheDisposer cacheDisposer;

        private LayoutCache(long param1Long) {
            long l = T2KFontFile.getLayoutTableCacheNative(param1Long);
            this.cacheDisposer = new T2KFontFile.CacheDisposer(l);
            Disposer.addRecord(this, this.cacheDisposer);
        }

        void freeLayoutCache() {
            this.cacheDisposer.dispose();
        }

        long getCachePtr() {
            return this.cacheDisposer.getCachePtr();
        }
    }

    void freeLayoutCache() {
        if (this.layoutCache != null) {
            this.layoutCache.freeLayoutCache();
        }
    }


    void clearLayoutCache() {
        this.layoutCache = null;
    }


    long createScalerContext(double[] paramArrayOfDouble, int paramInt1, int paramInt2, boolean paramBoolean, float paramFloat1, float paramFloat2) {
        initScaler();
        return createScalerContext(this.pScaler, paramArrayOfDouble, paramInt1, paramInt2, paramBoolean, paramFloat1, paramFloat2);
    }


    Path2D getGlyphOutline(long paramLong, int paramInt) {
        return getGlyphOutline(this.pScaler, paramLong, paramInt);
    }


    RectBounds getGlyphBounds(long paramLong, int paramInt) {
        return getGlyphBounds(this.pScaler, paramLong, paramInt);
    }


    float[] getGlyphMetrics(long paramLong, int paramInt) {
        return getGlyphMetrics(this.pScaler, paramLong, paramInt);
    }

    long getGlyphImage(long paramLong, int paramInt) {
        return getGlyphImage(this.pScaler, paramLong, paramInt);
    }

    protected PrismFontStrike createStrike(float paramFloat, BaseTransform paramBaseTransform, int paramInt, FontStrikeDesc paramFontStrikeDesc) {
        return new T2KFontStrike(this, paramFloat, paramBaseTransform, paramInt, paramFontStrikeDesc);
    }


    private int[] getGlyphBoundingBoxCFF(int paramInt, float paramFloat) {
        if (paramFloat < 1.0F || paramFloat > 48.0F) {
            paramFloat = 12.0F;
        }

        T2KFontStrike t2KFontStrike = (T2KFontStrike) getStrike(paramFloat, BaseTransform.IDENTITY_TRANSFORM);

        long l = t2KFontStrike.getScalerContext();
        RectBounds rectBounds = getGlyphBounds(this.pScaler, l, paramInt);
        int[] arrayOfInt = new int[4];
        float f = getUnitsPerEm() / paramFloat;
        arrayOfInt[0] = Math.round(rectBounds.getMinX() * f);
        arrayOfInt[1] = Math.round(rectBounds.getMinY() * f);
        arrayOfInt[2] = Math.round(rectBounds.getMaxX() * f);
        arrayOfInt[3] = Math.round(rectBounds.getMaxY() * f);
        return arrayOfInt;
    }

    protected int[] createGlyphBoundingBox(int paramInt) {
        if (this.pScaler == 0L) {
            initScaler();
        }
        if (isCFF()) {
            return getGlyphBoundingBoxCFF(paramInt, 12.0F);
        }
        return getGlyphBoundingBoxNative(this.pScaler, paramInt);
    }

    native Point2D getGlyphPointNative(long paramLong1, long paramLong2, int paramInt1, int paramInt2);

    static native void freePointer(long paramLong);

    private static native void initNativeIDs();

    private native long initNativeScaler(int paramInt1, int paramInt2, boolean paramBoolean, String paramString, byte[] paramArrayOfByte, int paramInt3, int[] paramArrayOfInt);

    private static native long getLayoutTableCacheNative(long paramLong);

    private static native void freeLayoutTableCacheNative(long paramLong);

    private static native void disposeNativeScaler(long paramLong);

    private native long createScalerContext(long paramLong, double[] paramArrayOfDouble, int paramInt1, int paramInt2, boolean paramBoolean, float paramFloat1, float paramFloat2);

    private native Path2D getGlyphOutline(long paramLong1, long paramLong2, int paramInt);

    private native RectBounds getGlyphBounds(long paramLong1, long paramLong2, int paramInt);

    private native float[] getGlyphMetrics(long paramLong1, long paramLong2, int paramInt);

    private native long getGlyphImage(long paramLong1, long paramLong2, int paramInt);

    private native int[] getGlyphBoundingBoxNative(long paramLong, int paramInt);
}
