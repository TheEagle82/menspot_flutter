import 'package:clipboard/clipboard.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'PushNotificationService.dart';
import 'home_page.dart';

late final FirebaseMessaging _messaging;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
/*
  Fluttertoast.showToast(
      msg: "msin2",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 2,
      backgroundColor: Colors.red,
      textColor: Colors.yellow);
      */
  //PushNotificationService pushNotificationService = new PushNotificationService(_messaging);

  await Firebase.initializeApp();
  _messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await _messaging.requestPermission(
    alert: true,
    badge: true,
    provisional: false,
    sound: true,
  );
  String token = (await _messaging.getToken()).toString();

/*
  Fluttertoast.showToast(
      msg: token,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 2,
      backgroundColor: Colors.red,
      textColor: Colors.yellow);

  FlutterClipboard.copy(token);
*/
/*
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    // Parse the message received
    Fluttertoast.showToast(
        msg: (message.notification?.body as String),
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.red,
        textColor: Colors.yellow);
  });
*/
  runApp(MyApp());
}

void registerNotification() async {
  // 1. Initialize the Firebase app
  await Firebase.initializeApp();

  // 2. Instantiate Firebase Messaging
  _messaging = FirebaseMessaging.instance;

  // 3. On iOS, this helps to take the user permissions
  NotificationSettings settings = await _messaging.requestPermission(
    alert: true,
    badge: true,
    provisional: false,
    sound: true,
  );

  String token = (await _messaging.getToken()).toString();
  print("FirebaseMessaging token: $token");

  Fluttertoast.showToast(
      msg: token,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 10,
      backgroundColor: Colors.red,
      textColor: Colors.yellow);

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('User granted permission');
    // TODO: handle the received notifications
  } else {
    print('User declined or has not accepted permission');
  }
}

class MyApp extends StatefulWidget {
  MyApp({super.key});
  // This widget is the root of your application.

  @override
  MenspotState createState() => MenspotState();
}

class MenspotState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      //theme: ThemeData(
      // This is the theme of your application.
      //
      // Try running your application with "flutter run". You'll see the
      // application has a blue toolbar. Then, without quitting the app, try
      // changing the primarySwatch below to Colors.green and then invoke
      // "hot reload" (press "r" in the console where you ran "flutter run",
      // or simply save your changes to "hot reload" in a Flutter IDE).
      // Notice that the counter didn't reset back to zero; the application
      // is not restarted.
      //primarySwatch: Colors.blue,
      //),
      home: HomePage(),
    );
  }
}
