# Flutter Proguard Rules
# Keep Flutter classes
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }

# Keep Firebase classes
-keep class com.firebase.** { *; }
-keep class com.google.firebase.** { *; }
-keep class com.google.android.gms.** { *; }

# Keep model classes
-keep class com.absher.clone.models.** { *; }

# Keep API service classes
-keep class com.absher.clone.services.** { *; }

# Keep Serialized names (Retrofit, GSON)
-keepattributes Signature
-keepattributes *Annotation*
-keepattributes SourceFile,LineNumberTable
-keep public class * extends com.google.gson.TypeAdapter
-keep public class * implements com.google.gson.TypeAdapterFactory
-keep public class * implements com.google.gson.JsonSerializer
-keep public class * implements com.google.gson.JsonDeserializer

# Preserve line numbers for debugging
-renamesourcefileattribute SourceFile
