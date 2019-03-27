package com.heqijun.nativemixflutterapp;

import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;

import io.flutter.app.FlutterActivity;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
    }

    public void goToFlutter(View view) {
        startActivity(new Intent(MainActivity.this,FlutterMainActivity.class));
    }
}
