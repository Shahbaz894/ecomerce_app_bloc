class FavoriteProductModel {
  int? id;
  String? title;
  double? price;
  String? image;
  // bool isFavorite=false; // New property to indicate whether the product is a favorite or not

  FavoriteProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.image,
    // this.isFavorite = false, // Default to false
  });

  FavoriteProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    price = (json['price'] as num).toDouble();
    image = json['image'];
    //isFavorite = json['is_favorite'] ?? false; // Assume 'is_favorite' key in JSON
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['price'] = this.price;
    data['image'] = this.image;
   // data['is_favorite'] = this.isFavorite; // Include 'is_favorite' in JSON
    return data;
  }
}
