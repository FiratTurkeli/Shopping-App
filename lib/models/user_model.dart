class User {
  String? name;
  String? password;
  String? email;
  String? id;
  String? token;

  User({this.name, this.password, this.email, this.id, this.token});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    password = json['password'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['password'] = this.password;
    data['email'] = this.email;
    return data;
  }
}

