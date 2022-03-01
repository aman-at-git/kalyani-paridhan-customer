part of '../search_page.dart';

class _ResultAllProductSection extends StatelessWidget {
  final List<ProductModel>? itemCount;

  const _ResultAllProductSection({Key? key, this.itemCount}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StaggeredGridView.countBuilder(
        crossAxisCount: 4,
        itemCount: itemCount!.length,
        physics: const  ScrollPhysics(),
        shrinkWrap: true,
        padding: const  EdgeInsets.all(18),
        itemBuilder: (BuildContext context, int index) {
          return _BuildProductGridCard(
            product: itemCount![index],
            onPressed: () {
              Get.toNamed<dynamic>(ShuppyRoutes.product, arguments: ProductArgument(product: itemCount![index], query: FirebaseFirestore.instance.collection('recent').orderBy('time', descending: true)));
              // Get.toNamed<dynamic>(ShuppyRoutes.product, arguments: ProductArgument(product: product, );
            },
          );
        },
        staggeredTileBuilder: (int index) =>  const StaggeredTile.fit(2),
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
      ),
    );
  }
}
