import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:provider/provider.dart';
import 'package:ultimate_bundle/helpers/constants.dart';
import 'package:ultimate_bundle/providers/theme_provider.dart';

import 'package:ultimate_bundle/src/shuppy/helpers/constants.dart';
import 'package:ultimate_bundle/src/shuppy/helpers/snack_toast.dart';
import 'package:ultimate_bundle/src/shuppy/pages/sign_in/sign_in_page.dart';
import 'package:ultimate_bundle/src/shuppy/widgets/custom_app_bar.dart';
import 'package:ultimate_bundle/src/shuppy/widgets/custom_elevated_button.dart';
import 'package:ultimate_bundle/src/shuppy/widgets/custom_fade_transtition.dart';
import 'package:ultimate_bundle/src/shuppy/widgets/custom_loading_indicator.dart';
import 'package:ultimate_bundle/src/shuppy/widgets/custom_outlined_button.dart';
import 'package:ultimate_bundle/src/shuppy/widgets/custom_shake_transtition.dart';
import 'package:ultimate_bundle/src/shuppy/widgets/custom_text_button.dart';
import 'package:ultimate_bundle/src/shuppy/widgets/custom_text_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'screens/sign_up_screen.dart';
part 'widgets/body_section.dart';
part 'widgets/footer_section.dart';
part 'widgets/header_section.dart';
