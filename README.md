#### Allocations

|   Name    |               Pages               |
| :-------: | :-------------------------------: |
| Samiksha  |      Login, Register, Logout      |
| Ming Xuan |          Password Reset           |
| Xing Kun  |             Wishlist              |
|  Valerie  | Home Page, connection to firebase |
|  Melise   |      wishlist, admit relapse      |

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

1. checking password specifications (8 characters etc. )
2. one upper case character, lower case character, a special character and a number. 


#### Other stuff:
1. There is a load time in retrieving the data where it will show the error fetching ....
2. Cannot click backspace 
3. Bottom Overflow (solved but for those also experiencing the same thing --> SingleChildScrollView) 
https://flutter-examples.com/flutter-bottom-overflowed-by-pixels-keyboard/ 

#### for testing purposes
for userone usertwo userthree@test.com the password is all 123456, 