package com.sun.javafx.font.t2k;

import com.sun.javafx.font.DisposerRecord;
import com.sun.javafx.font.FontResource;
import com.sun.javafx.font.FontStrikeDesc;

import java.lang.ref.WeakReference;

class T2KStrikeDisposer
        implements DisposerRecord {
    FontResource fontResource;
    FontStrikeDesc desc;
    long pScalerContext;
    boolean disposed;

    public T2KStrikeDisposer(FontResource paramFontResource, FontStrikeDesc paramFontStrikeDesc, long paramLong) {
        this.pScalerContext = 0L;
        this.disposed = false;


        this.fontResource = paramFontResource;
        this.desc = paramFontStrikeDesc;
        this.pScalerContext = paramLong;
    }

    public void dispose() {
        if (!this.disposed) {


            WeakReference weakReference = (WeakReference) this.fontResource.getStrikeMap().get(this.desc);
            if (weakReference != null) {
                Object object = weakReference.get();
                if (object == null) {
                    this.fontResource.getStrikeMap().remove(this.desc);
                }
            }


            if (this.pScalerContext != 0L) {
                T2KFontFile.freePointer(this.pScalerContext);
            }
            this.disposed = true;
        }
    }
}
