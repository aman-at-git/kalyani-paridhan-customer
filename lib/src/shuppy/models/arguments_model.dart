import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ultimate_bundle/src/shuppy/models/product_model.dart';

class BrowseArgument {
  final String cat;
  final String label;
  final Query query;

  BrowseArgument({required this.query, required this.label, required this.cat});
}

class ProductArgument {
  final ProductModel? product;
  final Query query;

  const ProductArgument({required this.product, required this.query});
}

class CheckoutArgument {
  final List<ProductModel?>? products;
  final int? shipping;
  final int? total;

  const CheckoutArgument({this.products, this.shipping, this.total});
}
