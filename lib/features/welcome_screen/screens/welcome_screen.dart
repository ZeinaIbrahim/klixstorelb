import 'package:klixstore/common/widgets/custom_pop_scope_widget.dart';
import 'package:flutter/material.dart';
import 'package:klixstore/helper/responsive_helper.dart';
import 'package:klixstore/localization/language_constrants.dart';
import 'package:klixstore/features/splash/providers/splash_provider.dart';
import 'package:klixstore/utill/color_resources.dart';
import 'package:klixstore/utill/dimensions.dart';
import 'package:klixstore/utill/images.dart';
import 'package:klixstore/utill/routes.dart';
import 'package:klixstore/utill/styles.dart';
import 'package:klixstore/common/widgets/custom_button_widget.dart';
import 'package:klixstore/common/widgets/main_app_bar_widget.dart';
import 'package:provider/provider.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPopScopeWidget(
      child: Scaffold(
        appBar: ResponsiveHelper.isDesktop(context)
            ? const PreferredSize(
                preferredSize: Size.fromHeight(80), child: MainAppBarWidget())
            : null,
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Center(
            child: SizedBox(
              width: Dimensions.webScreenWidth,
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  Container(
                    alignment: Alignment.bottomCenter,
                    padding: const EdgeInsets.all(30),
                    child: ResponsiveHelper.isWeb()
                        ? Consumer<SplashProvider>(
                            builder: (context, splash, child) =>
                                FadeInImage.assetNetwork(
                              placeholder: Images.placeholder(context),
                              image: splash.baseUrls != null
                                  ? '${splash.baseUrls!.ecommerceImageUrl}/${splash.configModel!.appLogo}'
                                  : '',
                              height: 200,
                            ),
                          )
                        : Image.asset(Images.logo, height: 200),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    getTranslated('welcome', context),
                    textAlign: TextAlign.center,
                    style: rubikRegular.copyWith(
                        color: Theme.of(context).textTheme.bodyLarge!.color,
                        fontSize: 32),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.all(Dimensions.paddingSizeDefault),
                    child: Text(
                      getTranslated('welcome_to_efood', context),
                      textAlign: TextAlign.center,
                      style: rubikMedium.copyWith(
                          color: ColorResources.getGreyColor(context)),
                    ),
                  ),
                  const SizedBox(height: 50),
                  Padding(
                    padding:
                        const EdgeInsets.all(Dimensions.paddingSizeDefault),
                    child: CustomButtonWidget(
                      btnTxt: getTranslated('login', context),
                      onTap: () {
                        Navigator.pushReplacementNamed(
                            context, Routes.getLoginRoute());
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: Dimensions.paddingSizeDefault,
                        right: Dimensions.paddingSizeDefault,
                        bottom: Dimensions.paddingSizeDefault,
                        top: 12),
                    child: CustomButtonWidget(
                      btnTxt: getTranslated('signup', context),
                      onTap: () {
                        Navigator.pushNamed(
                            context, Routes.getCreateAccountRoute());
                      },
                      backgroundColor: Colors.black,
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      minimumSize: const Size(1, 40),
                    ),
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, Routes.getMainRoute());
                    },
                    child: RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: '${getTranslated('login_as_a', context)} ',
                          style: rubikRegular.copyWith(
                              color: ColorResources.getGreyColor(context))),
                      TextSpan(
                          text: getTranslated('guest', context),
                          style: rubikMedium.copyWith(
                              color: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .color)),
                    ])),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
