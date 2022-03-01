part of '../product_page.dart';

class ShuppyProductScreen extends StatefulWidget {
  final ProductArgument arg;

  const ShuppyProductScreen({Key? key, required this.arg}) : super(key: key);

  @override
  _ShuppyProductScreenState createState() => _ShuppyProductScreenState();
}

double animationWidth = 25;
double animationHeight = 25;
Color theColor = Colors.green;

Animation<double>? shakeAnimation;

class _ShuppyProductScreenState extends State<ShuppyProductScreen> with TickerProviderStateMixin{

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
        child: Stack(
          children: [
            _HeaderSection(
              product: product!,
              imageIndex: _imageIndex,
              onIndexChanged: (v) {
                setState(() => _imageIndex = v);
              },
              onImageViewTap: () => showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => _ImagesSlider(
                    product: product!,
                    imageIndex: _imageIndex,
                    onIndexChanged: (v) {
                      setState(() => _imageIndex = v);
                    },
                  )
              ),
            ),
            _BodySection(
              product: product!,
              query: args.query,
              // collectionReference: FirebaseFirestore.instance.collection('products').doc('men').collection('shirt')
            ),
            const _BuildBackNavigationButton(),
            _BuildFloatingActionButton(
              isLiked: _isLiked,
              product: product,
              addToCartCounter: _addToCartCounter,
              onFavoriteTap: () {
                if (_isLiked == true) {
                  setState(() {
                    favoriteList.removeWhere((e) => e.id == product!.id);
                    _isLiked = false;
                    FirebaseFirestore.instance
                        .collection('users')
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .collection('favourite')
                        .get()
                        .then((QuerySnapshot querySnapshot) {
                      querySnapshot.docs.forEach((doc) {
                        setState(() async {
                          await FirebaseFirestore.instance
                              .collection('users')
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .collection('favourite')
                              .doc(doc.id)
                              .delete();
                        });
                      });
                    });
                  });
                } else {
                  setState(() {
                    favoriteList.insert(0,
                      FavoriteModel(
                        id: product!.id,
                        product: product,
                        isLiked: true,
                      ),
                    );
                    setState(() {
                      _isLiked = true;
                    });
                    FirebaseFirestore.instance
                        .collection('users')
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .collection('favourite')
                        .doc()
                        .set(<String, dynamic>{
                      'id': product!.id.toString(),
                      'time': FieldValue.serverTimestamp(),
                    });
                  });
                }
              },
              onCartTap: () {
                if(_addToCartCounter==0){
                  if(selectedSize == '0'){
                    controller.forward(from: 0);
                    Fluttertoast.showToast(
                        msg: "Select Size",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 2,
                        backgroundColor: Colors.black54,
                        textColor: Colors.white,
                        fontSize: 16.0
                    );
                  }else{
                    setState(() {
                      product!.quantity = 1;
                      product!.size = selectedSize;
                      cartList.insert(0, product!);
                      _addToCartCounter++;
                      FirebaseFirestore.instance
                          .collection('users')
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .collection('cart')
                          .doc()
                          .set(<String, dynamic>{
                        'id': product!.id.toString(),
                        'time': FieldValue.serverTimestamp(),
                        'qty': 1.toString(),
                        'size': selectedSize
                      });
                    });
                  }
                }
                else {
                  Get.toNamed<dynamic>(ShuppyRoutes.cart);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
