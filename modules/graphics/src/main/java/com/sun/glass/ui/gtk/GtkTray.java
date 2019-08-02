package com.sun.glass.ui.gtk;

import java.util.ArrayList;
/*
* 日他妈的托盘栏
*
*
* */
public class GtkTray {
    private long pointer;
    private static boolean hasTray = false;
    private ArrayList<Runnable> callbacks = new ArrayList<>();
    public native long initTrayNative(String icon);
    public native void addMenuNative(long pointer,String text,int id,int isUpdate);
    public GtkTray(String icon){
        if(!hasTray) {
            this.pointer = initTrayNative(icon);
            hasTray = true;
        }else{
            throw new IllegalStateException("Only one tray can be created!");
        }
    }

    public void addMenu(String text,Runnable callback){
        this.callbacks.add(callback);
        this.addMenuNative(this.pointer,text,callbacks.size()-1,0);
    }

    public void updateMenu(int index,String text){
        this.addMenuNative(this.pointer,text,index,1);
    }

    public void onMenuClick(int id){
        if(callbacks.size()>id){
            Runnable callback = callbacks.get(id);
            if(callback!=null) {
                callback.run();
            }
        }
    }
}
