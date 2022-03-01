import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:ultimate_bundle/src/shuppy/helpers/constants.dart';
import 'package:ultimate_bundle/src/shuppy/widgets/custom_elevated_button.dart';
import 'package:ultimate_bundle/src/shuppy/widgets/custom_outlined_button.dart';
import 'package:otp_text_field/otp_field.dart';

String otp = '';

class Dialogs {
  static Future alertSuccess(BuildContext context,
      {required String title,
      required String subtitle,
      VoidCallback? onTap,
      String? buttonLabel}) {
    final theme = Theme.of(context);
    return showDialog<dynamic>(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                Images.done,
                width: MediaQuery.of(context).size.width / 4,
              ),
              const SizedBox(height: Const.space25),
              Text(
                title,
                style: theme.textTheme.headline1,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: Const.space12),
              Text(
                subtitle,
                style: theme.textTheme.subtitle1,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: Const.space15),
              if (buttonLabel == null)
                const SizedBox()
              else
                CustomElevatedButton(
                  label: buttonLabel,
                  onTap: onTap,
                ),
            ],
          ),
        );
      },
    );
  }

  static Future labelDialog(
    BuildContext context, {
    bool barrierDismissible = false,
    required String? title,
    required String? primaryButtonLabel,
    String? secondaryButtonLabel,
    required VoidCallback? onPrimaryButtonTap,
    VoidCallback? onSecondaryButtonTap,
  }) {
    final theme = Theme.of(context);

    return showDialog<dynamic>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) {
        return AlertDialog(
          backgroundColor: theme.cardColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          content: SizedBox(
            height: 150,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title!,
                  style: theme.textTheme.bodyText1,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 25),
                SizedBox(
                  height: 45,
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomOutlinedButton(
                          onTap: (onSecondaryButtonTap == null)
                              ? () => Get.back<dynamic>()
                              : onSecondaryButtonTap,
                          label: (secondaryButtonLabel == null)
                              ? AppLocalizations.of(context)!.back
                              : secondaryButtonLabel,
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: CustomElevatedButton(
                          onTap: onPrimaryButtonTap,
                          label: primaryButtonLabel ?? '',
                          color: theme.primaryColor,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

}

void aFunc(){
  print(otp);
}
