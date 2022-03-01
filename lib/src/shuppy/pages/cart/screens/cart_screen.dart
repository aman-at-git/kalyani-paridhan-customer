part of '../cart_page.dart';

class ShuppyCartScreen extends StatefulWidget {
  const ShuppyCartScreen({Key? key}) : super(key: key);

  @override
  _ShuppyCartScreenState createState() => _ShuppyCartScreenState();
}

class _ShuppyCartScreenState extends State<ShuppyCartScreen> {
  int? _total = 0;
  int _shipping = 0;

  @override
  Widget build(BuildContext context) {
    /// Sum per product
    cartList
        .map((e) {
          return e.mrp! * e.quantity;
        })
        .toList()
        .fold<int>(0, (int p, c) => _total = p + c);

    cartList
        .map((e) {
      return   (e.mrp! * e.quantity )- (e.price! * e.quantity );
    })
        .toList()
        .fold<int>(0, (int p, c) => _shipping = p + c);

    return Scaffold(
      appBar: CustomAppBar(
        context,
        enableLeading: false,
        title: AppLocalizations.of(context)!.shopping_cart,
      ),
      body: (cartList.isNotEmpty)
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: Const.margin),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: cartList.length,
                      itemBuilder: (context, index) {
                        final product = cartList[index];
                        return _BuildCartCard(
                          product: product,
                          onPressedAdd: () {
                            setState(() {
                              product.quantity = max(1, product.quantity + 1);
                              FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(FirebaseAuth.instance.currentUser!.uid)
                                  .collection('cart')
                                  .get()
                                  .then((QuerySnapshot querySnapshot) {
                                querySnapshot.docs.forEach((doc) {
                                  if(doc['id'].toString()==product.id.toString()){
                                    FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(FirebaseAuth.instance.currentUser!.uid)
                                        .collection('cart')
                                        .doc(doc.id).update(<String, String>{
                                      'qty': product.quantity.toString()
                                    });
                                  }
                                });
                              });
                            });
                          },
                          onPressedRemove: () {
                            if(product.quantity>1){
                              setState(() {
                                product.quantity = min(50, product.quantity - 1);
                                FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(FirebaseAuth.instance.currentUser!.uid)
                                    .collection('cart')
                                    .get()
                                    .then((QuerySnapshot querySnapshot) {
                                  querySnapshot.docs.forEach((doc) {
                                    if(doc['id'].toString()==product.id.toString()){
                                      FirebaseFirestore.instance
                                          .collection('users')
                                          .doc(FirebaseAuth.instance.currentUser!.uid)
                                          .collection('cart')
                                          .doc(doc.id).update(<String, String>{
                                        'qty': product.quantity.toString()
                                      });
                                    }
                                  });
                                });
                              });
                            }
                          },
                          onPressedDelete: () {
                            setState(() {
                              cartList.removeAt(index);
                              FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(FirebaseAuth.instance.currentUser!.uid)
                                  .collection('cart')
                                  .get()
                                  .then((QuerySnapshot querySnapshot) {
                                querySnapshot.docs.forEach((doc) {
                                  if(doc['id'].toString()==product.id.toString()){
                                    FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(FirebaseAuth.instance.currentUser!.uid)
                                        .collection('cart')
                                        .doc(doc.id).delete();
                                  }
                                });
                              });
                            });
                          },
                        );
                      },
                    ),
                  ),
                  _BodySection(
                    totalPrice: _total!,
                    shippingCost: _shipping,
                    total: _total! - _shipping,
                    onCheckoutTap: () {
                      Get.toNamed<dynamic>(
                        ShuppyRoutes.checkout,
                        arguments: CheckoutArgument(
                          total: _total,
                          shipping: _shipping,
                          products: cartList,
                        ),
                      );
                    },
                  ),
                ],
              ),
            )
          : EmptySection(
              image: Illustrations.emptyCart,
              title: AppLocalizations.of(context)!.shopping_cart_is_empty,
            ),
    );
  }
}
