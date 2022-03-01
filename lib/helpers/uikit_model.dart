import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:ultimate_bundle/helpers/constants.dart';
import 'package:ultimate_bundle/providers/theme_provider.dart';

class UIKitModel {
  final String? name;
  final int? totalScreen;
  final String? image;
  final VoidCallback? navigation;

  UIKitModel({this.name, this.totalScreen, this.image, this.navigation});
}

List<UIKitModel> allFullUIKitList(BuildContext context) => [
  UIKitModel(
    name: 'Shuppy | eCommerce UI Kit',
    totalScreen: 23,
    image: 'https://i.pinimg.com/originals/12/c1/c1/12c1c15ca0e9e37d37a2acfe6450ee1a.jpg',
    navigation: (){
      context.read<ThemeProvider>().themeUIKit = ThemeUIKit.shuppy;
      Get.toNamed<dynamic>(UIKitRoutes.shuppy);
    },
  ),
];
