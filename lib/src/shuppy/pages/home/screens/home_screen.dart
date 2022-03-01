part of '../home_page.dart';

class ShuppyHomeScreen extends StatefulWidget {
  const ShuppyHomeScreen({Key? key}) : super(key: key);

  @override
  _ShuppyHomeScreenState createState() => _ShuppyHomeScreenState();
}

List<ProductModel> productList = [];
List<ProductModel> _recentList = [];
List<ProductModel> allProdList = [];
List<ProductModel> recentMenList = [];
List<ProductModel> recentWomenList = [];
List<ProductModel> mostDiscountMenList = [];
List<ProductModel> mostDiscountWomenList = [];
// List<ProductModel> men60Disc = [];
List<FavoriteModel> favoriteList = [];
List<ProductModel> cartList = [];
List<OrderModel> orderList = [];
String userName = '';
String userEmail = '';
String userPhone = '';

class _ShuppyHomeScreenState extends State<ShuppyHomeScreen> {
  int _carouselIndex = 0;

  @override
  void initState() {
    super.initState();

    //used to search in search page
    if(allProdList.isEmpty){
      getAllProdList();
    }

    if(recentMenList.isEmpty){
      getRecentMenList();
    }

    if(recentWomenList.isEmpty){
      getRecentWomenList();
    }

    if(mostDiscountMenList.isEmpty){
      getMostDiscountProdMenList();
    }

    if(mostDiscountWomenList.isEmpty){
      getMostDiscountProdWomenList();
    }

    // if(men60Disc.isEmpty){
    //   getMen60Disc();
    // }

    if(favoriteList.isEmpty){
      getAllFavorite();
    }
    if(cartList.isEmpty){
      getAllCart();
    }
    if(orderList.isEmpty){
      getAllOrders();
    }
    if(userName == ''){
      getUserInfo();
    }
  }



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        body: Stack(
          children: [
            ListView(
              children: [
                const SizedBox(height: 60),
                _BuildCarouselSwiper(
                  itemCount: LocalList.carouselSwiperList(),
                  carouselIndex: _carouselIndex,
                  onIndexChanged: (val) {
                    setState(() => _carouselIndex = val);
                  },
                ),
                const SizedBox(height: Const.space25),
                _CategorySection(
                  itemCount: LocalList.topCategoryList(),
                ),
                const SizedBox(height: Const.space15),
                Visibility(
                  visible: recentMenList.isNotEmpty,
                  child: ScrollableSection(
                    label: 'Recently Added Men',
                    itemCount: recentMenList,
                    onViewAllTap: () => Get.toNamed<dynamic>(
                      ShuppyRoutes.browseProduct,
                      arguments: BrowseArgument(
                          cat: '',
                          label: 'Recently Added',
                          query: FirebaseFirestore.instance
                              .collection('recent')
                              .orderBy('time', descending: true)),
                    ),
                    query: FirebaseFirestore.instance
                        .collection('recent')
                        .orderBy('time', descending: true),
                  ),
                ),
                Visibility(
                  visible: recentWomenList.isNotEmpty,
                  child: ScrollableSection(
                    label: 'Recently Added Women',
                    itemCount: recentWomenList,
                    onViewAllTap: () => Get.toNamed<dynamic>(
                      ShuppyRoutes.browseProduct,
                      arguments: BrowseArgument(
                          cat: '',
                          label: 'Recently Added Women',
                          query: FirebaseFirestore.instance
                              .collection('recent')
                              .orderBy('time', descending: true)),
                    ),
                    query: FirebaseFirestore.instance
                        .collection('recent')
                        .orderBy('time', descending: true),
                  ),
                ),
                Visibility(
                  visible: mostDiscountMenList.isNotEmpty,
                  child: ScrollableSection(
                    label: 'Men Huge Discounts',
                    itemCount: mostDiscountMenList,
                    onViewAllTap: () =>
                        Get.toNamed<dynamic>(ShuppyRoutes.browseProduct,
                            arguments: BrowseArgument(
                              cat: '',
                              label: 'Men Huge Discounts',
                              query: FirebaseFirestore.instance
                                  .collection('recent')
                                  .where('category', isEqualTo: 'men')
                                  .where('discount', isLessThan: 60.999)
                                  .orderBy('discount', descending: true),
                            )),
                    query: FirebaseFirestore.instance
                        .collection('recent')
                        .where('category', isEqualTo: 'men')
                        .where('discount', isLessThan: 60.999)
                        .orderBy('discount', descending: true),
                  ),
                ),
                Visibility(
                  visible: mostDiscountWomenList.isNotEmpty,
                  child: ScrollableSection(
                    label: 'Women Huge Discounts',
                    itemCount: mostDiscountWomenList,
                    onViewAllTap: () =>
                        Get.toNamed<dynamic>(ShuppyRoutes.browseProduct,
                            arguments: BrowseArgument(
                              cat: '',
                              label: 'Women Huge Discounts',
                              query: FirebaseFirestore.instance
                                  .collection('recent')
                                  .where('category', isEqualTo: 'men')
                                  .where('discount', isLessThan: 60.999)
                                  .orderBy('discount', descending: true),
                            )),
                    query: FirebaseFirestore.instance
                        .collection('recent')
                        .where('category', isEqualTo: 'men')
                        .where('discount', isLessThan: 60.999)
                        .orderBy('discount', descending: true),
                  ),
                ),
              ],
            ),
            _CustomAppBar(
              onSearchTap: () {
                showSearch<dynamic>(
                    context: context, delegate: ShuppySearchScreen());
              },
              onChatTap: () {},
              onNotificationTap: () {
                Get.toNamed<dynamic>(ShuppyRoutes.notification);
              },
            ),
          ],
        ),
      ),
    );
  }

  int getAllProdList() {
    _recentList.clear();
    Query q = FirebaseFirestore.instance
        .collection('recent')
        .orderBy('time', descending: true);
    q.get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        setState(() {
          _recentList.add(
            ProductModel(
                id: int.parse(doc['id'].toString()),
                name: doc['name'].toString(),
                price: int.parse(doc['price'].toString()),
                mrp: int.parse(doc['mrp'].toString()),
                rating: 0,
                description: doc['desc'].toString(),
                images: convertListToStringList(doc['links']),
                sizes: convertListToStringList(doc['sizes'])
            ),
          );
        });
      });
    });
    return 0;
  }

  int getRecentMenList(){
    recentMenList.clear();
    FirebaseFirestore.instance
        .collection('recent')
        .where('category', isEqualTo: 'men')
        .orderBy('time', descending: true)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        setState(() {
          recentMenList.add(
            ProductModel(
                id: int.parse(doc['id'].toString()),
                name: doc['name'].toString(),
                price: int.parse(doc['price'].toString()),
                mrp: int.parse(doc['mrp'].toString()),
                rating: 0,
                description: doc['desc'].toString(),
                images: convertListToStringList(doc['links']),
                sizes: convertListToStringList(doc['sizes'])),
          );
        });
      });
    });
    return 0;
  }

  int getRecentWomenList(){
    recentWomenList.clear();
    FirebaseFirestore.instance
        .collection('recent')
        .where('category', isEqualTo: 'women')
        .orderBy('time', descending: true)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        setState(() {
          recentWomenList.add(
            ProductModel(
                id: int.parse(doc['id'].toString()),
                name: doc['name'].toString(),
                price: int.parse(doc['price'].toString()),
                mrp: int.parse(doc['mrp'].toString()),
                rating: 0,
                description: doc['desc'].toString(),
                images: convertListToStringList(doc['links']),
                sizes: convertListToStringList(doc['sizes'])),
          );
        });
      });
    });
    return 0;
  }

  int getMostDiscountProdMenList() {
    mostDiscountMenList.clear();
    FirebaseFirestore.instance
        .collection('recent')
        .where('category', isEqualTo: 'men')
        .orderBy('discount', descending: true)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        setState(() {
          mostDiscountMenList.add(
            ProductModel(
                id: int.parse(doc['id'].toString()),
                name: doc['name'].toString(),
                price: int.parse(doc['price'].toString()),
                mrp: int.parse(doc['mrp'].toString()),
                rating: 0,
                description: doc['desc'].toString(),
                images: convertListToStringList(doc['links']),
                sizes: convertListToStringList(doc['sizes'])),
          );
        });
      });
    });
    return 0;
  }

  int getMostDiscountProdWomenList() {
    mostDiscountWomenList.clear();
    FirebaseFirestore.instance
        .collection('recent')
        .where('category', isEqualTo: 'women')
        .orderBy('discount', descending: true)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        setState(() {
          mostDiscountWomenList.add(
            ProductModel(
                id: int.parse(doc['id'].toString()),
                name: doc['name'].toString(),
                price: int.parse(doc['price'].toString()),
                mrp: int.parse(doc['mrp'].toString()),
                rating: 0,
                description: doc['desc'].toString(),
                images: convertListToStringList(doc['links']),
                sizes: convertListToStringList(doc['sizes'])),
          );
        });
      });
    });
    return 0;
  }

  // int getMen60Disc() {
  //   men60Disc.clear();
  //   FirebaseFirestore.instance
  //       .collection('recent')
  //       .where('category', isEqualTo: 'men')
  //       .where('discount', isLessThan: 60.999)
  //       .orderBy('discount', descending: true)
  //       .get()
  //       .then((QuerySnapshot querySnapshot) {
  //     querySnapshot.docs.forEach((doc) {
  //       setState(() {
  //         men60Disc.add(
  //           ProductModel(
  //               id: int.parse(doc['id'].toString()),
  //               name: doc['name'].toString(),
  //               price: int.parse(doc['price'].toString()),
  //               mrp: int.parse(doc['mrp'].toString()),
  //               rating: 0,
  //               description: doc['desc'].toString(),
  //               images: convertListToStringList(doc['links']),
  //               sizes: convertListToStringList(doc['sizes'])),
  //         );
  //       });
  //     });
  //   });
  //   return 0;
  // }

  void getAllFavorite() {
    favoriteList.clear();
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('favourite')
        .orderBy('time', descending: true)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        setState(() {
          FirebaseFirestore.instance
              .collection('recent')
              .where('id', isEqualTo: doc['id'].toString())
              .get()
              .then((QuerySnapshot querySnapshot) {
            querySnapshot.docs.forEach((doc2) {
              setState(() {
                favoriteList.insert(0,
                  FavoriteModel(
                      id: int.parse(doc['id'].toString()),
                      product: ProductModel(
                          id: int.parse(doc['id'].toString()),
                          name: doc2['name'].toString(),
                          price: int.parse(doc2['price'].toString()),
                          mrp: int.parse(doc2['mrp'].toString()),
                          rating: 0,
                          description: doc2['desc'].toString(),
                          images: convertListToStringList(doc2['links']),
                          sizes: convertListToStringList(doc2['sizes'])),
                      isLiked: true),
                );
              });
            });
          });
        });
      });
    });
  }

  void getAllCart() {
    cartList.clear();
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('cart')
        .orderBy('time', descending: true)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        setState(() {
          FirebaseFirestore.instance
              .collection('recent')
              .where('id', isEqualTo: doc['id'].toString())
              .get()
              .then((QuerySnapshot querySnapshot) {
            querySnapshot.docs.forEach((doc2) {
              setState(() {
                cartList.insert(0, ProductModel(
                    id: int.parse(doc['id'].toString()),
                    quantity: int.parse(doc['qty'].toString()),
                    name: doc2['name'].toString(),
                    price: int.parse(doc2['price'].toString()),
                    mrp: int.parse(doc2['mrp'].toString()),
                    rating: 0,
                    description: doc2['desc'].toString(),
                    images: convertListToStringList(doc2['links']),
                    sizes: convertListToStringList(doc2['sizes']),
                    size: doc['size'].toString()
                ));
              });
            });
          });
        });
      });
    });
  }

  void getAllOrders(){
    orderList.clear();
    FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).collection('orders').orderBy('time', descending: true).get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        setState(() {
          List<ProductModel> temp = [];
          FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).collection('orders').doc(doc.id).collection('items').get().then((QuerySnapshot querySnapshot) {
            querySnapshot.docs.forEach((doc2) {
              List<String> t = [];
              t.add(doc2['img'].toString());
              temp.add(ProductModel(
                  id: int.parse(doc2['id'].toString()),
                  name: doc2['name'].toString(),
                  price: int.parse(doc2['price'].toString()),
                  quantity: int.parse(doc2['qty'].toString()),
                  size: doc2['size'].toString(),
                  images: t
              ));
            });
          }).whenComplete((){
            setState(() {
              orderList.insert(0, OrderModel(
                  id: int.parse(doc['id'].toString()),
                  products: temp,
                  totalOfAllProduct: int.parse(doc['mrp'].toString()),
                  shipping: int.parse(doc['mrp'].toString()) - int.parse(doc['price'].toString()),
                  total: int.parse(doc['price'].toString()),
              ));
            });
          });
          // FirebaseFirestore.instance
          //     .collection('recent')
          //     .where('id', isEqualTo: doc['id'].toString())
          //     .get()
          //     .then((QuerySnapshot querySnapshot) {
          //   querySnapshot.docs.forEach((doc2) {
          //     setState(() {
          //       cartList.insert(0, ProductModel(
          //           id: int.parse(doc['id'].toString()),
          //           quantity: int.parse(doc['qty'].toString()),
          //           name: doc2['name'].toString(),
          //           price: int.parse(doc2['price'].toString()),
          //           mrp: int.parse(doc2['mrp'].toString()),
          //           rating: 0,
          //           description: doc2['desc'].toString(),
          //           images: convertListToStringList(doc2['links']),
          //           sizes: convertListToStringList(doc2['sizes']),
          //           size: doc['size'].toString()
          //       ));
          //     });
          //   });
          // });
        });
      });
    });
  }

  Future<void> getUserInfo() async {
    final collection = FirebaseFirestore.instance.collection('users');
    final docSnapshot = await collection.doc(FirebaseAuth.instance.currentUser!.uid).get();
    if (docSnapshot.exists) {
      var data = docSnapshot.data();
      userName = data!['name'].toString();
      userEmail = data['email'].toString();
      userPhone = data['phone'].toString();
  }}

  List<String> convertListToStringList(dynamic link) {
    final links = <String>[];
    for (final i in link) {
      links.add(i.toString());
    }
    return links;
  }
}
