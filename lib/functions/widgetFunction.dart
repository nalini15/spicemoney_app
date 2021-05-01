import 'package:flutter/material.dart';

SizedBox buildSizedBoxHeight(int value) {
  return SizedBox(
    height: value.toDouble(),
  );
}

double buildWidth(BuildContext context) => MediaQuery.of(context).size.width;

double buildHeight(BuildContext context) => MediaQuery.of(context).size.height;

void showSnack(
    BuildContext context, stringList, GlobalKey<ScaffoldState> _scaffoldkey,
    [bool isSuccess]) {
  _scaffoldkey.currentState.showSnackBar(SnackBar(
    behavior: SnackBarBehavior.floating,
    elevation: 8,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
    content: Text(
      stringList,
      textAlign: TextAlign.center,
      style: TextStyle(
          fontSize: 13.0,
          fontWeight: FontWeight.bold,
          color: isSuccess == null ? Colors.red : Colors.green),
    ),
    duration: Duration(seconds: 2),
    backgroundColor: Colors.black87,
  ));
}