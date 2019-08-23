-ignorewarnings

# Flutter wrapper start
-dontwarn io.flutter.**
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.**  { *; }
-keep class io.flutter.plugins.**  { *; }
-keep class io.flutter.embedding.**  { *; }
# Flutter wrapper end

# agora 声网 start
-keep class io.agora.** { *; }
# agora 声网 end