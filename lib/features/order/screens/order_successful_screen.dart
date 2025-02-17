import 'package:klixstore/common/enums/footer_type_enum.dart';
import 'package:klixstore/common/widgets/custom_app_bar_widget.dart';
import 'package:klixstore/common/widgets/custom_button_widget.dart';
import 'package:klixstore/common/widgets/custom_shadow_widget.dart';
import 'package:klixstore/common/widgets/footer_web_widget.dart';
import 'package:klixstore/helper/responsive_helper.dart';
import 'package:klixstore/localization/language_constrants.dart';
import 'package:klixstore/utill/dimensions.dart';
import 'package:klixstore/utill/routes.dart';
import 'package:klixstore/utill/styles.dart';
import 'package:flutter/material.dart';

class OrderSuccessfulScreen extends StatelessWidget {
  final String? orderID;
  final int status;
  const OrderSuccessfulScreen(
      {Key? key, required this.orderID, required this.status})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: const CustomAppBarWidget(),
      body: CustomScrollView(slivers: [
        SliverToBoxAdapter(
            child: Center(
                child: SizedBox(
          width: Dimensions.webScreenWidth,
          child: Column(
            mainAxisAlignment: ResponsiveHelper.isDesktop(context)
                ? MainAxisAlignment.start
                : MainAxisAlignment.center,
            children: [
              Padding(
                padding: ResponsiveHelper.isDesktop(context)
                    ? const EdgeInsets.all(Dimensions.paddingSizeLarge)
                    : const EdgeInsets.all(8.0),
                child: Center(
                    child: CustomShadowWidget(
                  isActive: ResponsiveHelper.isDesktop(context),
                  child: Container(
                    constraints: BoxConstraints(
                        minHeight: !ResponsiveHelper.isDesktop(context) &&
                                size.height < 600
                            ? size.height
                            : size.height - 400),
                    width: Dimensions.webScreenWidth,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.2),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              status == 0
                                  ? Icons.check_circle
                                  : status == 1
                                      ? Icons.sms_failed
                                      : Icons.cancel,
                              color: Theme.of(context).primaryColor,
                              size: 80,
                            ),
                          ),
                          const SizedBox(height: Dimensions.paddingSizeLarge),
                          Text(
                            getTranslated(
                                status == 0
                                    ? 'order_placed_successfully'
                                    : status == 1
                                        ? 'payment_failed'
                                        : 'payment_cancelled',
                                context),
                            style: rubikMedium.copyWith(
                                fontSize: Dimensions.fontSizeLarge),
                          ),
                          const SizedBox(height: Dimensions.paddingSizeSmall),
                          if (status == 0)
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('${getTranslated('order_id', context)}:',
                                      style: rubikRegular.copyWith(
                                          fontSize: Dimensions.fontSizeSmall)),
                                  const SizedBox(
                                      width: Dimensions.paddingSizeExtraSmall),
                                  Text(orderID!,
                                      style: rubikMedium.copyWith(
                                          fontSize: Dimensions.fontSizeSmall)),
                                ]),
                          const SizedBox(height: 30),
                          SizedBox(
                            width: ResponsiveHelper.isDesktop(context)
                                ? 400
                                : size.width,
                            child: Padding(
                              padding: const EdgeInsets.all(
                                  Dimensions.paddingSizeLarge),
                              child: CustomButtonWidget(
                                  btnTxt: getTranslated(
                                      status == 0 ? 'track_order' : 'back_home',
                                      context),
                                  onTap: () {
                                    if (status == 0) {
                                      Navigator.pushReplacementNamed(
                                          context,
                                          Routes.getOrderTrackingRoute(
                                            int.parse(orderID!),
                                          ));
                                    } else {
                                      Navigator.pushNamedAndRemoveUntil(
                                          context,
                                          Routes.getMainRoute(),
                                          (route) => false);
                                    }
                                  }),
                            ),
                          ),
                        ]),
                  ),
                )),
              ),
            ],
          ),
        ))),
        const FooterWebWidget(footerType: FooterType.sliver),
      ]),
    );
  }
}
