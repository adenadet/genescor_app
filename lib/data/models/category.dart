import 'user.dart';

class Category {
  int? id;
  String? name;
  User? creator;

  Category({
    this.id,
    this.name,
    this.creator,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      creator: User(
        id: json['creator']['id'],
        firstName: json['creator']['first_name'],
        lastName: json['creator']['last_name'],
        image: json['creator']['image'],
      ),
    );
  }
}
