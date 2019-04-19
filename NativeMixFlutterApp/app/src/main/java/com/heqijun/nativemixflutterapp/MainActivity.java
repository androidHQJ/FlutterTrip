package com.heqijun.nativemixflutterapp;

import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;

import com.heqijun.nativemixflutterapp.boost.PageRouter;

import java.lang.ref.WeakReference;

import io.flutter.app.FlutterActivity;

public class MainActivity extends AppCompatActivity {

    public static WeakReference<MainActivity> sRef;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        sRef = new WeakReference<>(this);
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        sRef.clear();
        sRef = null;
    }

    public void goToWanAndroid(View view) {
        startActivity(new Intent(MainActivity.this,FlutterMainActivity.class));
    }

    public void openFlutter(View view) {
        PageRouter.openPageByUrl(this, PageRouter.FLUTTER_PAGE_URL);
    }

    public void openFlutterFragment(View view) {
        PageRouter.openPageByUrl(this, PageRouter.FLUTTER_FRAGMENT_PAGE_URL);
    }
}
