package com.xinyan.flutter_app;

import android.content.ContextWrapper;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.BatteryManager;
import android.os.Build;
import android.os.Bundle;
import android.os.Handler;
import android.os.Looper;
import android.text.TextUtils;
import android.widget.Toast;

import com.meituan.android.walle.ChannelInfo;
import com.meituan.android.walle.WalleChannelReader;
import com.netease.nis.captcha.Captcha;
import com.netease.nis.captcha.CaptchaConfiguration;
import com.netease.nis.captcha.CaptchaListener;
import com.xinyan.flutter_app.plugin.FlutterPluginJumpToActivity;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
    String noSenseCaptchaId = "6a5cab86b0eb4c309ccb61073c4ab672";
    private static final String NO_SENSE_CAPTCHA_CHANNEL = "flutter.plugin/noSenseCaptcha";
    private static final String CHANNEL = "flutter.plugin/battery";

    private CaptchaListener captchaListener;
    private CaptchaConfiguration configuration;
    private MethodChannel methodChannel;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        GeneratedPluginRegistrant.registerWith(this);
        registerCustomPlugin(this);
        new MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(new MethodChannel.MethodCallHandler() {
            @Override
            public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
                if (methodCall.method.equals("getBatteryLevel")) {
                    int batteryLevel = getBatteryLevel();
                    if (batteryLevel != -1) {
                        result.success(batteryLevel);
                    } else {
                        result.error("failed", "", null);
                    }
                } else if (methodCall.method.equals("getChannel")) {
                    String channel = getChannel();
                    if (!TextUtils.isEmpty(channel)) {
                        result.success(channel);
                    } else {
                        result.error("failed", "", null);
                    }
                } else {
                    result.notImplemented();
                }
            }
        });

        methodChannel = new MethodChannel(getFlutterView(), NO_SENSE_CAPTCHA_CHANNEL);
        methodChannel.setMethodCallHandler(new MethodChannel.MethodCallHandler() {
            @Override
            public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
                if (methodCall.method.equals("showValidate")) {
                    showValidate();
                } else {
                    result.notImplemented();
                }
            }
        });
        initListener();
        initConfiguration();
    }

    private void initConfiguration() {
        configuration = new CaptchaConfiguration.Builder()
                .captchaId(noSenseCaptchaId)// 验证码业务id
                // 验证码类型，默认为传统验证码，如果要使用无感知请设置以下类型
                .mode(CaptchaConfiguration.ModeType.MODE_INTELLIGENT_NO_SENSE)
                .listener(captchaListener)
                .timeout(1000 * 10) // 超时时间，一般无需设置
                .debug(true) // 是否启用debug模式，一般无需设置
                // 设置验证码框的位置和宽度，一般无需设置，不推荐设置宽高，后面将逐步废弃该接口
                .position(-1, -1, 0, 0)
                // 自定义验证码滑动条滑块的不同状态图片
                .build(MainActivity.this);
        Captcha.getInstance().init(configuration);
    }

    private void registerCustomPlugin(PluginRegistry registry) {
        // 跳转原生activity
        FlutterPluginJumpToActivity.registerWith(registry.registrarFor(FlutterPluginJumpToActivity.CHANNEL));
    }

    private int getBatteryLevel() {
        int batteryLevel = -1;
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            BatteryManager batteryManager = (BatteryManager) getSystemService(BATTERY_SERVICE);
            batteryLevel = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY);
        } else {
            Intent intent = new ContextWrapper(getApplicationContext())
                    .registerReceiver(null, new IntentFilter(Intent.ACTION_BATTERY_CHANGED));
            batteryLevel = (intent.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) * 100) /
                    intent.getIntExtra(BatteryManager.EXTRA_SCALE, -1);
        }
        return batteryLevel;
    }

    private String getChannel() {
        ChannelInfo channelInfo = WalleChannelReader.getChannelInfo(this.getApplicationContext());
        String channel = "";
        if (channelInfo != null) {
            channel = channelInfo.getChannel();
//            Map<String, String> extraInfo = channelInfo.getExtraInfo();
        }
//        channel = "channel";
//        System.out.println("channel " + channel);
        return channel;
    }

    private void showValidate() {
        Captcha.getInstance().validate();
    }


    private void initListener() {
        captchaListener = new CaptchaListener() {
            @Override
            public void onReady() {

            }

            @Override
            public void onValidate(String result, String validate, String msg) {
                new Handler(Looper.getMainLooper()).post(new Runnable() {
                    @Override
                    public void run() {
                        methodChannel.invokeMethod("onValidate", validate);
                    }
                });
//                if (!TextUtils.isEmpty(validate)) {
//                    Toast.makeText(getApplicationContext(), "验证成功", Toast.LENGTH_LONG).show();
//                } else {
//                    Toast.makeText(getApplicationContext(), "验证失败", Toast.LENGTH_LONG).show();
//                }
            }

            @Override
            public void onError(int i, String msg) {
                if (i == Captcha.NO_NETWORK) {
                    Toast.makeText(getApplicationContext(), "请检查网络", Toast.LENGTH_LONG).show();
                } else {
                    Toast.makeText(getApplicationContext(), "验证失败", Toast.LENGTH_LONG).show();
                }
            }

            @Override
            public void onCancel() {

            }

            @Override
            public void onClose() {

            }
        };
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        captchaListener = null;
    }
}
