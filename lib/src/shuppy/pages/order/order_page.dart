import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:ultimate_bundle/helpers/constants.dart';

import 'package:ultimate_bundle/src/shuppy/helpers/constants.dart';
import 'package:ultimate_bundle/src/shuppy/helpers/local_data.dart';
import 'package:ultimate_bundle/src/shuppy/models/order_model.dart';
import 'package:ultimate_bundle/src/shuppy/models/product_model.dart';
import 'package:ultimate_bundle/src/shuppy/pages/home/home_page.dart';
import 'package:ultimate_bundle/src/shuppy/widgets/custom_app_bar.dart';
import 'package:ultimate_bundle/src/shuppy/widgets/custom_price_text.dart';
import 'package:ultimate_bundle/src/shuppy/widgets/custom_shake_transtition.dart';
import 'package:ultimate_bundle/src/shuppy/widgets/empty_section.dart';
import 'package:intl/intl.dart';

part 'screen/order_detail_screen.dart';
part 'screen/order_history_screen.dart';
part 'widgets/build_order_item.dart';
part 'widgets/build_product_order_card.dart';
part 'widgets/build_product_order_list.dart';
part 'widgets/build_timeline_order.dart';
