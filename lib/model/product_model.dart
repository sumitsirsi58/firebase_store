class ProductModel {
  String productId;
  String productName;
  String description;
  String address;

  ProductModel({
    required this.productId,
    required this.productName,
    required this.description,
    required this.address,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      productId: json['userId'],
      productName: json['name'],
      description: json['age'],
      address: json['address'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': productId,
      'name': productName,
      'age': description,
      'address': address,
    };
  }
}