package com.heqijun.nativemixflutterapp;

import android.app.Activity;
import android.app.Application;
import android.content.Context;

import com.heqijun.nativemixflutterapp.boost.PageRouter;
import com.taobao.idlefish.flutterboost.FlutterBoostPlugin;
import com.taobao.idlefish.flutterboost.interfaces.IPlatform;

import java.util.Map;

import io.flutter.app.FlutterApplication;

public class App extends FlutterApplication {

    @Override
    public void onCreate() {
        super.onCreate();

        //初始化FlutterBoost
        FlutterBoostPlugin.init(new IPlatform() {
            @Override
            public Application getApplication() {
                return App.this;
            }

            /**
             * 获取应用入口的Activity,这个Activity在应用交互期间应该是一直在栈底的
             * @return
             */
            @Override
            public Activity getMainActivity() {
                return MainActivity.sRef.get();
            }

            @Override
            public boolean isDebug() {
                return true;
            }

            /**
             * 当在Dart中调用FlutterBoost.singleton.openPage("pagename", {}, true);
             * 这个方法打开的页面是一个native页面的时候就会回调到上面的那个方法中，可以看到会传过来一个url，
             * 接着就是使用我们自己定义的路由页面PageRouter根据指定的url来打开相应的native页面了
             * @param context
             * @param url
             * @param requestCode
             * @return
             */
            @Override
            public boolean startActivity(Context context, String url, int requestCode) {
                return PageRouter.openPageByUrl(context,url,requestCode);
            }

            @Override
            public Map getSettings() {
                return null;
            }
        });
    }
}
