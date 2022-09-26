#### Allocations
| Name | Pages |
|:------:|:-------:|
|Samiksha| Login, Register, Logout|
|Ming Xuan| Password Reset|
|Xing Kun| Wishlist|
|Valerie | Home Page, connection to firebase|
|Melise | wishlist, admit relapse |

#### Important things to note:
If everything is ok, pls create new branch for each person or each feature. Then create a pull request. Samiksha will merge them later. <br> 

For a 'demo' of the writing and reading from db, its under lib > pages > firestore_form_test. To see this form, you can go to lib >pages >main.dart and replace line 35 which is currently 'home: const WidgetTree()' to 'home: FirestoreTest'. Then when u run the app it'll go to this demo screen where you can test the reading and writing to database. <br>

The rest of the pages add into pages folder in lib <br>
1. wishlist
2. admit relapse
3. password reset 
4. home page

for userone usertwo userthree@test.com the password is all 123456, if yall want to use the current accounts so it wont jam up too much <br>

Document ID == User ID <br>
one document belongs to each user <br>




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
https://www.youtube.com/watch?v=TcwQ74WVTTc
https://www.youtube.com/watch?v=ZSVnIphlGKI


#### To be done by Samiksha(will try them soon):
1. password to be hidden https://www.youtube.com/watch?v=8ahTwqS0J_8
2. confirm password https://www.youtube.com/watch?v=8ahTwqS0J_8
3. change UI to our one https://www.youtube.com/watch?v=8ahTwqS0J_8 
4. splitting the logging in and register
5. make sure the form only appears after register, not after logging in (bc now it appears on both)
6. logging out and going back to login screen
<br>
for now, if you press the sign out button, it will sign u out on firebase, it just doesnt go back to the screen. So what I do if I want to go back to the login screen is:
1. I press the sign out button (though there will be no feedback on the UI, but u can see from the debug console that you got logged out)
2. I restart the app (like must legit stop n start n wait again) then it will go back to logout

