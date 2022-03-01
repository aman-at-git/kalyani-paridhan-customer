part of '../product_page.dart';

String selectedSize = '0';

class _BodySection extends StatefulWidget {
  final ProductModel product;
  final Query query;

  const _BodySection({Key? key, required this.product, required this.query}) : super(key: key);

  @override
  State<_BodySection> createState() => _BodySectionState();
}

List<ProductModel> _similarList =[];

class _BodySectionState extends State<_BodySection> with TickerProviderStateMixin{

  @override
  void initState() {
    super.initState();
    selectedSize = '0';
    animationHeight = 50;
    animationWidth = 50;
    theColor = Colors.green;
    getSimilarItems();
  }
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Positioned.fill(
      child: DraggableScrollableSheet(
        initialChildSize: 1-(MediaQuery.of(context).size.width/MediaQuery.of(context).size.height*4/3),
        minChildSize: 1-(MediaQuery.of(context).size.width/MediaQuery.of(context).size.height*4/3),
        maxChildSize: 0.8,
        // minChildSize: MediaQuery.of(context).size.width/1000,
        builder: (context, scrollController) {
          return Container(
            decoration: BoxDecoration(
              color: theme.backgroundColor,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(25),
                topLeft: Radius.circular(25),
              ),
            ),
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Const.margin),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 12),
                        Center(
                          child: Container(
                            width: 50,
                            height: 5,
                            decoration: BoxDecoration(
                              color: theme.unselectedWidgetColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        const SizedBox(height: Const.space25),
                        CustomShakeTransition(
                          duration: const Duration(milliseconds: 1000),
                          child: RichText(text: TextSpan(
                            text: '${widget.product.name} ',
                            style: theme.textTheme.headline3,
                            children: <TextSpan>[
                              TextSpan(text: widget.product.description,
                                style: theme.textTheme.bodyText1,
                              ),
                            ],
                          ),
                          ),
                        ),
                        const SizedBox(height: Const.space12),
                        Row(
                          children: [
                            Visibility(
                              visible: widget.product.price!=widget.product.mrp,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: CustomShakeTransition(
                                  duration: const Duration(milliseconds: 1300),
                                  child: Text(NumberFormat.currency(
                                    symbol: '₹',
                                  ).format(widget.product.mrp),
                                    style: theme.textTheme.headline3!
                                        .copyWith(fontWeight: FontWeight.w100, decoration: TextDecoration.lineThrough),
                                  ),
                                ),
                              ),
                            ),
                            CustomShakeTransition(
                              duration: const Duration(milliseconds: 1300),
                              child: Text(
                                  NumberFormat.currency(
                                    symbol: '₹',
                                  ).format(widget.product.price),
                                  style: theme.textTheme.headline2!
                                      .copyWith(color: theme.primaryColor)
                              ),
                            ),
                            Visibility(
                              visible: widget.product.price!=widget.product.mrp,
                              child: CustomShakeTransition(
                                duration: const Duration(milliseconds: 1300),
                                child: Text(
                                    ' (${(100-(widget.product.price!/int.parse(widget.product.mrp.toString()))*100).toInt()}% OFF)',
                                    style: theme.textTheme.headline4!
                                        .copyWith(color: Colors.red, fontWeight: FontWeight.w100)
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: Const.space12),
                        CustomShakeTransition(
                          child: ScaleTransition(
                            scale: shakeAnimation!,
                            child: Text('Select Size',
                                style: theme.textTheme.headline3!,
                                overflow: TextOverflow.clip),
                          ),
                        ),
                        const SizedBox(height: Const.space12),
                        CustomShakeTransition(
                          child: Wrap(
                            children: [
                              sizesRow(context, '2XS', widget.product.sizes![0]),
                              sizesRow(context, 'XS', widget.product.sizes![1]),
                              sizesRow(context, 'S', widget.product.sizes![2]),
                              sizesRow(context, 'M', widget.product.sizes![3]),
                              sizesRow(context, 'L', widget.product.sizes![4]),
                              sizesRow(context, 'XL', widget.product.sizes![5]),
                              sizesRow(context, '2XL', widget.product.sizes![6]),
                              sizesRow(context, '3XL', widget.product.sizes![7]),
                              uniSizeRow(context, 'Uni-size',
                                  widget.product.sizes![0]=='false' &&
                                  widget.product.sizes![1]=='false' &&
                                  widget.product.sizes![2]=='false' &&
                                  widget.product.sizes![3]=='false' &&
                                  widget.product.sizes![4]=='false' &&
                                  widget.product.sizes![5]=='false' &&
                                  widget.product.sizes![6]=='false' &&
                                  widget.product.sizes![7]=='false'
                              ),
                            ],
                          ),
                        ),
                        // CustomShakeTransition(
                        //   duration: const  Duration(milliseconds: 1200),
                        //   child: Row(
                        //     children: [
                        //       CustomStarRating(rating: product.rating!),
                        //        const SizedBox(width: 5),
                        //       Text(
                        //         product.rating.toString(),
                        //         overflow: TextOverflow.clip,
                        //         textAlign: TextAlign.left,
                        //         style: theme.textTheme.subtitle2!
                        //             .copyWith(fontSize: 10),
                        //       ),
                        //        const SizedBox(width: 5),
                        //       Text(
                        //         '0 ${AppLocalizations.of(context)!.review}',
                        //         overflow: TextOverflow.clip,
                        //         textAlign: TextAlign.left,
                        //         style: theme.textTheme.subtitle2!
                        //             .copyWith(fontSize: 10),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        const SizedBox(height: Const.space12),
                        // CustomShakeTransition(
                        //   duration: const Duration(milliseconds: 1400),
                        //   child: ReadMoreText(
                        //     widget.product.description!,
                        //     style: theme.textTheme.bodyText2,
                        //     trimLines: 5,
                        //     colorClickableText: theme.primaryColor,
                        //     trimMode: TrimMode.Line,
                        //     trimCollapsedText:
                        //         '... ${AppLocalizations.of(context)!.more}',
                        //     trimExpandedText:
                        //         ' ${AppLocalizations.of(context)!.less}',
                        //   ),
                        // ),
                        // const SizedBox(height: Const.space25),
                        CustomShakeTransition(
                          child: Text('Id: ${widget.product.id}',
                              style: theme.textTheme.subtitle2!,
                              overflow: TextOverflow.clip),
                        ),
                        const SizedBox(height: Const.space15),
                      ],
                    ),
                  ),
                  ScrollableSection(
                    label: 'Also see',
                    itemCount: _similarList,
                    onViewAllTap: () => Get.toNamed<dynamic>(
                          ShuppyRoutes.browseProduct,
                          arguments: BrowseArgument(
                            cat: '',
                            label: 'More items',
                            query: FirebaseFirestore.instance.collection('recent')
                          ),
                        ),
                    query: widget.query,
                  ),
                  // EmptySection(
                  //   image: Illustrations.emptyRating,
                  //   title: AppLocalizations.of(context)!
                  //       .does_not_have_a_rating_yet,
                  // ),


                  // ListView.builder(
                  //   itemCount: productList.length,
                  //   physics: ScrollPhysics(),
                  //   shrinkWrap: true,
                  //   scrollDirection: Axis.vertical,
                  //   padding: EdgeInsets.all(0),
                  //   itemBuilder: (context, index) {
                  //     // return ReviewCard(
                  //     //   review: product!.reviews![index],
                  //     // );
                  //   },
                  // ),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  int getSimilarItems(){
    _similarList.clear();
    FirebaseFirestore.instance.collection('recent').limit(5)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        setState(() {
          _similarList.add(
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
    return 0;
  }

  List<String> convertListToStringList(dynamic link){
    final links = <String>[];
    for(final i in link){
      links.add(i.toString());
    }
    return links;
  }

  Widget sizesRow(BuildContext context, String text, String isVisible){
    final theme = Theme.of(context);
    return Visibility(
      visible: isVisible=='true',
      child: Padding(
        padding: const EdgeInsets.only(right: 8.0, bottom: 12),
        child: InkWell(
          onTap: (){
            setState(() {
              selectedSize = text;
            });
          },
          child: CircleAvatar(
              radius: 20,
              backgroundColor: theme.disabledColor,
              child: CircleAvatar(
                  radius: 18.5,
                  backgroundColor: selectedSize==text?theme.indicatorColor:theme.backgroundColor,
                  child: Text(
                    text,
                    style:theme.textTheme.headline4!.copyWith(color: selectedSize==text?Colors.white:Colors.grey)
                  ))),
        ),
      ),
    );
  }

  Widget uniSizeRow(BuildContext context, String text, bool isVisible){
    final theme = Theme.of(context);
    return Visibility(
      visible: isVisible,
      child: Padding(
        padding: const EdgeInsets.only(right: 8.0, bottom: 12),
        child: InkWell(
          onTap: (){
            setState(() {
              selectedSize = text;
            });
          },
          child: CircleAvatar(
              radius: 30,
              backgroundColor: theme.disabledColor,
              child: CircleAvatar(
                  radius: 28,
                  backgroundColor: selectedSize==text?theme.indicatorColor:theme.backgroundColor,
                  child: Text(
                    text,
                    style:theme.textTheme.headline4!.copyWith(color: selectedSize==text?Colors.white:Colors.grey)
                  ))),
        ),
      ),
    );
  }
}
