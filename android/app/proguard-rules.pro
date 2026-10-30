# ---- flutter_local_notifications (uses Gson reflection to persist scheduled notifications)
-keep class com.dexterous.** { *; }
-keep class * extends com.google.gson.TypeAdapter
-keep class * implements com.google.gson.TypeAdapterFactory
-keep class * implements com.google.gson.JsonSerializer
-keep class * implements com.google.gson.JsonDeserializer
-keepattributes Signature
-keepattributes *Annotation*
-keep class com.google.gson.reflect.TypeToken { *; }
-keep class * extends com.google.gson.reflect.TypeToken

# ---- audio_service / just_audio / media session
-keep class com.ryanheise.** { *; }
-keep class androidx.media.** { *; }
-dontwarn com.google.android.exoplayer2.**
-dontwarn androidx.media3.**

# ---- Flutter embedding
-keep class io.flutter.** { *; }
-dontwarn io.flutter.embedding.**
-dontwarn com.google.android.play.core.**
