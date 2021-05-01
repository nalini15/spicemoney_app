import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:spicemoney_app/controller/provider.dart';
import 'package:spicemoney_app/functions/widgetFunction.dart';
import 'package:spicemoney_app/model/starRatingModel.dart';
import 'package:spicemoney_app/model/surveyModel.dart';
import 'package:spicemoney_app/navigations/navigationAnimation.dart';
import 'package:spicemoney_app/styles/colors.dart';
import 'package:spicemoney_app/view/thirdScreen.dart';

class SecondScreen extends StatefulWidget {
  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  List<bool> isSelected;
  double rating = 3.5;
  Map<String, dynamic> formData = {
    "name": "",
    "age": "",
    "email": "",
    "date": "",
    "phone": "",
    "isYes": ""
  };

  DateTime selectedDate = DateTime.now();

  double xAlign;
  Color loginColor;
  Color signInColor;

  Future<void> _selectDate(
      BuildContext context, Handler handler, int index) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      handler.populateFormData(index, DateFormat('yyyy-MM-dd').format(picked));
    }
  }

  @override
  void initState() {
    isSelected = [true, false];
    super.initState();
  }

  void submitForm(BuildContext context) async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      final basicInfo = Provider.of<Handler>(context, listen: false);
      _formKey.currentState.save();

      final res = await basicInfo.postData();
      if (res['status']) {
        Navigator.push(context, FadeNavigation(widget: ThirdScreen()));
      } else {
        showSnack(context, res['msg'], _scaffoldkey);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Survey',
          style: TextStyle(color: textColor),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Consumer<Handler>(
            builder: (con, handler, _) => Center(
              child: Column(
                children: [
                  buildSizedBoxHeight(25),
                  Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Form(
                        key: _formKey,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: List.generate(
                                handler.articleModelData[0].fields.length,
                                (index) {
                              final data =
                                  handler.articleModelData[0].fields[index];
                              if (data.type == "short_text" ||
                                  data.type == "number" ||
                                  data.type == "email" ||
                                  data.type == "phone_number") {
                                return Container(
                                  margin: EdgeInsets.symmetric(vertical: 10),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: textColor)),
                                  child: TextFormField(
                                      //initialValue: basic.fname,
                                      autocorrect: true,
                                      style: TextStyle(fontSize: 15),
                                      keyboardType: data.type == "number" ||
                                              data.type == "phone_number"
                                          ? TextInputType.number
                                          : TextInputType.text,
                                      onSaved: (val) {
                                        handler.formData[index]['field_data'] =
                                            val.trimLeft().trimRight();
                                      },
                                      validator: (val) {
                                        if (data.validations.required) {
                                          if (val.isEmpty) {
                                            return "Please enter a value";
                                          }
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        errorStyle: TextStyle(
                                          color: textColor,
                                        ),
                                        hintText: data.title,
                                        hintStyle: TextStyle(color: hintText),
                                        contentPadding: EdgeInsets.fromLTRB(
                                            10.0, 15.0, 10.0, 15.0),
                                        isDense: true,
                                      )),
                                );
                              } else if (data.type == "yes_no") {
                                return Column(
                                  children: [
                                    Text(
                                      "${data.title}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      height: 40,
                                      margin:
                                          EdgeInsets.symmetric(vertical: 10),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 1, color: Colors.black)),
                                      child: Row(
                                        children: [
                                          Expanded(
                                              child: GestureDetector(
                                            onTap: () {
                                              handler.populateFormData(
                                                  index, true);
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: handler.formData[index]
                                                              ['field_data'] ==
                                                          null
                                                      ? Colors.green
                                                      : handler.formData[index]
                                                              ['field_data']
                                                          ? Colors.green
                                                          : Colors.transparent),
                                              alignment: Alignment.center,
                                              child: Text("Yes"),
                                            ),
                                          )),
                                          Expanded(
                                            child: GestureDetector(
                                              onTap: () {
                                                handler.populateFormData(
                                                    index, false);
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: handler.formData[
                                                                    index][
                                                                'field_data'] ==
                                                            null
                                                        ? Colors.transparent
                                                        : !handler.formData[
                                                                    index]
                                                                ['field_data']
                                                            ? Colors.green
                                                            : Colors
                                                                .transparent),
                                                alignment: Alignment.center,
                                                child: Text("No"),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              } else if (data.type == "date") {
                                return Container(
                                    margin: EdgeInsets.symmetric(vertical: 10),
                                    width: buildWidth(context) / 1.1,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: textColor)),
                                    child: TextFormField(
                                      // initialValue:
                                      //     "${handler.formData[index]["field_data"]}",
                                      enabled: true,
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.calendar_today_rounded,
                                          color: textColor,
                                        ),

                                        hintText:
                                            "${handler.formData[index]["field_data"] ?? data.type}",
                                        contentPadding: EdgeInsets.fromLTRB(
                                            10.0, 15.0, 10.0, 15.0),
                                        // hintStyle: TextStyle(color: hintText),
                                      ),
                                      validator: (value) {
                                        if (data.validations.required) {
                                          if (handler.formData[index]
                                                  ['field_data'] ==
                                              null) {
                                            return "Please enter date!";
                                          }
                                        }
                                        return null;
                                      },
                                      onSaved: (val) {
                                        handler.populateFormData(
                                            index,
                                            handler.formData[index]
                                                    ['field_data']
                                                .trimLeft()
                                                .trimRight());
                                      },
                                      onTap: () {
                                        FocusScope.of(context)
                                            .requestFocus(new FocusNode());
                                        _selectDate(context, handler, index);
                                      },
                                    ));
                              } else if (data.type == "rating") {
                                return Column(
                                  children: [
                                    Text(
                                      "${data.title}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    StarRating(
                                      rating: handler.formData[index]
                                              ['field_data'] ??
                                          double.parse(
                                              data.properties.steps.toString()),
                                      onRatingChanged: (rating) => handler
                                          .populateFormData(index, rating),
                                    ),
                                  ],
                                );
                              } else if (data.type == "dropdown") {
                                return Container(
                                    margin: EdgeInsets.symmetric(vertical: 10),
                                    width: buildWidth(context) / 1.1,
                                    decoration:
                                        BoxDecoration(border: Border.all()),
                                    child: DropdownButton<String>(
                                      items: data.properties.choices
                                          .map((element) {
                                        return DropdownMenuItem<String>(
                                          value: element.label,
                                          child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              child: Text(element.label)),
                                        );
                                      }).toList(),
                                      isExpanded: true,
                                      icon: Icon(Icons.arrow_drop_down),
                                      hint: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: TextFormField(
                                            decoration: InputDecoration(
                                              hintText:
                                                  '${handler.formData[index]['field_data'] == null ? data.title : handler.formData[index]['field_data']}',
                                            ),

                                            // "${add?.selectedState ?? "select State"}",
                                            validator: (value) {
                                              if (data.validations.required) {
                                                if (handler.formData[index]
                                                        ['field_data'] ==
                                                    null) {
                                                  return "Please enter ${data.title}!";
                                                }
                                              }
                                              return null;
                                            },
                                            onSaved: (val) {
                                              handler.populateFormData(index,
                                                  val.trimLeft().trimRight());
                                            },
                                          )),
                                      onChanged: (value) {
                                        handler.populateFormData(index, value);
                                      },
                                    ));
                              }
                              return Container();
                            })),
                      )),
                  ElevatedButton(
                    onPressed: () {
                      submitForm(context);
                    },
                    child: Text(
                      'Submit',
                      style: TextStyle(fontSize: 20),
                    ),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(buttonColor)),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget nameField(BuildContext context, String labelText, bool isPassowrd) {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: textColor)),
      child: TextFormField(
          //initialValue: basic.fname,
          autocorrect: true,
          style: TextStyle(fontSize: 15),
          decoration: InputDecoration(
            errorStyle: TextStyle(
              color: textColor,
            ),
            hintText: labelText,
            hintStyle: TextStyle(color: hintText),
            contentPadding: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
            isDense: true,
          )),
    );
  }
}
