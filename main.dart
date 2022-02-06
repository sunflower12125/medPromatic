import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hackathon_app/providers/auth.dart';
import 'package:hackathon_app/screens/auth_screen.dart';
import 'package:hackathon_app/screens/authentication.dart';
import 'package:hackathon_app/screens/welcome_carousel_screen.dart';
import 'package:hackathon_app/screens/wrapper.dart';
import 'package:hackathon_app/symptom_checker/symptom_main.dart';
import 'package:hackathon_app/widgets/doctors/specialist_doctor_list.dart';
import 'package:hackathon_app/widgets/doctors/specialist_grid.dart';
import 'package:provider/provider.dart';
import './screens/home_page_screen.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? token;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Auth()),
        ChangeNotifierProvider.value(value: AuthWithEmail()),
        ChangeNotifierProvider.value(value: API())
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'App',
          home: WelcomeCarouselScreen(),
          theme: ThemeData(
            primarySwatch: Colors.blue,
            fontFamily: 'Poppins',
          ),
          routes: {
            HomePageScreen.routeName: (ctx) => HomePageScreen(),
            SpecialistGrid.routeName: (ctx) => SpecialistGrid(),
          }),
    );
  }

  getToken() async {
    token = await FirebaseMessaging.instance.getToken();
    setState(() {
      token = token;
    });
    print(token);
  }
}
