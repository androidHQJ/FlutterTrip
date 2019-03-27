package com.heqijun.nativemixflutterapp;

import android.os.Bundle;
import android.widget.FrameLayout;

import io.flutter.app.FlutterFragmentActivity;
import io.flutter.facade.Flutter;
import io.flutter.view.FlutterView;

public class FlutterMainActivity extends FlutterFragmentActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        FlutterView mainFlutter = Flutter.createView(this, getLifecycle(), "main");
        addContentView(mainFlutter, new FrameLayout.LayoutParams(FrameLayout.LayoutParams.MATCH_PARENT,
                FrameLayout.LayoutParams.MATCH_PARENT));
    }
}
