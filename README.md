https://www.youtube.com/watch?v=ZSVnIphlGKI 


If you see an error in these few line delete new <br>

```gradle
if (flutterRoot == null) {
    throw GradleException("Flutter SDK not found. Define location with flutter.sdk in the local.properties file.")
}
```

When starting your vs code/android studio/vs/IDE remember to run the following:
1. flutter clean
2. flutter pub cache repair
3. flutter pub get
https://gist.github.com/minhcasi/2362b8ed369738cea2bf10a57ac569e1
