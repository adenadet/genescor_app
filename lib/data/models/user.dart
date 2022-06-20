class User {
  int? id;
  String? firstName;
  String? lastName;
  String? image;
  String? email;
  String? token;
  String? sex;
  int? userType;

  User(
      {this.id,
      this.firstName,
      this.lastName,
      this.image,
      this.email,
      this.token,
      this.sex,
      this.userType});

  //function to convert json data to user model
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['user']['id'],
      firstName: json['user']['first_name'],
      lastName: json['user']['last_name'],
      image: json['user']['image'],
      email: json['user']['email'],
      token: json['token'],
      sex: json['sex'],
      userType: json['user']['user_type'],
    );
  }
}
