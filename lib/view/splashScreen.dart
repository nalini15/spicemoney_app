import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spicemoney_app/controller/provider.dart';
import 'package:http/http.dart' as http;
import 'package:spicemoney_app/functions/widgetFunction.dart';
import 'package:spicemoney_app/model/surveyModel.dart';
import 'package:spicemoney_app/navigations/navigationAnimation.dart';
import 'package:spicemoney_app/view/firstScreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();

  Future<void> getData(BuildContext context) async {
    final pro = Provider.of<Handler>(context, listen: false);
    if (pro.articleModel.isEmpty) {
      final res = await pro.getData();
      if (!res['status']) {
        showSnack(context, res['msg'], _scaffoldkey);
      } else {
        Navigator.push(context, FadeNavigation(widget: FirstScreen()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Handler>(context);
    return Scaffold(
        body: FutureBuilder(
      // future: getData(context),
      future: user.articleModel.isEmpty ? getData(context) : null,
      builder: (context, snapshot) =>
          snapshot.connectionState == ConnectionState.waiting
              ? Container(
                  child: CircularProgressIndicator(),
                )
              : Consumer<Handler>(
                  builder: (con, userPro, _) => userPro.articleModel.isEmpty
                      ? Center(
                          child: Text("No Data!",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                        )
                      : Container(),
                ),
    ));
  }
}
