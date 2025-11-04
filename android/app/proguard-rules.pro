# Keep Google J2ObjC annotations
-keep class com.google.j2objc.annotations.** { *; }
-dontwarn com.google.j2objc.annotations.**

# Keep Google Common classes
-keep class com.google.common.** { *; }
-dontwarn com.google.common.**

# If you're using Guava specifically
-keep class com.google.guava.** { *; }
-dontwarn com.google.guava.**