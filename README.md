#### Problem 1 
If you see an error in these few lines delete `new` (in the github its already deleted but your own side) <br>

```gradle
if (flutterRoot == null) {
    throw GradleException("Flutter SDK not found. Define location with flutter.sdk in the local.properties file.")
}
```

#### Problem 2 when starting IDE again
When starting your vs code/android studio/vs/IDE remember to run the following:
1. flutter clean
2. flutter pub cache repair
3. flutter pub get
https://gist.github.com/minhcasi/2362b8ed369738cea2bf10a57ac569e1

You must configure the flutterfirebase this is important!! <br>


#### When configuring
1. Install the flutterfire CLI following the YouTube Video: <br> 
https://www.youtube.com/watch?v=ZSVnIphlGKI 

type in the command: <br>
flutterfire configure 


#### Links 
https://flutterworldwide.com/community_rWamixHIKmQ <br>
https://www.youtube.com/c/FlutterMapp/videos

#### To be done:
1. password to be hidden
2. confirm password 
3. change UI to our one 