package com.heqijun.nativemixflutterapp.boost;

import com.taobao.idlefish.flutterboost.containers.BoostFlutterActivity;

import java.util.HashMap;
import java.util.Map;

import io.flutter.plugin.common.PluginRegistry;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class FlutterPageActivity extends BoostFlutterActivity {

    @Override
    public void onRegisterPlugins(PluginRegistry registry) {
        GeneratedPluginRegistrant.registerWith(registry);
    }

    /**
     * 这个方法返回的url就是flutter中 注册在FlutterBoost中的key
     * @return
     */
    @Override
    public String getContainerName() {
        return "flutterPage";
    }

    /**
     * 通过 getContainerParams 来传递参数给flutter
     * @return
     */
    @Override
    public Map getContainerParams() {
        Map<String,String> params = new HashMap<>();
        params.put("key","hello flutter");
        return params;
    }


}
