import 'package:klixstore/common/models/address_model.dart';
import 'package:klixstore/features/address/providers/location_provider.dart';
import 'package:klixstore/features/address/widgets/address_button_widget.dart';
import 'package:klixstore/helper/responsive_helper.dart';
import 'package:klixstore/localization/language_constrants.dart';
import 'package:klixstore/utill/color_resources.dart';
import 'package:klixstore/utill/dimensions.dart';
import 'package:klixstore/utill/styles.dart';
import 'package:klixstore/common/widgets/custom_text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddressDetailsWidget extends StatelessWidget {
  final TextEditingController contactPersonNameController;
  final TextEditingController contactPersonNumberController;
  final FocusNode addressNode;
  final FocusNode nameNode;
  final FocusNode numberNode;
  final bool isUpdateEnable;
  final bool fromCheckout;
  final AddressModel? address;
  final TextEditingController locationTextController;
  final TextEditingController streetNumberController;
  final TextEditingController houseNumberController;
  final TextEditingController florNumberController;
  final FocusNode stateNode;
  final FocusNode houseNode;
  final FocusNode florNode;

  const AddressDetailsWidget({
    Key? key,
    required this.contactPersonNameController,
    required this.contactPersonNumberController,
    required this.addressNode,
    required this.nameNode,
    required this.numberNode,
    required this.isUpdateEnable,
    required this.fromCheckout,
    required this.address,
    required this.locationTextController,
    required this.streetNumberController,
    required this.houseNumberController,
    required this.stateNode,
    required this.houseNode,
    required this.florNumberController,
    required this.florNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    locationTextController.text =
        Provider.of<LocationProvider>(context).address ?? '';

    return Container(
      decoration: ResponsiveHelper.isDesktop(context)
          ? BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).shadowColor,
                    blurRadius: 10,
                  )
                ])
          : const BoxDecoration(),
      //margin: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL,vertical: Dimensions.PADDING_SIZE_LARGE),
      padding: ResponsiveHelper.isDesktop(context)
          ? const EdgeInsets.symmetric(
              horizontal: Dimensions.paddingSizeLarge,
              vertical: Dimensions.paddingSizeLarge)
          : EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24.0),
            child: Text(
              getTranslated('delivery_address', context),
              style: rubikRegular.copyWith(
                  color: ColorResources.getGreyBunkerColor(context),
                  fontSize: Dimensions.fontSizeLarge),
            ),
          ),
          // for Address Field
          Text(
            getTranslated('address_line_01', context),
            style: rubikMedium.copyWith(color: Theme.of(context).hintColor),
          ),
          const SizedBox(height: Dimensions.paddingSizeSmall),
          CustomTextFieldWidget(
            hintText: getTranslated('address_line_02', context),
            isShowBorder: true,
            inputType: TextInputType.streetAddress,
            inputAction: TextInputAction.next,
            focusNode: addressNode,
            nextFocus: nameNode,
            controller: locationTextController,
          ),
          const SizedBox(height: Dimensions.paddingSizeLarge),

          Text(
            '${getTranslated('street', context)} ${getTranslated('number', context)}',
            style: rubikRegular.copyWith(
                color: Theme.of(context).hintColor.withOpacity(0.6)),
          ),
          const SizedBox(height: Dimensions.paddingSizeSmall),

          CustomTextFieldWidget(
            hintText: getTranslated('ex_10_th', context),
            isShowBorder: true,
            inputType: TextInputType.streetAddress,
            inputAction: TextInputAction.next,
            focusNode: stateNode,
            nextFocus: houseNode,
            controller: streetNumberController,
          ),
          const SizedBox(height: Dimensions.paddingSizeLarge),

          Text(
            '${getTranslated('house', context)} / ${getTranslated('floor', context)} ${getTranslated('number', context)}',
            style: rubikRegular.copyWith(
                color: Theme.of(context).hintColor.withOpacity(0.6)),
          ),
          const SizedBox(height: Dimensions.paddingSizeSmall),
          Row(
            children: [
              Expanded(
                child: CustomTextFieldWidget(
                  hintText: getTranslated('ex_2', context),
                  isShowBorder: true,
                  inputType: TextInputType.streetAddress,
                  inputAction: TextInputAction.next,
                  focusNode: houseNode,
                  nextFocus: florNode,
                  controller: houseNumberController,
                ),
              ),
              const SizedBox(width: Dimensions.paddingSizeLarge),
              Expanded(
                child: CustomTextFieldWidget(
                  hintText: getTranslated('ex_2b', context),
                  isShowBorder: true,
                  inputType: TextInputType.streetAddress,
                  inputAction: TextInputAction.next,
                  focusNode: florNode,
                  nextFocus: nameNode,
                  controller: florNumberController,
                ),
              ),
            ],
          ),
          const SizedBox(height: Dimensions.paddingSizeLarge),

          // for Contact Person Name
          Text(
            getTranslated('contact_person_name', context),
            style: rubikMedium.copyWith(color: Theme.of(context).hintColor),
          ),
          const SizedBox(height: Dimensions.paddingSizeSmall),
          CustomTextFieldWidget(
            hintText: getTranslated('enter_contact_person_name', context),
            isShowBorder: true,
            inputType: TextInputType.name,
            controller: contactPersonNameController,
            focusNode: nameNode,
            nextFocus: numberNode,
            inputAction: TextInputAction.next,
            capitalization: TextCapitalization.words,
          ),
          const SizedBox(height: Dimensions.paddingSizeLarge),

          // for Contact Person Number
          Text(
            getTranslated('contact_person_number', context),
            style: rubikMedium.copyWith(color: Theme.of(context).hintColor),
          ),
          const SizedBox(height: Dimensions.paddingSizeSmall),
          CustomTextFieldWidget(
            hintText: getTranslated('enter_contact_person_number', context),
            isShowBorder: true,
            inputType: TextInputType.phone,
            inputAction: TextInputAction.done,
            focusNode: numberNode,
            controller: contactPersonNumberController,
          ),
          const SizedBox(height: Dimensions.paddingSizeLarge),

          if (ResponsiveHelper.isDesktop(context))
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.paddingSizeLarge),
              child: AddressButtonWidget(
                isUpdateEnable: isUpdateEnable,
                fromCheckout: fromCheckout,
                contactPersonNumberController: contactPersonNumberController,
                contactPersonNameController: contactPersonNameController,
                address: address,
                location: locationTextController.text,
                streetNumberController: streetNumberController,
                houseNumberController: houseNumberController,
                floorNumberController: florNumberController,
              ),
            )
        ],
      ),
    );
  }
}
