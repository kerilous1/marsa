# Flutter Core & Plugins
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.**  { *; }
-keep class io.flutter.plugins.**  { *; }

# Drift SQLite & Native Bindings
-keep class * extends net.sqlcipher.database.SQLiteOpenHelper { *; }
-keep class * extends sqlite3.** { *; }
-dontwarn sqlite3.**

# Google ML Kit Text Recognition
-keep class com.google.mlkit.** { *; }
-keep interface com.google.mlkit.** { *; }
-dontwarn com.google.mlkit.**

# Android Native Services (AlarmManager & Expiry Receiver)
-keep class com.marsa.vault.MainActivity { *; }
-keep class com.marsa.vault.ExpiryNotificationReceiver { *; }


# Google Play Core (Deferred Components / SplitCompat)
-dontwarn com.google.android.play.core.**