package com.sun.javafx.font.t2k;

import com.sun.glass.utils.NativeLibLoader;
import com.sun.javafx.font.CharToGlyphMapper;
import com.sun.javafx.font.CompositeStrike;
import com.sun.javafx.font.FontResource;
import com.sun.javafx.font.FontStrike;
import com.sun.javafx.font.Glyph;
import com.sun.javafx.font.PGFont;
import com.sun.javafx.geom.transform.BaseTransform;
import com.sun.javafx.scene.text.TextSpan;
import com.sun.javafx.text.GlyphLayout;
import com.sun.javafx.text.PrismTextLayout;
import com.sun.javafx.text.ScriptMapper;
import com.sun.javafx.text.TextRun;

import java.security.AccessController;
import java.security.PrivilegedAction;
import java.text.Bidi;

class ICUGlyphLayout
        extends GlyphLayout {
    static {
        AccessController.doPrivileged(new PrivilegedAction<Void>() {
            public Void run() {
                NativeLibLoader.loadLibrary("javafx_font_t2k");
                return null;
            }
        });
        initIDs();
    }

    private float[] _mat = new float[4];
    private long textPtr;
    private static final int CANONICAL_MASK = 448;

    public int breakRuns(PrismTextLayout paramPrismTextLayout, char[] paramArrayOfChar, int paramInt) {
        int i = paramArrayOfChar.length;
        int j = 0;
        int k = 0;
        int m = 0;
        int n = 0;
        boolean bool1 = false;
        boolean bool2 = false;
        boolean bool3 = false;
        boolean bool4 = false;

        boolean bool5 = true;
        boolean bool6 = true;
        if ((paramInt & 0x2) != 0) {


            bool5 = (paramInt & 0x10) != 0;
            bool6 = (paramInt & 0x8) != 0;
        }

        TextRun textRun = null;
        Bidi bidi = null;
        byte b = 0;
        int i1 = i;
        byte b1 = 0;
        byte b2 = 0;
        TextSpan textSpan = null;
        int i2 = i;
        PGFont pGFont = null;
        TextSpan[] arrayOfTextSpan = paramPrismTextLayout.getTextSpans();
        if (arrayOfTextSpan != null) {
            if (arrayOfTextSpan.length > 0) {
                textSpan = arrayOfTextSpan[b2];
                i2 = textSpan.getText().length();
                pGFont = (PGFont) textSpan.getFont();
                if (pGFont == null) {
                    paramInt |= 0x20;
                }
            }
        } else {
            pGFont = paramPrismTextLayout.getFont();
        }
        CharToGlyphMapper charToGlyphMapper = null;
        if (pGFont != null) {
            FontResource fontResource = pGFont.getFontResource();
            int i4 = pGFont.getFeatures();
            int i5 = fontResource.getFeatures();
            bool4 = (i4 & i5) != 0;
            if (bool5 && fontResource instanceof com.sun.javafx.font.CompositeFontResource) {
                charToGlyphMapper = fontResource.getGlyphMapper();
            }
        }
        if (bool6 && i > 0) {
            int i4 = paramPrismTextLayout.getDirection();
            bidi = new Bidi(paramArrayOfChar, 0, null, 0, i, i4);


            b = (byte) bidi.getLevelAt(bidi.getRunStart(b1));
            i1 = bidi.getRunLimit(b1);
            if ((b & 1) != 0) {
                paramInt |= 0x8;
            }
        }

        int i3 = 0;
        byte b3 = 0;
        while (b3 < i) {
            char c = paramArrayOfChar[b3];
            int i4 = c;


            boolean bool7 = c == '\t' || c == '\n' || c == '\r';
            boolean bool8 = b3 >= i2;
            boolean bool9 = b3 >= i1;
            boolean bool10 = false;
            boolean bool11 = false;
            boolean bool12 = false;

            if (bool5 && !bool7 && !bool8 && !bool9) {
                if (Character.isHighSurrogate(c)) {
                    if (b3 + 1 < i2 && Character.isLowSurrogate(paramArrayOfChar[b3 + 1])) {
                        i4 = Character.toCodePoint(c, paramArrayOfChar[++b3]);
                    }
                }
                if (bool1) {


                    if (charToGlyphMapper != null &&
                            !Character.isWhitespace(i4)) {
                        int i5 = charToGlyphMapper.charToGlyph(i4);
                        if (i5 != 0) {
                            n = i5 >>> 24;
                        } else {
                            n = -1;
                        }
                        if (m != n) {
                            bool10 = true;
                        }
                    }


                    k = ScriptMapper.getScript(i4);
                    if (j > 1 && k > 1 && k != j) {

                        bool11 = true;
                    }


                    if (!bool3) {
                        int i5 = 1 << Character.getType(i4);
                        if ((i5 & 0x1C0) != 0) {
                            bool3 = true;
                        }
                    }
                } else {
                    bool2 = (bool4 || ScriptMapper.isComplexCharCode(i4));
                    if (bool2) {
                        bool12 = true;
                    }
                }
            }

            if (bool7 || bool8 || bool9 || bool10 || bool11 || bool12) {


                if (b3 != i3) {
                    textRun = new TextRun(i3, b3 - i3, b, bool1, j, textSpan, m, bool3);

                    paramPrismTextLayout.addTextRun(textRun);

                    if (bool1) {
                        paramInt |= 0x10;
                    }
                    bool3 = false;
                    i3 = b3;
                }

                if (bool7) {
                    b3++;

                    if (c == '\r' && b3 < i2 && paramArrayOfChar[b3] == '\n') {
                        b3++;
                    }


                    textRun = new TextRun(i3, b3 - i3, b, false, 0, textSpan, 0, false);

                    if (c == '\t') {
                        textRun.setTab();
                        paramInt |= 0x4;
                    } else {
                        textRun.setLinebreak();
                    }
                    paramPrismTextLayout.addTextRun(textRun);

                    i3 = b3;
                    if (b3 == i)
                        break;
                    bool8 = (b3 >= i2);
                    bool9 = (b3 >= i1);
                    bool3 = false;
                }
                if (bool8) {

                    textSpan = arrayOfTextSpan[++b2];
                    i2 += textSpan.getText().length();
                    pGFont = (PGFont) textSpan.getFont();
                    charToGlyphMapper = null;
                    if (pGFont == null) {
                        paramInt |= 0x20;
                    } else {
                        FontResource fontResource = pGFont.getFontResource();
                        int i5 = pGFont.getFeatures();
                        int i6 = fontResource.getFeatures();
                        bool4 = ((i5 & i6) != 0);
                        if (bool5 && fontResource instanceof com.sun.javafx.font.CompositeFontResource) {
                            charToGlyphMapper = fontResource.getGlyphMapper();
                        }
                    }
                }
                if (bool9) {
                    b1++;


                    b = (byte) bidi.getLevelAt(bidi.getRunStart(b1));
                    i1 = bidi.getRunLimit(b1);
                    if ((b & 1) != 0) {
                        paramInt |= 0x8;
                    }
                }

                if (bool5) {
                    if (bool7 || bool8 || bool9) {
                        c = paramArrayOfChar[b3];
                        if (Character.isHighSurrogate(c)) {
                            if (b3 + 1 < i2 && Character.isLowSurrogate(paramArrayOfChar[b3 + 1])) {
                                i4 = Character.toCodePoint(c, paramArrayOfChar[++b3]);
                            }
                        }


                        bool12 = true;
                        bool2 = (bool4 || ScriptMapper.isComplexCharCode(i4));
                    }
                    if (bool11) {


                        bool2 = (bool4 || ScriptMapper.isComplexCharCode(i4));
                        if (bool2) {


                            j = k;

                        } else {

                            bool12 = true;
                        }
                    }
                    if (bool10) {


                        m = n;
                    }
                    if (bool12) {
                        if (bool2) {


                            bool1 = true;
                            int i5 = 1 << Character.getType(i4);
                            bool3 = ((i5 & 0x1C0) != 0);
                            j = ScriptMapper.getScript(i4);
                            m = 0;
                            if (charToGlyphMapper != null &&
                                    !Character.isWhitespace(i4)) {
                                int i6 = charToGlyphMapper.charToGlyph(i4);
                                if (i6 != 0) {
                                    m = i6 >>> 24;
                                } else {
                                    m = -1;
                                }
                            }
                        } else {

                            bool1 = false;
                            bool3 = false;
                            j = 0;
                            m = 0;
                        }
                    }
                }
            }
            if (!bool7) b3++;

        }

        if (i3 < i) {
            paramPrismTextLayout.addTextRun(new TextRun(i3, i - i3, b, bool1, j, textSpan, m, bool3));


            if (bool1) {
                paramInt |= 0x10;

            }
        } else if (textRun == null || textRun.isLinebreak()) {
            textRun = new TextRun(i3, 0, (byte) 0, false, 0, textSpan, 0, false);

            paramPrismTextLayout.addTextRun(textRun);
        }

        if (bidi != null &&
                !bidi.baseIsLeftToRight()) {
            paramInt |= 0x100;
        }

        return 2;
    }


    public void layout(TextRun paramTextRun, PGFont paramPGFont, FontStrike paramFontStrike, char[] paramArrayOfChar) {
        int i = paramTextRun.getLength();
        T2KFontFile t2KFontFile = null;

        if (paramFontStrike instanceof CompositeStrike) {
            int j = paramTextRun.getSlot();
            if (j != -1) {
                CompositeStrike compositeStrike = (CompositeStrike) paramFontStrike;
                t2KFontFile = (T2KFontFile) compositeStrike.getStrikeSlot(j).getFontResource();
            }
        } else if (paramFontStrike.getFontResource() instanceof T2KFontFile) {
            t2KFontFile = (T2KFontFile) paramFontStrike.getFontResource();
        }

        T2KFontFile.LayoutCache layoutCache = null;
        if (t2KFontFile != null) {
            layoutCache = t2KFontFile.getLayoutTableCache();
        }
        if (t2KFontFile != null && layoutCache != null) {
            if (this.textPtr == 0L) {
                this.textPtr = createTextPtr(paramArrayOfChar);
            }
            BaseTransform baseTransform = paramFontStrike.getTransform();
            float f = paramFontStrike.getSize();
            this._mat[0] = (float) baseTransform.getMxx() * f;
            this._mat[1] = (float) baseTransform.getMxy() * f;
            this._mat[2] = (float) baseTransform.getMyx() * f;
            this._mat[3] = (float) baseTransform.getMyy() * f;
            byte b = -1;

            boolean bool = paramTextRun.isLeftToRight();
            byte b1 = bool ? (byte) 1 : (byte) 2;
            int j = paramPGFont.getFeatures();
            int k = t2KFontFile.getFeatures();
            int m = j & k;

            int n = paramTextRun.getScript();
            if (m != 0 && n == 0) {


                n = 25;
            }
            if (paramTextRun.isCanonical()) {
                m |= 0x40000000;
            }
            FontStrike fontStrike = t2KFontFile.getStrike(f, baseTransform);
            if (fontStrike.getAAMode() == 1) {
                b1 |= 0x10;
            }
            if (paramTextRun.isNoLinkBefore()) {
                b1 |= 0x4;
            }
            if (paramTextRun.isNoLinkAfter()) {
                b1 |= 0x8;
            }
            nativeLayout(t2KFontFile, fontStrike, f, this._mat, paramTextRun.getSlot() << 24, this.textPtr, paramTextRun
                    .getStart(), i, paramArrayOfChar.length, n, b, b1, m, paramTextRun, t2KFontFile

                    .getUnitsPerEm(), t2KFontFile
                    .getNumHMetrics(), layoutCache, layoutCache
                    .getCachePtr());
        } else {

            float f1 = 0.0F, f2 = 0.0F;
            int[] arrayOfInt = new int[i];
            float[] arrayOfFloat = new float[i * 2 + 2];
            Glyph glyph = paramFontStrike.getGlyph(0);
            float f3 = glyph.getPixelXAdvance();
            float f4 = glyph.getPixelYAdvance();
            for (byte b = 0; b < i; b++) {
                arrayOfFloat[b * 2] = f1;
                arrayOfFloat[b * 2 + 1] = f2;
                f1 += f3;
                f2 += f4;
            }
            arrayOfFloat[i * 2] = f1;
            arrayOfFloat[i * 2 + 1] = f2;
            paramTextRun.shape(i, arrayOfInt, arrayOfFloat, null);
        }
    }

    public void dispose() {
        if (this.textPtr != 0L) {
            freeTextPtr(this.textPtr);
            this.textPtr = 0L;
        }
        super.dispose();
    }

    private static native void initIDs();

    private static native long createTextPtr(char[] paramArrayOfChar);

    private static native void freeTextPtr(long paramLong);

    private static native void nativeLayout(T2KFontFile paramT2KFontFile, FontStrike paramFontStrike, float paramFloat, float[] paramArrayOfFloat, int paramInt1, long paramLong1, int paramInt2, int paramInt3, int paramInt4, int paramInt5, int paramInt6, int paramInt7, int paramInt8, TextRun paramTextRun, int paramInt9, int paramInt10, T2KFontFile.LayoutCache paramLayoutCache, long paramLong2);
}
