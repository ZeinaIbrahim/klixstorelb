import 'package:klixstore/features/splash/providers/splash_provider.dart';
import 'package:klixstore/utill/app_constants.dart';
import 'package:klixstore/common/widgets/custom_alert_dialog_widget.dart';
import 'package:klixstore/common/widgets/custom_asset_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:klixstore/helper/responsive_helper.dart';
import 'package:klixstore/localization/language_constrants.dart';
import 'package:klixstore/features/auth/providers/auth_provider.dart';
import 'package:klixstore/provider/theme_provider.dart';
import 'package:klixstore/utill/dimensions.dart';
import 'package:klixstore/utill/images.dart';
import 'package:klixstore/utill/routes.dart';
import 'package:klixstore/utill/styles.dart';
import 'package:provider/provider.dart';

class OptionsWidget extends StatelessWidget {
  final Function? onTap;
  const OptionsWidget({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final policyModel =
        Provider.of<SplashProvider>(context, listen: false).policyModel;

    return SingleChildScrollView(
      padding: EdgeInsets.zero,
      physics: const BouncingScrollPhysics(),
      child: Center(
        child: SizedBox(
          width: ResponsiveHelper.isTab(context)
              ? null
              : Dimensions.webScreenWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: ResponsiveHelper.isTab(context) ? 50 : 0),
              SwitchListTile(
                value: Provider.of<ThemeProvider>(context).darkTheme,
                onChanged: (bool isActive) =>
                    Provider.of<ThemeProvider>(context, listen: false)
                        .toggleTheme(),
                title: Text(getTranslated('dark_theme', context),
                    style: rubikMedium.copyWith(
                        fontSize: Dimensions.fontSizeLarge)),
                activeColor: Theme.of(context).primaryColor,
              ),
              ResponsiveHelper.isTab(context)
                  ? ListTile(
                      onTap: () => Navigator.pushNamed(
                          context, Routes.getDashboardRoute('home')),
                      leading: CustomAssetImageWidget(Images.home,
                          width: 20,
                          height: 20,
                          color: Theme.of(context).textTheme.bodyLarge!.color),
                      title: Text(getTranslated('home', context),
                          style: rubikMedium.copyWith(
                              fontSize: Dimensions.fontSizeLarge)),
                    )
                  : const SizedBox(),
              ListTile(
                onTap: () =>
                    Navigator.pushNamed(context, Routes.getOrderListScreen()),
                leading: CustomAssetImageWidget(Images.order,
                    width: 20,
                    height: 20,
                    color: Theme.of(context).textTheme.bodyLarge!.color),
                title: Text(getTranslated('my_order', context),
                    style: rubikMedium.copyWith(
                        fontSize: Dimensions.fontSizeLarge)),
              ),
              ListTile(
                onTap: () =>
                    Navigator.pushNamed(context, Routes.getProfileRoute()),
                leading: CustomAssetImageWidget(Images.profile,
                    width: 20,
                    height: 20,
                    color: Theme.of(context).textTheme.bodyLarge!.color),
                title: Text(getTranslated('profile', context),
                    style: rubikMedium.copyWith(
                        fontSize: Dimensions.fontSizeLarge)),
              ),
              ListTile(
                onTap: () =>
                    Navigator.pushNamed(context, Routes.getAddressRoute()),
                leading: CustomAssetImageWidget(Images.address,
                    width: 20,
                    height: 20,
                    color: Theme.of(context).textTheme.bodyLarge!.color),
                title: Text(getTranslated('address', context),
                    style: rubikMedium.copyWith(
                        fontSize: Dimensions.fontSizeLarge)),
              ),
              ListTile(
                onTap: () =>
                    Navigator.pushNamed(context, Routes.getChatRoute()),
                leading: CustomAssetImageWidget(Images.message,
                    width: 20,
                    height: 20,
                    color: Theme.of(context).textTheme.bodyLarge!.color),
                title: Text(getTranslated('message', context),
                    style: rubikMedium.copyWith(
                        fontSize: Dimensions.fontSizeLarge)),
              ),
              ListTile(
                onTap: () =>
                    Navigator.pushNamed(context, Routes.getCouponRoute()),
                leading: CustomAssetImageWidget(Images.coupon,
                    width: 20,
                    height: 20,
                    color: Theme.of(context).textTheme.bodyLarge!.color),
                title: Text(getTranslated('coupon', context),
                    style: rubikMedium.copyWith(
                        fontSize: Dimensions.fontSizeLarge)),
              ),
              ListTile(
                onTap: () => Navigator.pushNamed(
                    context, Routes.getLanguageRoute('menu')),
                leading: CustomAssetImageWidget(Images.language,
                    width: 20,
                    height: 20,
                    color: Theme.of(context).textTheme.bodyLarge!.color),
                title: Text(getTranslated('language', context),
                    style: rubikMedium.copyWith(
                        fontSize: Dimensions.fontSizeLarge)),
              ),
              ListTile(
                onTap: () =>
                    Navigator.pushNamed(context, Routes.getSupportRoute()),
                leading: CustomAssetImageWidget(Images.helpSupport,
                    width: 20,
                    height: 20,
                    color: Theme.of(context).textTheme.bodyLarge!.color),
                title: Text(getTranslated('help_and_support', context),
                    style: rubikMedium.copyWith(
                        fontSize: Dimensions.fontSizeLarge)),
              ),
              ListTile(
                onTap: () =>
                    Navigator.pushNamed(context, Routes.getPolicyRoute()),
                leading: CustomAssetImageWidget(Images.privacyPolicy,
                    width: 20,
                    height: 20,
                    color: Theme.of(context).textTheme.bodyLarge!.color),
                title: Text(getTranslated('privacy_policy', context),
                    style: rubikMedium.copyWith(
                        fontSize: Dimensions.fontSizeLarge)),
              ),
              ListTile(
                onTap: () =>
                    Navigator.pushNamed(context, Routes.getTermsRoute()),
                leading: CustomAssetImageWidget(Images.termsAndCondition,
                    width: 20,
                    height: 20,
                    color: Theme.of(context).textTheme.bodyLarge!.color),
                title: Text(getTranslated('terms_and_condition', context),
                    style: rubikMedium.copyWith(
                        fontSize: Dimensions.fontSizeLarge)),
              ),
              if (policyModel != null &&
                  policyModel.returnPage != null &&
                  policyModel.returnPage!.status!)
                ListTile(
                  onTap: () => Navigator.pushNamed(
                      context, Routes.getReturnPolicyRoute()),
                  leading: CustomAssetImageWidget(Images.refundPolicy,
                      width: 20,
                      height: 20,
                      color: Theme.of(context).textTheme.bodyLarge!.color),
                  title: Text(getTranslated('return_policy', context),
                      style: rubikMedium.copyWith(
                          fontSize: Dimensions.fontSizeLarge)),
                ),
              if (policyModel != null &&
                  policyModel.refundPage != null &&
                  policyModel.refundPage!.status!)
                ListTile(
                  onTap: () => Navigator.pushNamed(
                      context, Routes.getRefundPolicyRoute()),
                  leading: CustomAssetImageWidget(Images.refundPolicy,
                      width: 20,
                      height: 20,
                      color: Theme.of(context).textTheme.bodyLarge!.color),
                  title: Text(getTranslated('refund_policy', context),
                      style: rubikMedium.copyWith(
                          fontSize: Dimensions.fontSizeLarge)),
                ),
              if (policyModel != null &&
                  policyModel.cancellationPage != null &&
                  policyModel.cancellationPage!.status!)
                ListTile(
                  onTap: () => Navigator.pushNamed(
                      context, Routes.getCancellationPolicyRoute()),
                  leading: CustomAssetImageWidget(Images.cancellationPolicy,
                      width: 20,
                      height: 20,
                      color: Theme.of(context).textTheme.bodyLarge!.color),
                  title: Text(getTranslated('cancellation_policy', context),
                      style: rubikMedium.copyWith(
                          fontSize: Dimensions.fontSizeLarge)),
                ),
              ListTile(
                onTap: () =>
                    Navigator.pushNamed(context, Routes.getAboutUsRoute()),
                leading: CustomAssetImageWidget(Images.aboutUs,
                    width: 20,
                    height: 20,
                    color: Theme.of(context).textTheme.bodyLarge!.color),
                title: Text(getTranslated('about_us', context),
                    style: rubikMedium.copyWith(
                        fontSize: Dimensions.fontSizeLarge)),
              ),
              ListTile(
                leading: CustomAssetImageWidget(Images.version,
                    width: 20,
                    height: 20,
                    color: Theme.of(context).textTheme.bodyLarge!.color),
                title: Text(getTranslated('version', context),
                    style: rubikMedium.copyWith(
                        fontSize: Dimensions.fontSizeLarge)),
                trailing: Text(
                    Provider.of<SplashProvider>(context, listen: false)
                            .configModel!
                            .softwareVersion ??
                        '${AppConstants.appVersion}',
                    style: rubikMedium.copyWith(
                        fontSize: Dimensions.fontSizeLarge)),
                //
              ),
              authProvider.isLoggedIn()
                  ? ListTile(
                      onTap: () {
                        ResponsiveHelper.showDialogOrBottomSheet(context,
                            Consumer<AuthProvider>(
                                builder: (context, authProvider, _) {
                          return CustomAlertDialogWidget(
                            title: getTranslated(
                                'are_you_sure_to_delete_account', context),
                            subTitle: getTranslated(
                                'it_will_remove_your_all_information', context),
                            icon: Icons.contact_support_outlined,
                            isLoading: authProvider.isLoading,
                            onPressRight: () => authProvider.deleteUser(),
                          );
                        }));
                      },
                      leading: Icon(Icons.delete,
                          size: 20,
                          color: Theme.of(context).textTheme.bodyLarge!.color),
                      title: Text(getTranslated('delete_account', context),
                          style: rubikMedium.copyWith(
                              fontSize: Dimensions.fontSizeLarge)),
                    )
                  : const SizedBox(),
              ListTile(
                onTap: () {
                  if (authProvider.isLoggedIn()) {
                    ResponsiveHelper.showDialogOrBottomSheet(
                        context,
                        CustomAlertDialogWidget(
                          title: getTranslated('want_to_sign_out', context),
                          icon: Icons.contact_support_outlined,
                          onPressRight: () {
                            Provider.of<AuthProvider>(context, listen: false)
                                .clearSharedData();
                            if (ResponsiveHelper.isWeb()) {
                              Navigator.pushNamedAndRemoveUntil(context,
                                  Routes.getMainRoute(), (route) => false);
                            } else {
                              Navigator.pushNamedAndRemoveUntil(context,
                                  Routes.getSplashRoute(), (route) => false);
                            }
                          },
                        ));
                  } else {
                    Navigator.pushNamed(context, Routes.getLoginRoute());
                  }
                },
                leading: CustomAssetImageWidget(Images.login,
                    width: 20,
                    height: 20,
                    color: Theme.of(context).textTheme.bodyLarge!.color),
                title: Text(
                    getTranslated(
                        authProvider.isLoggedIn() ? 'logout' : 'login',
                        context),
                    style: rubikMedium.copyWith(
                        fontSize: Dimensions.fontSizeLarge)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
