# QuitNow
An application to help smokers quit smoking. To run the application, ensure that you have an emulator available.

Clone this repo, open your emulator, and navigate to flutter_app_quit_now > lib > main.dart to run the code. The application should start in the emulator.

## Functionalities and Features
- Login
- Register & fill out user form
- Password reset
- Home page to show user smoking data
- Wishlist
- Admit relapse
- Sharing to social media: Twitter


## Firebase Design
Firebase Authentication is used. When a user registers with QuitNow, Firebase will generate a unique UID that is tagged to this user.
Document ID == User ID <br>
One document in 'users' database belongs to each user <br>

For testing purposes, use the below account to log in to the application
Email: test5@test.com
Password: !ABC123d

## Possible Errors and how to solve them:
### Problem 1

If you see an error in these few lines delete `new` (in the github its already deleted but your own side) <br>

```gradle
if (flutterRoot == null) {
    throw GradleException("Flutter SDK not found. Define location with flutter.sdk in the local.properties file.")
}
```

### Problem 2 when starting IDE again

When starting your vs code/android studio/vs/IDE remember to run the following:

1. flutter clean
2. flutter pub cache repair
3. flutter pub get
   https://gist.github.com/minhcasi/2362b8ed369738cea2bf10a57ac569e1

You must configure the flutterfirebase this is important!! <br>

### When configuring

1. Install the flutterfire CLI following the YouTube Video: <br>
   https://www.youtube.com/watch?v=ZSVnIphlGKI

type in the command to ensure flutterfire command is availableon your system: <br>
flutterfire configure

#### Helpful Links

https://flutterworldwide.com/community_rWamixHIKmQ <br>
https://www.youtube.com/c/FlutterMapp/videos
https://www.youtube.com/watch?v=TcwQ74WVTTc
https://www.youtube.com/watch?v=ZSVnIphlGKI
