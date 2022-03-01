part of '../order_page.dart';


class _BuildProductOrderCard extends StatelessWidget {
  final ProductModel? product;

  const _BuildProductOrderCard({Key? key, required this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: SizedBox(
        width: double.infinity,
        child: Row(
          children: [
            const  SizedBox(width: 12),
            Container(
              width: 75,
              height: 75,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: NetworkImage(
                    product!.images!.first,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: const  EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product!.name!,
                      style: theme.textTheme.headline5,
                      overflow: TextOverflow.clip,
                      maxLines: 1,
                    ),
                  const    SizedBox(height: 5),
                    Row(
                      children: [
                        Text(
                          '${AppLocalizations.of(context)!.qty}: ${product!.quantity}',
                          style: theme.textTheme.headline4,
                        ),
                        Spacer(),
                        Text(
                          '${AppLocalizations.of(context)!.size}: ${product!.size}',
                          style: theme.textTheme.headline4,
                        ),
                        Spacer(),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Text(
                          '${AppLocalizations.of(context)!.price}: ',
                          style: theme.textTheme.headline4,
                        ),
                        Text(NumberFormat.currency(symbol: '₹', decimalDigits: 2).format(product!.price), style: theme.textTheme.headline4)
                      ],
                    ),
                    // CustomPriceText(price: product!.price!, mrp: product!.mrp!)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
