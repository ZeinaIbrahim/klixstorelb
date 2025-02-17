import 'package:klixstore/helper/responsive_helper.dart';
import 'package:klixstore/localization/language_constrants.dart';
import 'package:klixstore/provider/theme_provider.dart';
import 'package:klixstore/utill/dimensions.dart';
import 'package:klixstore/utill/images.dart';
import 'package:klixstore/utill/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpLogoWidget extends StatelessWidget {
  const SignUpLogoWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).cardColor,
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        const SizedBox(height: Dimensions.paddingSizeDefault),
        Image.asset(
          Provider.of<ThemeProvider>(context).darkTheme ? Images.logoDark : Images.logoLight,
          height: ResponsiveHelper.isDesktop(context) ? 100.0 : 80,
          fit: BoxFit.scaleDown,
        ),
        const SizedBox(height: Dimensions.paddingSizeSmall),
        Text(getTranslated('signup', context),
            style: rubikMedium.copyWith(
              fontSize: Dimensions.fontSizeOverLarge,
            )),
        const SizedBox(height: Dimensions.paddingSizeLarge),
      ]),
    );
  }
}
