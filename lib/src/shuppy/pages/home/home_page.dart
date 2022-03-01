import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:get/get.dart';
import 'package:ultimate_bundle/helpers/constants.dart';
import 'package:ultimate_bundle/src/shuppy/helpers/Responsive.dart';

import 'package:ultimate_bundle/src/shuppy/helpers/colors.dart';
import 'package:ultimate_bundle/src/shuppy/helpers/constants.dart';
import 'package:ultimate_bundle/src/shuppy/helpers/local_data.dart';
import 'package:ultimate_bundle/src/shuppy/helpers/screens.dart';
import 'package:ultimate_bundle/src/shuppy/helpers/snack_toast.dart';
import 'package:ultimate_bundle/src/shuppy/models/arguments_model.dart';
import 'package:ultimate_bundle/src/shuppy/models/favorite_model.dart';
import 'package:ultimate_bundle/src/shuppy/models/order_model.dart';
import 'package:ultimate_bundle/src/shuppy/models/product_model.dart';
import 'package:ultimate_bundle/src/shuppy/pages/category/category_page.dart';
import 'package:ultimate_bundle/src/shuppy/pages/product/product_page.dart';
import 'package:ultimate_bundle/src/shuppy/pages/search/search_page.dart';
import 'package:ultimate_bundle/src/shuppy/widgets/custom_app_bar.dart';
import 'package:ultimate_bundle/src/shuppy/widgets/custom_dots_indicator.dart';
import 'package:ultimate_bundle/src/shuppy/widgets/custom_network_image.dart';
import 'package:ultimate_bundle/src/shuppy/widgets/custom_price_text.dart';
import 'package:ultimate_bundle/src/shuppy/widgets/custom_star_rating.dart';

part 'screens/home_screen.dart';
part 'widgets/build_carousel_swiper.dart';
part 'widgets/build_custom_app_bar.dart';
part 'widgets/build_label_section.dart';
part 'widgets/build_product_card.dart';
part 'widgets/category_circle_card.dart';
part 'widgets/category_section.dart';
part 'widgets/scrollable_section.dart';
