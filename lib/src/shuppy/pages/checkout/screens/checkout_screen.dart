part of '../checkout_page.dart';

class ShuppyCheckoutScreen extends StatefulWidget {
  const ShuppyCheckoutScreen({Key? key}) : super(key: key);

  @override
  _ShuppyCheckoutScreenState createState() => _ShuppyCheckoutScreenState();
}

class _ShuppyCheckoutScreenState extends State<ShuppyCheckoutScreen> {
  CheckoutArgument? _args;
  Random orderId = Random();
  List<ProductModel?> myCart = [];

  @override
  void initState() {
    super.initState();
    _args = Get.arguments as CheckoutArgument;
    myCart.addAll(_args!.products!);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: CustomAppBar(
        context,
        title: AppLocalizations.of(context)!.transaction_details,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Const.margin),
        child: Column(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomShakeTransition(
                    child: Text(
                      AppLocalizations.of(context)!.product_ordered,
                      style: theme.textTheme.bodyText1,
                    ),
                  ),
              const      SizedBox(height: Const.space8),
                  _BuildProductOrderList(args: _args),
               // TODO: address for delivery
               // const     SizedBox(height: Const.space25),
               //    CustomShakeTransition(
               //      child: Text(
               //        AppLocalizations.of(context)!.shipping_address,
               //        style: theme.textTheme.bodyText1,
               //      ),
               //    ),
               //  const    SizedBox(height: Const.space8),
               //    _BuildDestinationAddress(),
                ],
              ),
            ),
            _BodySection(
              totalPrice: _args!.total!,
              shippingCost: _args!.shipping!,
              total: _args!.total! - _args!.shipping!,
              onCheckoutTap: () {
                Dialogs.labelDialog(
                  context,
                  title: 'Are you sure you want to confirm order?',
                  primaryButtonLabel: AppLocalizations.of(context)!.yes,
                  onPrimaryButtonTap: () {
                    var randomOrderID = DateTime.now().millisecondsSinceEpoch.toString();
                    orderList.add(
                      OrderModel(
                        id: int.parse(randomOrderID),
                        shipping: _args!.shipping,
                        products: myCart,
                        totalOfAllProduct: _args!.total,
                        total: _args!.total! - _args!.shipping!
                      ),
                    );

                    CollectionReference c = FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).collection('orders');
                    var docId = c.doc().id;
                    c.doc(docId).set(<String, dynamic>{
                      'id': randomOrderID,
                      'time': FieldValue.serverTimestamp(),
                      'mrp': _args!.total,
                      'price': _args!.total! - _args!.shipping!
                    });
                    for(var i in cartList){
                      c.doc(docId).collection('items').doc().set(<String, dynamic>{
                        'id': i.id,
                        'name': i.name,
                        'size': i.size,
                        'qty': i.quantity,
                        'price': i.price,
                        'img': i.images![0]
                      });
                    }

                    CollectionReference c2 = FirebaseFirestore.instance.collection('orders');
                    var docId2 = c2.doc().id;
                    c2.doc(docId2).set(<String, dynamic>{
                      'userid': FirebaseAuth.instance.currentUser!.uid,
                      'id': randomOrderID,
                      'time': FieldValue.serverTimestamp(),
                      'mrp': _args!.total! - _args!.shipping!,
                      'price': _args!.total
                    });
                    for(var i in cartList){
                      c2.doc(docId2).collection('items').doc().set(<String, dynamic>{
                        'id': i.id,
                        'name': i.name,
                        'size': i.size,
                        'qty': i.quantity,
                        'price': i.price,
                        'img': i.images![0]
                      });
                    }

                    cartList.clear();
                    FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).collection('cart').snapshots().forEach((element) {
                      for (QueryDocumentSnapshot snapshot in element.docs) {
                        snapshot.reference.delete();
                      }
                    });

                    Get.back<dynamic>();
                    // ignore: cascade_invocations
                    Get.offNamed<dynamic>(ShuppyRoutes.checkoutSuccess);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
