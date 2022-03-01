part of '../category_page.dart';

class ShuppyCategoryScreen extends StatelessWidget {
  const ShuppyCategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _args = Get.arguments as String;
    return Scaffold(
      appBar: CustomAppBar(context,
          title: AppLocalizations.of(context)!.categories),
      body: GridView.builder(
        itemCount: _args == 'men'?LocalList.allCategoryListMen().length:LocalList.allCategoryListWomen().length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 15,
          crossAxisSpacing: 15,
        ),
        shrinkWrap: true,
        physics:const ScrollPhysics(),
        padding:const EdgeInsets.symmetric(horizontal: Const.margin),
        itemBuilder: (context, index) {
          final data = _args == 'men'?LocalList.allCategoryListMen()[index]:LocalList.allCategoryListWomen()[index];
          return _BuildCategoryCircleCard(
            label: data.label!,
            icon: data.icon!,
            onTap: () {
              Get.toNamed<dynamic>(
                ShuppyRoutes.browseProduct,
                arguments: BrowseArgument(
                  query: FirebaseFirestore.instance.collection('products').doc(_args.toString()).collection(data.label!.toLowerCase()),
                  cat: _args.toString(),
                  label: data.label!.toLowerCase(),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
