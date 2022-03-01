part of '../product_page.dart';

class ShuppyFullScreen extends StatefulWidget {
  final ProductArgument arg;

  const ShuppyFullScreen({Key? key, required this.arg}) : super(key: key);

  @override
  _ShuppyFullScreenState createState() => _ShuppyFullScreenState();
}

class _ShuppyFullScreenState extends State<ShuppyFullScreen> with TickerProviderStateMixin{

  late final AnimationController controller = AnimationController(
    duration: const Duration(milliseconds: 350),
    vsync: this,
  );

  Tween<double> tween = Tween(begin: 0.75, end: 2);
  late ProductArgument args;
  bool _isLiked = false;
  ProductModel? product;

  int _addToCartCounter = 0;
  int _imageIndex = 0;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    shakeAnimation = CurvedAnimation(
      parent: controller,
      curve: Curves.easeIn,
    );
    super.initState();
    if (widget.arg.query == FirebaseFirestore.instance.collection('xyz')) {
      args = Get.arguments as ProductArgument;
    } else {
      args = widget.arg;
    }
    product = args.product;
    final favorite = favoriteList.singleWhere((e) => e.id == product!.id, orElse: () => FavoriteModel());
    _isLiked = favorite.isLiked;
    final cart = cartList.singleWhere((e) => e.id == product!.id, orElse: () => ProductModel(quantity: 0));
    _addToCartCounter = cart.quantity;
    controller.forward(from: 10);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Column(
          children: [
            _ImagesSlider(
              product: product!,
              imageIndex: _imageIndex,
              onIndexChanged: (v) {
                setState(() => _imageIndex = v);
              },
            )
          ],
        ),
      ),
    );
  }
}
