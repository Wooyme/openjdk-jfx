#include "glass_tray.h"
#include <malloc.h>
#include <string.h>
JavaVM * gVM;
jobject gThis;
jmethodID gMid;

void _tray_menu_cb(void *item,struct tray_menu* data){
    JNIEnv * g_env;
    int getEnvStat = gVM->GetEnv((void **)&g_env, JNI_VERSION_1_6);
    if (getEnvStat == JNI_EDETACHED) {
    	if (gVM->AttachCurrentThread((void **) &g_env, NULL) != 0) {
            std::cout << "Failed to attach" << std::endl;
    	}
    } else if (getEnvStat == JNI_OK) {
    	//
    } else if (getEnvStat == JNI_EVERSION) {
    	std::cout << "GetEnv: version not supported" << std::endl;
    }
    g_env->CallVoidMethod(gThis, gMid, data->id);

}

JNIEXPORT jlong JNICALL Java_com_sun_glass_ui_Tray_initTrayNative(JNIEnv *env, jobject jthis, jstring jicon){
    const char *icon = env->GetStringUTFChars(jicon, 0);
    env->GetJavaVM(&gVM);
    gThis = env->NewGlobalRef(jthis);
    jclass thisClass = env->GetObjectClass(jthis);
    gMid = env->GetMethodID(thisClass, "onMenuClick", "(I)V");
    struct tray *tray = (struct tray*)malloc(sizeof(struct tray));
    tray->icon = (char*)malloc(128);
    memset(tray->icon,0,128);
    memcpy(tray->icon,icon,strlen(icon));
    std::cout<<"Icon:"<<tray->icon<<std::endl;
    env->ReleaseStringUTFChars(jicon, icon);
    struct tray_menu *tray_menus = (struct tray_menu*)malloc(sizeof(struct tray_menu)*20);
    memset(tray_menus,0,sizeof(struct tray_menu)*20);
    tray->menu = tray_menus;
    tray_init(tray);
    return (jlong)tray;
}

JNIEXPORT void JNICALL Java_com_sun_glass_ui_Tray_addMenuNative(JNIEnv *env, jobject jthis, jlong jpointer, jstring jtext, jint jid,jint is_update){
    const char *text = env->GetStringUTFChars(jtext, 0);
    struct tray *tray = (struct tray*)jpointer;
    std::cout<<"Current Icon:"<<tray->icon<<std::endl;
    if(is_update==0)
        tray->menu[jid].text = (char*)malloc(64);
    memset(tray->menu[jid].text,0,64);
    memcpy(tray->menu[jid].text,text,strlen(text));
    tray->menu[jid].id = (int)jid;
    env->ReleaseStringUTFChars(jtext, text);
    tray_update(tray);
}