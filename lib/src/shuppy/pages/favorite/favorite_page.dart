import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ultimate_bundle/helpers/constants.dart';

import 'package:ultimate_bundle/src/shuppy/helpers/constants.dart';
import 'package:ultimate_bundle/src/shuppy/helpers/local_data.dart';
import 'package:ultimate_bundle/src/shuppy/models/arguments_model.dart';
import 'package:ultimate_bundle/src/shuppy/models/product_model.dart';
import 'package:ultimate_bundle/src/shuppy/pages/home/home_page.dart';
import 'package:ultimate_bundle/src/shuppy/pages/product/product_page.dart';
import 'package:ultimate_bundle/src/shuppy/widgets/custom_app_bar.dart';
import 'package:ultimate_bundle/src/shuppy/widgets/custom_network_image.dart';
import 'package:ultimate_bundle/src/shuppy/widgets/custom_star_rating.dart';
import 'package:ultimate_bundle/src/shuppy/widgets/empty_section.dart';

part 'screens/favorite_screen.dart';
part 'widgets/build_product_grid_card.dart';
