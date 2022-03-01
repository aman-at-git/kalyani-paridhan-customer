part of '../cart_page.dart';

class _BodySection extends StatelessWidget {
  final int totalPrice;
  final int shippingCost;
  final int total;
  final VoidCallback onCheckoutTap;

  const _BodySection(
      {Key? key,
      required this.totalPrice,
      required this.shippingCost,
      required this.total,
      required this.onCheckoutTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: Const.margin),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: Const.space8),
              CustomShakeTransition(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total MRP', style: theme.textTheme.headline4),
                    Text(NumberFormat.currency(symbol: '₹',).format(totalPrice), style: theme.textTheme.headline4)
                  ],
                ),
              ),
              const SizedBox(height: Const.space12),
              CustomShakeTransition(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Discount', style: theme.textTheme.headline4),
                    Text(NumberFormat.currency(symbol: '-₹',).format(shippingCost),
                        style: const TextStyle(color: Colors.green,fontWeight: FontWeight.w600, fontSize: 14))
                  ],
                ),
              ),
              const Divider(color: Colors.black, thickness: 1,),
              CustomShakeTransition(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        'Total Amount',
                        style: theme.textTheme.headline3
                    ),
                    Text(
                        NumberFormat.currency(symbol: '₹',).format(total),
                        style: theme.textTheme.headline3
                    )
                  ],
                ),
              ),
              const SizedBox(height: Const.space8),
              // const Divider(color: Colors.black,),
              // CustomShakeTransition(
              //     child: _BuildCartItem(
              //   label: AppLocalizations.of(context)!.total_price,
              //   value: totalPrice,
              // )),
              // const SizedBox(height: Const.space12),
              // CustomShakeTransition(
              //     child: _BuildCartItem(
              //   label: AppLocalizations.of(context)!.shipping_costs,
              //   value: shippingCost,
              // )),
              // const SizedBox(height: Const.space12),
              // CustomShakeTransition(
              //     child: _BuildCartItem(
              //   label: AppLocalizations.of(context)!.total,
              //   value: total,
              // )),
            ],
          ),
        ),
        const SizedBox(height: Const.space15),
        CustomElevatedButton(
          label: 'PLACE ORDER',
          onTap: onCheckoutTap,
        ),
        const SizedBox(height: Const.margin),
      ],
    );
  }
}
