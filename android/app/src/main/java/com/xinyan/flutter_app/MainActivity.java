package com.xinyan.flutter_app;

import android.os.Bundle;

import com.xinyan.flutter_app.plugin.FlutterPluginJumpToActivity;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.PluginRegistry;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);
    registerCustomPlugin(this);
  }

  private void registerCustomPlugin(PluginRegistry registry) {
    // 跳转原生activity
    FlutterPluginJumpToActivity.registerWith(registry.registrarFor(FlutterPluginJumpToActivity.CHANNEL));
  }
}
