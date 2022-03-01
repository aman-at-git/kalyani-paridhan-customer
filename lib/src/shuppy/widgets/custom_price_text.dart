import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomPriceText extends StatelessWidget {
  final int price;
  final int mrp;

  const CustomPriceText({Key? key, required this.price, required this.mrp}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Wrap(
      children: [
        Visibility(
          visible: price!=mrp,
          child: Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Text(NumberFormat.currency(
              decimalDigits: 0,
              symbol: '₹',
            ).format(mrp),
              style: theme.textTheme.bodyText2!
                  .copyWith(fontWeight: FontWeight.w100, decoration: TextDecoration.lineThrough, fontSize: 10),
            ),
          ),
        ),
        Text(
            NumberFormat.currency(
              symbol: '₹',
            ).format(price),
            style: theme.textTheme.bodyText2!
                .copyWith(fontSize: 12, fontWeight: FontWeight.w600)
        ),
        Visibility(
          visible: price!=mrp,
          child: Text(
              ' (${(100-(price/int.parse(mrp.toString()))*100).toInt()}% OFF)',
              style: theme.textTheme.bodyText2!
                  .copyWith(color: Colors.red, fontWeight: FontWeight.w100, fontSize: 12)
          ),
        ),
      ],
    );
  }
}
