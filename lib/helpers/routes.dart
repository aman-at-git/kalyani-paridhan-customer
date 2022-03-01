import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:ultimate_bundle/helpers/constants.dart';
import 'package:ultimate_bundle/src/shuppy/helpers/local_data.dart';
import 'package:ultimate_bundle/src/shuppy/main.dart';
import 'package:ultimate_bundle/src/shuppy/models/arguments_model.dart';
import 'package:ultimate_bundle/src/shuppy/models/product_model.dart';
import 'package:ultimate_bundle/src/shuppy/pages/address/address_page.dart';
import 'package:ultimate_bundle/src/shuppy/pages/bottom_navigation/bottom_navigation_page.dart';
import 'package:ultimate_bundle/src/shuppy/pages/category/category_page.dart';
import 'package:ultimate_bundle/src/shuppy/pages/checkout/checkout_page.dart';
import 'package:ultimate_bundle/src/shuppy/pages/favorite/favorite_page.dart';
import 'package:ultimate_bundle/src/shuppy/pages/forgot_password/forgot_password_page.dart';
import 'package:ultimate_bundle/src/shuppy/pages/language/language_page.dart';
import 'package:ultimate_bundle/src/shuppy/pages/notification/notification_page.dart';
import 'package:ultimate_bundle/src/shuppy/pages/on_boarding/on_boarding_page.dart';
import 'package:ultimate_bundle/src/shuppy/pages/order/order_page.dart';
import 'package:ultimate_bundle/src/shuppy/pages/payment/payment_page.dart';
import 'package:ultimate_bundle/src/shuppy/pages/product/product_page.dart';
import 'package:ultimate_bundle/src/shuppy/pages/profile/profile_page.dart';
import 'package:ultimate_bundle/src/shuppy/pages/search/search_page.dart';
import 'package:ultimate_bundle/src/shuppy/pages/sign_in/sign_in_page.dart';
import 'package:ultimate_bundle/src/shuppy/pages/sign_up/sign_up_page.dart';

List<GetPage> allRoutesFurney = [
  // UI Kit Routes
  GetPage<dynamic>(
    name: UIKitRoutes.shuppy,
    page: () => const ShuppySplashScreen(),
  ),
  //----------------------------------------------------------------------------
  // Shuppy Routes
  GetPage<dynamic>(
    name: ShuppyRoutes.splash,
    page: () => const ShuppySplashScreen(),
  ),
  GetPage<dynamic>(
    name: ShuppyRoutes.address,
    page: () => const ShuppyAddressScreen(),
  ),
  GetPage<dynamic>(
    name: ShuppyRoutes.browseProduct,
    page: () => const ShuppyBrowseProductScreen(),
  ),
  GetPage<dynamic>(
    name: ShuppyRoutes.cart,
    page: () => const ShuppyBottomNavigationScreen(initialIndex: 1),
  ),
  GetPage<dynamic>(
    name: ShuppyRoutes.category,
    page: () => const ShuppyCategoryScreen(),
  ),
  GetPage<dynamic>(
    name: ShuppyRoutes.checkout,
    page: () => const ShuppyCheckoutScreen(),
  ),
  GetPage<dynamic>(
    name: ShuppyRoutes.checkoutSuccess,
    page: () => const ShuppyCheckoutSuccessScreen(),
  ),
  GetPage<dynamic>(
    name: ShuppyRoutes.editProfile,
    page: () => const ShuppyEditProfileScreen(),
  ),
  GetPage<dynamic>(
    name: ShuppyRoutes.favorite,
    page: () => const ShuppyFavoriteScreen(),
  ),
  GetPage<dynamic>(
    name: ShuppyRoutes.forgotPassword,
    page: () => const ShuppyForgotPasswordScreen(),
  ),
  GetPage<dynamic>(
    name: ShuppyRoutes.home,
    page: () => const ShuppyBottomNavigationScreen(),
  ),
  GetPage<dynamic>(
    name: ShuppyRoutes.language,
    page: () => const ShuppyLanguageScreen(),
  ),
  GetPage<dynamic>(
    name: ShuppyRoutes.notification,
    page: () => const ShuppyNotificationScreen(),
  ),
  GetPage<dynamic>(
    name: ShuppyRoutes.onBoarding,
    page: () => const ShuppyOnBoardingScreen(),
  ),
  GetPage<dynamic>(
    name: ShuppyRoutes.orderHistory,
    page: () => const ShuppyOrderHistoryScreen(),
  ),
  GetPage<dynamic>(
    name: ShuppyRoutes.orderDetail,
    page: () => const ShuppyOrderDetailScreen(),
  ),
  GetPage<dynamic>(
    name: ShuppyRoutes.payment,
    page: () => const ShuppyPaymentScreen(),
  ),
  GetPage<dynamic>(
    name: ShuppyRoutes.paymentSuccess,
    page: () => const ShuppyPaymentSuccessScreen(),
  ),
  GetPage<dynamic>(
    name: ShuppyRoutes.product,
    page: () => ShuppyProductScreen(
      arg: ProductArgument(
        query: FirebaseFirestore.instance.collection('xyz'),
        // collectionReference: FirebaseFirestore.instance.collection('products').doc('men').collection('shirt'),
        product: ProductModel(
            id: 1,
            name: '',
            price: 0,
            mrp: 0,
            rating: 0,
            description: '',
            images: <String>[],
            sizes: <String>[]),
      ),
    ),
  ),
  GetPage<dynamic>(
    name: ShuppyRoutes.profile,
    page: () => const ShuppyBottomNavigationScreen(initialIndex: 3),
  ),
  GetPage<dynamic>(
    name: ShuppyRoutes.signIn,
    page: () => const ShuppySignInScreen(),
  ),
  GetPage<dynamic>(
    name: ShuppyRoutes.signUp,
    page: () => const ShuppySignUpScreen(),
  ),
];
