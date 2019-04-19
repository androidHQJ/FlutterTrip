package com.heqijun.nativemixflutterapp.boost;

import android.content.Context;
import android.content.Intent;

import com.heqijun.nativemixflutterapp.MainActivity;

/**
 * @author heqijun
 * @description 页面路由跳转类:根据URL来跳转到指定activity的配置类
 * @date 2019/4/19 3:03 PM
 */
public class PageRouter {
    public static final String NATIVE_PAGE_URL = "sample://nativePage";
    public static final String FLUTTER_PAGE_URL = "sample://flutterPage";
    public static final String FLUTTER_FRAGMENT_PAGE_URL = "sample://flutterFragmentPage";

    public static boolean openPageByUrl(Context context, String url) {
        return openPageByUrl(context, url, 0);
    }

    public static boolean openPageByUrl(Context context, String url, int requestCode) {
        try {
            if (url.startsWith(FLUTTER_PAGE_URL)) {
                context.startActivity(new Intent(context, FlutterPageActivity.class));
                return true;
            } else if (url.startsWith(FLUTTER_FRAGMENT_PAGE_URL)) {
                context.startActivity(new Intent(context, FlutterFragmentPageActivity.class));
                return true;
            } else if (url.startsWith(NATIVE_PAGE_URL)) {
                context.startActivity(new Intent(context, MainActivity.class));
                return true;
            } else {
                return false;
            }
        } catch (Throwable t) {
            return false;
        }
    }
}
