class Category {
  int? id;
  String? name;
  String? description;
  int? createdBy;
  String? createdAt;
  String? updatedAt;
  Null deletedBy;
  Null deletedAt;

  Category(
      {this.id,
      this.name,
      this.description,
      this.createdBy,
      this.createdAt,
      this.updatedAt,
      this.deletedBy,
      this.deletedAt});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedBy = json['deleted_by'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['created_by'] = this.createdBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_by'] = this.deletedBy;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}
