# Razorpay aur ProGuard annotation classes preserve karo
-keep class proguard.annotation.Keep { *; }
-keep class proguard.annotation.KeepClassMembers { *; }

# Razorpay SDK ke liye rules
-keep class com.razorpay.** { *; }
-dontwarn com.razorpay.**

# Google aur Firebase ke liye
-keep class com.google.** { *; }
-keep class io.flutter.** { *; }
-dontwarn com.google.**
-dontwarn io.flutter.**

# Parcelable classes preserve karo
-keepclassmembers class * implements android.os.Parcelable {
    static final android.os.Parcelable$Creator *;
}

# Reflection-based libraries preserve karo
-keepattributes *Annotation*
-keepattributes InnerClasses
