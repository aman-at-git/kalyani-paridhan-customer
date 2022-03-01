part of '../order_page.dart';

class ShuppyOrderHistoryScreen extends StatefulWidget {
  const ShuppyOrderHistoryScreen({Key? key}) : super(key: key);

  @override
  State<ShuppyOrderHistoryScreen> createState() => _ShuppyOrderHistoryScreenState();
}

class _ShuppyOrderHistoryScreenState extends State<ShuppyOrderHistoryScreen> {

  @override
  void initState() {
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final args = Get.arguments as bool;

    return Scaffold(
      appBar: CustomAppBar(context,
          title: AppLocalizations.of(context)!.order_history,
          leadingOntap: () {
        if (args == true) {
          Get.offAllNamed<dynamic>(ShuppyRoutes.profile);
        } else {
          Get.back<dynamic>();
        }
      }),
      body: orderList.isNotEmpty
          ? ListView.separated(
              itemCount: orderList.length,
              shrinkWrap: true,
              padding:const  EdgeInsets.symmetric(horizontal: Const.margin),
              separatorBuilder: (context, index) {
                return const Divider();
              },
              itemBuilder: (context, index) {
                final order = orderList[index];

                return ExpansionTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Order Id: ${order.id}',
                          style: theme.textTheme.headline4),
                      Text('Placed',
                          style: theme.textTheme.subtitle2!.copyWith(
                            color: const Color(0xFF9ACD32),
                            fontWeight: FontWeight.w600,
                          )),
                    ],
                  ),
                  children: order.products!
                      .map((e) => InkWell(
                            onTap: () {
                              Get.toNamed<dynamic>(
                                ShuppyRoutes.orderDetail,
                                arguments: order,
                              );
                            },
                            child: _BuildProductOrderCard(product: e),
                          ))
                      .toList(),
                );
              },
            )
          : EmptySection(
              title:
                  AppLocalizations.of(context)!.your_order_history_is_empty,
              image: Illustrations.emptyOrder,
            ),
    );
  }

}
