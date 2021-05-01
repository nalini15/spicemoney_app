import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spicemoney_app/controller/provider.dart';
import 'package:spicemoney_app/functions/widgetFunction.dart';
import 'package:spicemoney_app/navigations/navigationAnimation.dart';
import 'package:spicemoney_app/styles/colors.dart';
import 'package:spicemoney_app/view/secondScreen.dart';

class FirstScreen extends StatefulWidget {
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: Platform.isIOS ? false : true,
        bottom: Platform.isIOS ? false : true,
        child: Consumer<Handler>(builder: (context, handler, _) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 35),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${handler.articleModelData[0].welcomeScreen.title}.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 17),
                ),
                buildSizedBoxHeight(10),
                Text(
                  "${handler.articleModelData[0].welcomeScreen.description}",
                  style: TextStyle(fontSize: 14),
                  textAlign: TextAlign.center,
                ),
                buildSizedBoxHeight(150),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context, FadeNavigation(widget: SecondScreen()));
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(buttonColor)),
                    child: Text(
                      'Start',
                      style: TextStyle(
                          color: buttonText,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ))
              ],
            ),
          );
        }),
      ),
    );
  }
}
