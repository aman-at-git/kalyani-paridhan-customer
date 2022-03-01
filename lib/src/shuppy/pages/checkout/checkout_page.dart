import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ultimate_bundle/helpers/constants.dart';

import 'package:ultimate_bundle/src/shuppy/helpers/constants.dart';
import 'package:ultimate_bundle/src/shuppy/helpers/dialogs.dart';
import 'package:ultimate_bundle/src/shuppy/helpers/local_data.dart';
import 'package:ultimate_bundle/src/shuppy/models/arguments_model.dart';
import 'package:ultimate_bundle/src/shuppy/models/order_model.dart';
import 'package:ultimate_bundle/src/shuppy/models/product_model.dart';
import 'package:ultimate_bundle/src/shuppy/pages/home/home_page.dart';
import 'package:ultimate_bundle/src/shuppy/widgets/custom_app_bar.dart';
import 'package:ultimate_bundle/src/shuppy/widgets/custom_elevated_button.dart';
import 'package:ultimate_bundle/src/shuppy/widgets/custom_fade_transtition.dart';
import 'package:ultimate_bundle/src/shuppy/widgets/custom_price_text.dart';
import 'package:ultimate_bundle/src/shuppy/widgets/custom_shake_transtition.dart';

part 'screens/checkout_screen.dart';
part 'screens/checkout_success_screen.dart';
part 'widgets/body_section.dart';
part 'widgets/build_destination_address.dart';
part 'widgets/build_price_item.dart';
part 'widgets/build_product_ordered_list.dart';
