import 'package:klixstore/features/menu/domain/models/menu_model.dart';
import 'package:klixstore/helper/responsive_helper.dart';
import 'package:klixstore/localization/language_constrants.dart';
import 'package:klixstore/features/auth/providers/auth_provider.dart';
import 'package:klixstore/utill/dimensions.dart';
import 'package:klixstore/utill/images.dart';
import 'package:klixstore/utill/routes.dart';
import 'package:klixstore/utill/styles.dart';
import 'package:klixstore/common/widgets/custom_alert_dialog_widget.dart';
import 'package:klixstore/common/widgets/text_hover_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileHoverWidget extends StatelessWidget {
  const ProfileHoverWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<MenuModel> list = [
      MenuModel(
          icon: Images.profile,
          title: getTranslated('profile', context),
          route: Routes.getProfileRoute()),
      MenuModel(
          icon: Images.order,
          title: getTranslated('my_orders', context),
          route: Routes.getOrderListScreen()),
      MenuModel(
          icon: Images.profile,
          title: getTranslated('log_out', context),
          route: 'auth'),
    ];

    return Container(
        color: Theme.of(context).cardColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: list
              .map((item) => InkWell(
                    onTap: () {
                      if (item.route == 'auth') {
                        Future.delayed(
                            const Duration(seconds: 0),
                            () => ResponsiveHelper.showDialogOrBottomSheet(
                                context,
                                CustomAlertDialogWidget(
                                  title: getTranslated(
                                      'want_to_sign_out', context),
                                  icon: Icons.contact_support_outlined,
                                  onPressRight: () {
                                    Provider.of<AuthProvider>(context,
                                            listen: false)
                                        .clearSharedData();
                                    if (ResponsiveHelper.isWeb()) {
                                      Navigator.pushNamedAndRemoveUntil(
                                          context,
                                          Routes.getMainRoute(),
                                          (route) => false);
                                    } else {
                                      Navigator.pushNamedAndRemoveUntil(
                                          context,
                                          Routes.getSplashRoute(),
                                          (route) => false);
                                    }
                                  },
                                )));
                      } else {
                        Navigator.pushNamed(context, item.route);
                      }
                    },
                    child: TextHoverWidget(
                        builder: (isHover) => Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: Dimensions.paddingSizeExtraSmall),
                              decoration: BoxDecoration(
                                color: isHover
                                    ? Theme.of(context).focusColor
                                    : Theme.of(context).cardColor,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: Dimensions.paddingSizeSmall,
                                        vertical:
                                            Dimensions.paddingSizeExtraSmall,
                                      ),
                                      child: Text(item.title ?? '',
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: rubikRegular),
                                    ),
                                    Divider(
                                        height: 1,
                                        color: (list.indexOf(item) + 1) !=
                                                list.length
                                            ? null
                                            : Theme.of(context).cardColor),
                                  ]),
                            )),
                  ))
              .toList(),
        ));
  }
}
