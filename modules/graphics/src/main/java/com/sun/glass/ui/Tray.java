package com.sun.glass.ui;

import java.util.ArrayList;

public class Tray {
    private long pointer;
    private static boolean hasTray = false;
    private ArrayList<Runnable> callbacks = new ArrayList<>();
    public native long initTrayNative(String icon);
    public native void addMenuNative(long pointer,String text,int id,int isUpdate);
    public native void loop(int blocking);
    public Tray(String icon,boolean startLoop){
        if(!hasTray) {
            this.pointer = initTrayNative(icon);
            if(startLoop){
                new Thread(new Runnable() {
                    @Override
                    public void run() {
                        loop(1);
                    }
                }).start();
            }
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
