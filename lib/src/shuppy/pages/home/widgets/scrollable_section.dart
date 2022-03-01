part of '../home_page.dart';

class ScrollableSection extends StatelessWidget {
  final List<ProductModel> itemCount;
  final String label;
  final VoidCallback onViewAllTap;
  final Query query;

  const ScrollableSection({
    Key? key,
    required this.itemCount,
    required this.label,
    required this.onViewAllTap,
    required this.query
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _BuildLabelSection(
          label: label,
          onViewAllTap: onViewAllTap,
        ),
       const   SizedBox(height: Const.space15),
        Container(
          width: Screens.width(context),
          height: Responsive.width(65, context)+Responsive.width(20, context),
          margin: const  EdgeInsets.only(bottom: 15),
          child: ListView.builder(
            cacheExtent: 9999,
            itemCount: itemCount.length>10?10:itemCount.length,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            padding: const  EdgeInsets.symmetric(horizontal: Const.margin),
            itemBuilder: (context, index) {
              final data = itemCount[index];
              return _BuildProductCard(
                onPressed: () {
                  // Get.toNamed<dynamic>(
                  // ShuppyRoutes.product,
                  // arguments: SimilarItemsArgument(product: data, cat: cat, article: article));
                  // Navigator.pop(context);
                  Navigator.push<dynamic>(context, MaterialPageRoute<dynamic>(builder: (context)=> ShuppyProductScreen(arg: ProductArgument(product: data, query: query))));
                  },
                product: data,
              );
            },
          ),
        ),
      ],
    );
  }
}
