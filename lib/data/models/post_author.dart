class Author {
  int? id;
  String? firstName;
  String? middleName;
  String? lastName;
  String? name;
  String? username;
  String? image;
  String? sex;
  String? street;
  String? street2;
  String? city;
  int? areaId;
  int? stateId;
  String? phone;
  String? altPhone;
  String? dob;
  String? joinedAt;
  String? email;
  String? personalEmail;
  String? maritalStatus;
  String? userType;
  String? createdAt;
  String? updatedAt;
  String? deletedBy;
  String? deletedAt;

  Author(
      {this.id,
      this.firstName,
      this.middleName,
      this.lastName,
      this.name,
      this.username,
      this.image,
      this.sex,
      this.street,
      this.street2,
      this.city,
      this.areaId,
      this.stateId,
      this.phone,
      this.altPhone,
      this.dob,
      this.joinedAt,
      this.email,
      this.personalEmail,
      this.maritalStatus,
      this.userType,
      this.createdAt,
      this.updatedAt,
      this.deletedBy,
      this.deletedAt});

  Author.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    middleName = json['middle_name'];
    lastName = json['last_name'];
    name = json['name'];
    username = json['username'];
    image = json['image'];
    sex = json['sex'];
    street = json['street'];
    street2 = json['street2'];
    city = json['city'];
    areaId = json['area_id'];
    stateId = json['state_id'];
    phone = json['phone'];
    altPhone = json['alt_phone'];
    dob = json['dob'];
    joinedAt = json['joined_at'];
    email = json['email'];
    personalEmail = json['personal_email'];
    maritalStatus = json['marital_status'];
    userType = json['user_type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedBy = json['deleted_by'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['middle_name'] = this.middleName;
    data['last_name'] = this.lastName;
    data['name'] = this.name;
    data['username'] = this.username;
    data['image'] = this.image;
    data['sex'] = this.sex;
    data['street'] = this.street;
    data['street2'] = this.street2;
    data['city'] = this.city;
    data['area_id'] = this.areaId;
    data['state_id'] = this.stateId;
    data['phone'] = this.phone;
    data['alt_phone'] = this.altPhone;
    data['dob'] = this.dob;
    data['joined_at'] = this.joinedAt;
    data['email'] = this.email;
    data['personal_email'] = this.personalEmail;
    data['marital_status'] = this.maritalStatus;
    data['user_type'] = this.userType;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_by'] = this.deletedBy;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}
