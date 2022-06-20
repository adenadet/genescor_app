class Product {
  //'', 'unit_price', 'brand', 'category
  int? id;
  String? name;
  double? price;
  String? brand;
  String? category;

  Product({this.id, this.name, this.price, this.brand, this.category});

  //function to convert json data to user model
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      price: json['unit_price'],
      brand: json['brand'] ?? 'Not Included',
      category: json['category'] ?? 'Not Specified',
    );
  }
}
