class WelcomeModel {
  String title;
  WelcomeScreen welcomeScreen;
  ThankyouScreens thankyouScreens;
  List<Fields> fields;

  WelcomeModel(
      {this.title, this.welcomeScreen, this.thankyouScreens, this.fields});

  WelcomeModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    welcomeScreen = json['welcome_screen'] != null
        ? new WelcomeScreen.fromJson(json['welcome_screen'])
        : null;
    thankyouScreens = json['thankyou_screens'] != null
        ? new ThankyouScreens.fromJson(json['thankyou_screens'])
        : null;
    if (json['fields'] != null) {
      fields = new List<Fields>();
      json['fields'].forEach((v) {
        fields.add(new Fields.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    if (this.welcomeScreen != null) {
      data['welcome_screen'] = this.welcomeScreen.toJson();
    }
    if (this.thankyouScreens != null) {
      data['thankyou_screens'] = this.thankyouScreens.toJson();
    }
    if (this.fields != null) {
      data['fields'] = this.fields.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WelcomeScreen {
  String title;
  String description;

  WelcomeScreen({this.title, this.description});

  WelcomeScreen.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    return data;
  }
}

class ThankyouScreens {
  String title;

  ThankyouScreens({this.title});

  ThankyouScreens.fromJson(Map<String, dynamic> json) {
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    return data;
  }
}

class Fields {
  String id;
  String title;
  Validations validations;
  String type;
  Properties properties;

  Fields({this.id, this.title, this.validations, this.type, this.properties});

  Fields.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    validations = json['validations'] != null
        ? new Validations.fromJson(json['validations'])
        : null;
    type = json['type'];
    properties = json['properties'] != null
        ? new Properties.fromJson(json['properties'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    if (this.validations != null) {
      data['validations'] = this.validations.toJson();
    }
    data['type'] = this.type;
    if (this.properties != null) {
      data['properties'] = this.properties.toJson();
    }
    return data;
  }
}

class Validations {
  bool required;

  Validations({this.required});

  Validations.fromJson(Map<String, dynamic> json) {
    required = json['required'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['required'] = this.required;
    return data;
  }
}

class Properties {
  bool alphabeticalOrder;
  List<Choices> choices;
  int steps;
  String structure;

  Properties(
      {this.alphabeticalOrder, this.choices, this.steps, this.structure});

  Properties.fromJson(Map<String, dynamic> json) {
    alphabeticalOrder = json['alphabetical_order'];
    if (json['choices'] != null) {
      choices = new List<Choices>();
      json['choices'].forEach((v) {
        choices.add(new Choices.fromJson(v));
      });
    }
    steps = json['steps'];
    structure = json['structure'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['alphabetical_order'] = this.alphabeticalOrder;
    if (this.choices != null) {
      data['choices'] = this.choices.map((v) => v.toJson()).toList();
    }
    data['steps'] = this.steps;
    data['structure'] = this.structure;
    return data;
  }
}

class Choices {
  String label;

  Choices({this.label});

  Choices.fromJson(Map<String, dynamic> json) {
    label = json['label'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['label'] = this.label;
    return data;
  }
}
