part of '../product_page.dart';

class ShuppyBrowseProductScreen extends StatefulWidget {
  const ShuppyBrowseProductScreen({Key? key}) : super(key: key);

  @override
  State<ShuppyBrowseProductScreen> createState() => _ShuppyBrowseProductScreenState();
}

class _ShuppyBrowseProductScreenState extends State<ShuppyBrowseProductScreen> {

  BrowseArgument args = Get.arguments as BrowseArgument;

  @override
  void initState() {
    // getProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: CustomAppBar(context, title: args.label.capitalizeFirst, actions: [
        IconButton(
          icon: const  Icon(FeatherIcons.search),
          color: ColorLight.fontTitle,
          tooltip: AppLocalizations.of(context)!.search,
          onPressed: () {
            showSearch<dynamic>(context: context, delegate: ShuppySearchScreen());
          },
        ),
      ]),
      body: FirestoreQueryBuilder<ProductModel>(
        query: args.query.withConverter<ProductModel>(
          fromFirestore: (snapshot, _) => ProductModel.fromJson(snapshot.data()!),
          toFirestore: (user, _) => user.toJson(),
        ),
        builder: (context, snapshot, _) {
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20),
            itemCount: snapshot.docs.length,
            itemBuilder: (context, index) {
              // if we reached the end of the currently obtained items, we try to
              // obtain more items
              if (snapshot.hasMore && index + 1 == snapshot.docs.length) {
                // Tell FirestoreQueryBuilder to try to obtain more items.
                // It is safe to call this function from within the build method.
                snapshot.fetchMore();
              }

              final user = snapshot.docs[index].data();

              return Container(
                padding: const EdgeInsets.all(8),
                color: Colors.teal[100],
                child: Text('User name is ${user.name}'),
              );
            },
          );
        },
      ));
      // body: StaggeredGridView.countBuilder(
      //   itemCount: productList.length,
      //   crossAxisCount: 4,
      //   staggeredTileBuilder: (int index) => const  StaggeredTile.fit(2),
      //   // mainAxisSpacing: 0,
      //   // crossAxisSpacing: 15,
      //   shrinkWrap: true,
      //   physics:  const ScrollPhysics(),
      //   // padding:  const EdgeInsets.symmetric(horizontal: 18),
      //   itemBuilder: (context, index) {
      //     final product = productList[index];
      //     return _BuildProductGridCard(
      //       product: product,
      //       onPressed: () {
      //         Get.toNamed<dynamic>(ShuppyRoutes.product, arguments: ProductArgument(product: product, query: args.query));
      //         // Get.toNamed<dynamic>(ShuppyRoutes.product, arguments: ProductArgument(product: product, );
      //       },
      //     );
      //   },
      // ),
  }

  dynamic getProducts(){
    setState(() {
      productList.clear();
    });

    args.query.get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        setState(() {
          productList.add(
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
  }
  List<String> convertListToStringList(dynamic link){
    List<String> links = [];
    for(var i in link){
      links.add(i.toString());
    }
    return links;
  }

}
