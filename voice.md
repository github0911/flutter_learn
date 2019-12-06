## 语音实现
* 是否进入语音频道
* 语音频道权限判断
* 加入语音频道的用户列表
* 如何单独设置录音音量，人声播放音量
* 踢出语音房间？
* 

## 语音频道
* 如何单独设置用户录音音量（麦克风音量），人声播放音量（其他用户说话声音）
* 本地静音是不接收所有音频？还是说本地说话无法发送给其他频道用户
* 语音设置，麦克风音量，输出音量（所有人设置）？
* 移出频道（发送指令让用户退出语音频道？）
* 功能菜单音量调节是调节用户麦克风的音量还是接收者的播放音量？

## 连接语音频道需要的数据
1. 语音频道的设置信息`麦克风音量，扬声器音量（初始化用户本地），是否按键发言（是，显示按住发言按钮，手动启动enableLocalAudio(true)，说话结束，enableLocalAudio(false)），是否全员静音(无法说话，也无法调节麦克风音量，扬声器音量，点击提示用户)`
2. 加入频道的用户列表`用户信息，麦克风状态，扬声器状态`
3. 指令的推送`服务器拒听（用户输出音量设置为0），服务器静音（用户麦克风音量设置为0），本地静音（不接收该用户的音频流），移出频道（收到指令，退出语音频道），开启全员按键发言（当前频道为语音频道弹出提示框）,全员静音（所有人都禁麦，说话不会推送音频流，管理员能够调节麦克风）`

## 声网SDK Api
* 本地静音（某个用户）`muteRemoteAudioStream(int uid, boolean muted)` true 停止接收指定用户的音频流 false 继续接收指定用户的音频流
* 服务器拒听（某个用户）
    1. `adjustPlaybackSignalVolume(0)` 设置输出音量（扬声器）为0，用户不可再进行手动修改
    2. `muteAllRemoteAudioStreams(boolean muted)` true 停止接收所有远端音频流 false 继续接收所有远端音频流
* 服务器静音（某个用户）
    1. `adjustRecordingSignalVolume(0)` 设置输入音量（麦克风）为0，用户不可再进行手动修改
    2. `enableLocalAudio(boolean muted)` true 重新开启本地语音功能，即开启本地语音采集 flase 关闭本地语音功能，即停止本地语音采集
* 移出频道 `leaveChannel()`
* 全员按键发言 `enableLocalAudio(boolean muted)` true 自由发言 false 按键发言
* 全员静音 `enableLocalAudio(boolean muted)` false 关闭本地语音功能，即停止本地语音采集 用户不可进行手动修改

### 本地存储，所有语音频道通用
* 本地静音（）
* 输入模式（按键发言，自由发言）
* 麦克风音量
* 输出音量

加入语音频道调用服务端接口，上报服务端该用户加入了语音频道
获取语音频道用户列表
离开频道调用服务端接口，上报服务端该用户已经离开了语音频道

服务器拒听之后如何显示
服务器静音之后如何显示

全员按键发言 个人设置如何处理？

加入语音频道需要
channelName

用户加入语音频道，是否能自由发言？

flutter_hooks

E/libc    (28260): Access denied finding property "net.dns1"
E/libc    (28260): Access denied finding property "net.dns2"
E/libc    (28260): Access denied finding property "net.dns3"
E/libc    (28260): Access denied finding property "net.dns4"

iOS 接入agora SDK的配置事项
https://docs.agora.io/cn/Interactive%20Broadcast/start_live_ios?platform=iOS

Unable to set property "hw.wifipro.dns_err_count" to "2458,0,0,0,0,0": connection failed; errno=13 (Permission denied)
Unable to set property "hw.wifipro.dns_err_count" to "3050,0,0,0,0,0": connection failed; errno=24 (Too many open files)

 Tried to send a platform message to Flutter, but FlutterJNI was detached from native C++. Could not send. Channel: agora_rtc_engine_event_channel. Response ID: 0

 