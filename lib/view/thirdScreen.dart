import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spicemoney_app/controller/provider.dart';
import 'package:spicemoney_app/functions/widgetFunction.dart';
import 'package:spicemoney_app/navigations/navigationAnimation.dart';
import 'package:spicemoney_app/styles/colors.dart';
import 'package:spicemoney_app/view/secondScreen.dart';

class ThirdScreen extends StatefulWidget {
  @override
  _ThirdScreenState createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<Handler>(builder: (context, handler, _) {
        return SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              buildSizedBoxHeight(10),
              Text(
                "${handler.articleModel[0].thankyouScreens.title}",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 19),
              ),
              buildSizedBoxHeight(50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context, FadeNavigation(widget: SecondScreen()));
                    },
                    child: Text(
                      'again',
                      style: TextStyle(fontSize: 20),
                    ),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(buttonColor)),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                  ),
                  IconButton(icon: Icon(Icons.share), onPressed: () {})
                ],
              )
            ],
          ),
        );
      }),
    );
  }
}
