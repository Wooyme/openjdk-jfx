package com.sun.javafx.font.t2k;

import com.sun.javafx.font.PrismFontFactory;
/*    */ import com.sun.javafx.font.PrismFontFile;
/*    */ import com.sun.javafx.text.GlyphLayout;

public class T2KFactory extends PrismFontFactory {
    public static PrismFontFactory getFactory() {
        return new T2KFactory();
    }

    protected PrismFontFile createFontFile(String paramString1, String paramString2, int paramInt, boolean paramBoolean1, boolean paramBoolean2, boolean paramBoolean3, boolean paramBoolean4) throws Exception {
        return new T2KFontFile(paramString1, paramString2, paramInt, paramBoolean1, paramBoolean2, paramBoolean3, paramBoolean4);
    }

    public GlyphLayout createGlyphLayout() {
        return new ICUGlyphLayout();
    }
}