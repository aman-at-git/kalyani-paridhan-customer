part of '../product_page.dart';

class _BuildProductGridCard extends StatelessWidget {
  final ProductModel? product;
  final void Function() onPressed;

  const _BuildProductGridCard({
    Key? key,
    required this.onPressed,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // return Card(
    //   elevation: 0,
    //   child: InkWell(
    //     onTap: onPressed,
    //     borderRadius: BorderRadius.circular(8),
    //     child: Column(
    //       children: [
    //         CustomNetworkImage(image: product!.images!.first, width: Responsive.width(50, context),height: Responsive.width(45, context)*4/3,),
    //         Padding(
    //           padding: const EdgeInsets.all(0),
    //           child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               Text(
    //                 product!.name!,
    //                 overflow: TextOverflow.clip,
    //                 maxLines: 1,
    //                 textAlign: TextAlign.left,
    //                 style: theme.textTheme.bodyText2!.copyWith(height: 1.2),
    //               ),
    //               const SizedBox(height: 3),
    //               // Text(
    //               //   NumberFormat.currency(
    //               //     symbol: r'$ ',
    //               //   ).format(product!.price),
    //               //   overflow: TextOverflow.clip,
    //               //   textAlign: TextAlign.left,
    //               //   style: theme.textTheme.headline4!
    //               //       .copyWith(color: theme.primaryColor),
    //               // ),
    //               Wrap(
    //                 children: [
    //                   Visibility(
    //                     visible: product!.price!=product!.mrp,
    //                     child: Padding(
    //                       padding: const EdgeInsets.only(right: 8.0),
    //                       child: Text(NumberFormat.currency(
    //                         symbol: '₹',
    //                       ).format(product!.mrp),
    //                         style: theme.textTheme.bodyText2!
    //                             .copyWith(fontWeight: FontWeight.w100, decoration: TextDecoration.lineThrough, fontSize: 10),
    //                       ),
    //                     ),
    //                   ),
    //                   Text(
    //                       NumberFormat.currency(
    //                         symbol: '₹',
    //                       ).format(product!.price),
    //                       style: theme.textTheme.bodyText2!
    //                           .copyWith(color: theme.primaryColor, fontSize: 12)
    //                   ),
    //                   Visibility(
    //                     visible: product!.price!=product!.mrp,
    //                     child: Text(
    //                         ' (${(100-(product!.price!/int.parse(product!.mrp.toString()))*100).toInt()}% OFF)',
    //                         style: theme.textTheme.bodyText2!
    //                             .copyWith(color: Colors.red, fontWeight: FontWeight.w100, fontSize: 12)
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             // const    SizedBox(height: 3),
    //             //   Row(
    //             //     children: [
    //             //       CustomStarRating(rating: product!.rating!),
    //             //  const       SizedBox(width: 5),
    //             //       Text(
    //             //         product!.rating.toString(),
    //             //         overflow: TextOverflow.clip,
    //             //         textAlign: TextAlign.left,
    //             //         style:
    //             //             theme.textTheme.subtitle2!.copyWith(fontSize: 10),
    //             //       ),
    //             //     ],
    //             //   ),
    //             ],
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
    return SizedBox(
      width: Responsive.width(50, context),
      height: Responsive.width(85, context),
      child: Card(
        elevation: 0,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(8),
          child: Column(
            children: [
              CustomNetworkImage(
                image: product!.images!.first,
                width: Responsive.width(50, context),
                height: Responsive.width(65, context),
              ),
              SizedBox(
                height: Responsive.width(17, context),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product!.name!,
                        overflow: TextOverflow.clip,
                        maxLines: 1,
                        textAlign: TextAlign.left,
                        style: theme.textTheme.headline4!.copyWith(height: 1.2),
                      ),
                      Text(
                        product!.description!,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        textAlign: TextAlign.left,
                        style: theme.textTheme.subtitle2!.copyWith(height: 1.2),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          Visibility(
                            visible: product!.price!=product!.mrp,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Text(NumberFormat.currency(
                                symbol: '₹',
                                decimalDigits: 0,
                              ).format(product!.mrp),
                                style: theme.textTheme.bodyText2!
                                    .copyWith(fontWeight: FontWeight.w100, decoration: TextDecoration.lineThrough, fontSize: 10),
                              ),
                            ),
                          ),
                          Text(
                              NumberFormat.currency(
                                symbol: '₹',
                              ).format(product!.price),
                              style: theme.textTheme.bodyText2!
                                  .copyWith(fontSize: 12, fontWeight: FontWeight.w600)
                          ),
                          Visibility(
                            visible: product!.price!=product!.mrp,
                            child: Text(
                                ' (${(100-(product!.price!/int.parse(product!.mrp.toString()))*100).toInt()}% OFF)',
                                style: theme.textTheme.bodyText2!
                                    .copyWith(color: Colors.red, fontWeight: FontWeight.w100, fontSize: 12)
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
