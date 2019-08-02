package com.xinyan.flutter_app.plugin;

import android.app.Activity;
import android.content.Intent;

import com.xinyan.flutter_app.view.WebViewActivity;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry;

public class FlutterPluginJumpToActivity implements MethodChannel.MethodCallHandler {

    public static String CHANNEL = "com.xinyan.jump/plugin";

    private Activity activity;

    static MethodChannel channel;

    private FlutterPluginJumpToActivity(Activity activity) {
        this.activity = activity;
    }

    public static void registerWith(PluginRegistry.Registrar registrar) {
        channel = new MethodChannel(registrar.messenger(), CHANNEL);
        FlutterPluginJumpToActivity instance = new FlutterPluginJumpToActivity(registrar.activity());
        channel.setMethodCallHandler(instance);
    }

    @Override
    public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
        if (methodCall == null) {
            return;
        }
        if ("webView".equals(methodCall.method)) {
            Intent intent = new Intent(activity, WebViewActivity.class);
            activity.startActivity(intent);
            result.success("webView");
        }
    }
}
