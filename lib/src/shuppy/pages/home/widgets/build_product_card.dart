part of '../home_page.dart';

class _BuildProductCard extends StatelessWidget {
  final ProductModel? product;
  final void Function() onPressed;

  const _BuildProductCard({
    Key? key,
    required this.onPressed,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      width: Responsive.width(50, context),
      height: Responsive.width(75, context),
      child: Card(
        elevation: 1,
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
                  padding: const EdgeInsets.only(top: 4),
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
                      Spacer(),
                      CustomPriceText(price: product!.price!, mrp: product!.mrp!),
                      Spacer(),
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
