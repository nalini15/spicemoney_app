import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spicemoney_app/model/surveyModel.dart';

class Handler extends ChangeNotifier {
  List<WelcomeModel> articleModel = [];
  List<WelcomeModel> get articleModelData {
    return [...articleModel];
  }

  List<Map<String, dynamic>> formData = [];
  Future<Map<String, dynamic>> getData() async {
    final response = await http.get('https://getx-todo-server.herokuapp.com');
    final resp = json.decode(response.body);
    articleModel.add(WelcomeModel.fromJson(resp));
    print(articleModel.length);
    notifyListeners();
    if (response.statusCode == 200) {
      articleModel[0].fields.forEach((element) {
        if (element.type == "yes_no") {
          formData.add({"field_id": element.id, "field_data": true});
        } else if (element.type == "rating") {
          formData.add({
            "field_id": element.id,
            "field_data": double.parse(element.properties.steps.toString())
          });
        } else {
          formData.add({"field_id": element.id, "field_data": null});
        }
      });
      return reponseData(true, "Fetched Success!");
    } else {
      throw Exception('Failed to load data');
    }
  }

  populateFormData(int index, dynamic value) {
    formData[index]['field_data'] = value;
    notifyListeners();
  }

  Future<Map<String, dynamic>> postData() async {
    final response = await http.post('https://getx-todo-server.herokuapp.com',
        body: json.encode(formData));

    if (response.statusCode == 200) {
      return reponseData(true, "Upload Success!");
    } else {
      throw Exception('Failed to load data');
    }
  }

  Map<String, dynamic> reponseData(bool status, String msg) {
    return {"msg": msg, "status": status};
  }
}
