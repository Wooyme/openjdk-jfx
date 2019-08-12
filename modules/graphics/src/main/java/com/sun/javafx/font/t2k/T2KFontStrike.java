package com.sun.javafx.font.t2k;

import com.sun.javafx.font.DisposerRecord;
import com.sun.javafx.font.FontStrikeDesc;
import com.sun.javafx.font.Glyph;
import com.sun.javafx.font.PrismFontFactory;
import com.sun.javafx.font.PrismFontFile;
import com.sun.javafx.font.PrismFontStrike;
import com.sun.javafx.geom.Path2D;
import com.sun.javafx.geom.Point2D;
import com.sun.javafx.geom.RectBounds;
import com.sun.javafx.geom.transform.Affine2D;
import com.sun.javafx.geom.transform.BaseTransform;
import com.sun.javafx.geom.transform.NoninvertibleTransformException;
import java.util.concurrent.ConcurrentHashMap;




class T2KFontStrike
        extends PrismFontStrike<T2KFontFile>
{
    private long pScalerContext = 0L;

    ConcurrentHashMap<Integer, Point2D> glyphPointMap;

    Affine2D invTx = null;

    boolean gdiLCDGlyphs = false;

    int gdiSize;


    T2KFontStrike(T2KFontFile paramT2KFontFile, float paramFloat, BaseTransform paramBaseTransform, int paramInt, FontStrikeDesc paramFontStrikeDesc) {
        super(paramT2KFontFile, paramFloat, paramBaseTransform, paramInt, paramFontStrikeDesc);
        byte b1 = 0;
        boolean bool = false;
        float f1 = 1.0F;
        float f2 = 0.0F;
        double[] arrayOfDouble = new double[4];

        arrayOfDouble[3] = paramFloat; arrayOfDouble[0] = paramFloat;

        BaseTransform baseTransform = getTransform();
        this.invTx = new Affine2D(baseTransform);
        try {
            this.invTx.invert();
        } catch (NoninvertibleTransformException noninvertibleTransformException) {
            this.invTx = null;
        }
        arrayOfDouble[0] = baseTransform.getMxx() * paramFloat;
        arrayOfDouble[1] = baseTransform.getMyx() * paramFloat;
        arrayOfDouble[2] = baseTransform.getMxy() * paramFloat;
        arrayOfDouble[3] = baseTransform.getMyy() * paramFloat;

        float f3 = PrismFontFactory.getFontSizeLimit();
        if (Math.abs(arrayOfDouble[0]) > f3 || Math.abs(arrayOfDouble[1]) > f3 ||
                Math.abs(arrayOfDouble[2]) > f3 || Math.abs(arrayOfDouble[3]) > f3) {
            this.drawShapes = true;
        }
        else if (PrismFontFactory.isWindows &&
                getAAMode() == 1 && paramT2KFontFile
                .isInstalledFont() && arrayOfDouble[0] > 0.0D && arrayOfDouble[0] == arrayOfDouble[3] && arrayOfDouble[1] == 0.0D && arrayOfDouble[2] == 0.0D) {




            this.gdiLCDGlyphs = true;
            this.gdiSize = (int)(arrayOfDouble[0] + 0.5D);
        }



        byte b2 = 2;
        if (getAAMode() == 1) {
            b2 = 4;
            bool = true;
        }
        this

                .pScalerContext = paramT2KFontFile.createScalerContext(arrayOfDouble, b2, b1, bool, f1, f2);
    }

    protected DisposerRecord createDisposer(FontStrikeDesc paramFontStrikeDesc) {
        T2KFontFile t2KFontFile = (T2KFontFile)getFontResource();
        return new T2KStrikeDisposer(t2KFontFile, paramFontStrikeDesc, this.pScalerContext);
    }



    long getScalerContext() { return this.pScalerContext; }




    private native long getLCDGlyphFromWindows(String paramString, boolean paramBoolean1, boolean paramBoolean2, int paramInt1, int paramInt2, boolean paramBoolean3);



    private long getGlyphFromWindows(int paramInt) {
        PrismFontFile prismFontFile = getFontResource();
        String str = prismFontFile.getFamilyName();
        boolean bool1 = prismFontFile.isBold();
        boolean bool2 = prismFontFile.isItalic();

        return getLCDGlyphFromWindows(str, bool1, bool2, this.gdiSize, paramInt, true);
    }


    public Point2D getGlyphMetrics(int paramInt) {
        T2KFontFile t2KFontFile = (T2KFontFile)getFontResource();
        float[] arrayOfFloat = t2KFontFile.getGlyphMetrics(this.pScalerContext, paramInt);
        return new Point2D(arrayOfFloat[0], arrayOfFloat[1]);
    }

    protected Glyph createGlyph(int paramInt) {
        T2KGlyph t2KGlyph;
        T2KFontFile t2KFontFile = (T2KFontFile)getFontResource();
        if (drawAsShapes()) {
            float f = t2KFontFile.getAdvance(paramInt, getSize());
            t2KGlyph = new T2KGlyph(this, paramInt, f);
        } else {
            long l1 = 0L, l2 = 0L;
            if (this.gdiLCDGlyphs) {
                l1 = l2 = getGlyphFromWindows(paramInt);
            }
            if (l1 == 0L) {
                l1 = t2KFontFile.getGlyphImage(this.pScalerContext, paramInt);
            }

            t2KGlyph = new T2KGlyph(this, paramInt, l1);
            if (l2 != 0L) {
                float f1 = t2KFontFile.getAdvance(paramInt, getSize());
                float f2 = f1, f3 = 0.0F;
                if (this.invTx != null) {
                    Point2D point2D = new Point2D(f1, 0.0F);
                    getTransform().transform(point2D, point2D);
                    f2 = point2D.x;
                    f3 = point2D.y;
                }
                ((T2KGlyph)t2KGlyph).setAdvance(f1, f2, f3);
            }
        }
        return t2KGlyph;
    }

    protected Path2D createGlyphOutline(int paramInt) {
        T2KFontFile t2KFontFile = (T2KFontFile)getFontResource();
        Path2D path2D = t2KFontFile.getGlyphOutline(this.pScalerContext, paramInt);
        if (this.invTx != null) {
            path2D.transform(this.invTx);
        }
        return path2D;
    }

    RectBounds getGlyphBounds(int paramInt) {
        T2KFontFile t2KFontFile = (T2KFontFile)getFontResource();
        return t2KFontFile.getGlyphBounds(this.pScalerContext, paramInt);
    }

    float getGlyphUserAdvance(float paramFloat1, float paramFloat2) {
        if (this.invTx != null) {
            Point2D point2D = new Point2D(paramFloat1, paramFloat2);
            this.invTx.transform(point2D, point2D);
            return point2D.x;
        }
        return paramFloat1;
    }


    Point2D getGlyphPoint(int paramInt1, int paramInt2) {
        Point2D point2D = null;
        Integer integer = Integer.valueOf(paramInt1 << 16 | paramInt2);
        if (this.glyphPointMap == null) {
            synchronized (this) {
                if (this.glyphPointMap == null) {
                    this.glyphPointMap = new ConcurrentHashMap();
                }
            }
        } else {

            point2D = (Point2D)this.glyphPointMap.get(integer);
        }

        if (point2D == null) {
            T2KFontFile t2KFontFile = (T2KFontFile)getFontResource();
            point2D = t2KFontFile.getGlyphPoint(this.pScalerContext, paramInt1, paramInt2);
            if (point2D != null) {
                adjustPoint(point2D);
                this.glyphPointMap.put(integer, point2D);
            }
        }
        return point2D;
    }

    protected void adjustPoint(Point2D paramPoint2D) {
        if (this.invTx != null)
            this.invTx.deltaTransform(paramPoint2D, paramPoint2D);
    }
}
