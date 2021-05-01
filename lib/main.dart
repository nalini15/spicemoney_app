import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spicemoney_app/controller/provider.dart';
import 'package:spicemoney_app/view/firstScreen.dart';
import 'package:spicemoney_app/view/splashScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Handler()),
      ],
      builder: (con, _) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SplashScreen(),
      ),
    );
  }
}
