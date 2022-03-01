class ProductModel {
  final int? id;
  final String? name;
  final int? price;
  final int? mrp;
  final double? rating;
  final String? description;
  final List<String>? images;
  String? size;
  int quantity;
  final List<String>? sizes;

  ProductModel({
    this.images,
    this.id,
    this.name,
    this.price,
    this.mrp,
    this.rating,
    this.description,
    this.quantity = 1,
    this.sizes,
    this.size
  });

  ProductModel.fromJson(Map<String, Object?> json)
      : this(
    images: json['images']! as List<String>,
    id: json['id']! as int,
    name: json['name']! as String,
    price: json['price']! as int,
    mrp: json['mrp']! as int,
    description: json['desc']! as String,
    sizes: json['sizes']! as List<String>,
  );

  Map<String, Object?> toJson() {
    return {
      'images': images,
      'id': id,
      'name': name,
      'price': price,
      'mrp': mrp,
      'description': description,
      'sizes': sizes,
    };
  }

}
