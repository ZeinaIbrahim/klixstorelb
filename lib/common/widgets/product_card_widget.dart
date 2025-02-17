// ignore_for_file: prefer_const_constructors

import 'package:carousel_slider/carousel_slider.dart';
import 'package:klixstore/common/models/cart_model.dart';
import 'package:klixstore/common/models/product_model.dart';
import 'package:klixstore/helper/cart_helper.dart';
import 'package:klixstore/helper/price_converter_helper.dart';
import 'package:klixstore/helper/responsive_helper.dart';
import 'package:klixstore/localization/language_constrants.dart';
import 'package:klixstore/features/auth/providers/auth_provider.dart';
import 'package:klixstore/features/cart/providers/cart_provider.dart';
import 'package:klixstore/features/splash/providers/splash_provider.dart';
import 'package:klixstore/features/wishlist/providers/wishlist_provider.dart';
import 'package:klixstore/utill/color_resources.dart';
import 'package:klixstore/utill/dimensions.dart';
import 'package:klixstore/utill/routes.dart';
import 'package:klixstore/utill/styles.dart';
import 'package:klixstore/common/widgets/custom_alert_dialog_widget.dart';
import 'package:klixstore/common/widgets/custom_directionality_widget.dart';
import 'package:klixstore/common/widgets/custom_image_widget.dart';
import 'package:klixstore/helper/custom_snackbar_helper.dart';
import 'package:klixstore/common/widgets/on_hover.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductCardWidget extends StatelessWidget {
  final Product product;
  final Axis direction;
  final bool? newarrival;
  const ProductCardWidget(
      {Key? key,
      required this.product,
      this.direction = Axis.vertical,
      this.newarrival})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(builder: (context, cartProvider, _) {
      PriceRange priceRange = PriceConverterHelper.getPriceRange(product);
      double? discountedPrice = PriceConverterHelper.convertWithDiscount(
          product.price, product.discount, product.discountType);

      CartModel? cartModel = CartHelper.getCartModel(product);
      int? cartIndex = cartProvider.getCartProductIndex(cartModel);
      bool isExistInCart = cartIndex != null;

      return OnHover(
          isItem: true,
          child: InkWell(
            hoverColor: Colors.transparent,
            onTap: () => Navigator.of(context)
                .pushNamed(Routes.getProductDetailsRoute(product.id)),
            child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius:
                      BorderRadius.circular(Dimensions.paddingSizeDefault),
                  border: Border.all(
                      color: Theme.of(context).primaryColor.withOpacity(0.05),
                      width: 1),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).focusColor.withOpacity(0.05),
                      blurRadius: 30,
                      offset: const Offset(2, 10),
                    )
                  ]),
              padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
              child: direction == Axis.vertical
                  ? Column(mainAxisSize: MainAxisSize.min, children: [
                      ProductImageView(
                        newarrival: newarrival,
                        product: product,
                        isExistInCart: isExistInCart,
                        cartModel: cartModel,
                        cartIndex: cartIndex,
                        direction: direction,
                      ),
                      _ProductDescriptionView(
                        product: product,
                        discountedPrice: discountedPrice,
                        priceRange: priceRange,
                        direction: direction,
                      ),
                    ])
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                          ProductImageView(
                            newarrival: newarrival,
                            product: product,
                            isExistInCart: isExistInCart,
                            cartModel: cartModel,
                            cartIndex: cartIndex,
                            direction: direction,
                          ),
                          const SizedBox(width: Dimensions.paddingSizeSmall),
                          Flexible(
                            child: _ProductDescriptionView(
                              product: product,
                              discountedPrice: discountedPrice,
                              priceRange: priceRange,
                              direction: direction,
                            ),
                          ),
                        ]),
            ),
          ));
    });
  }
}

class _ProductDescriptionView extends StatelessWidget {
  const _ProductDescriptionView({
    Key? key,
    required this.product,
    required this.discountedPrice,
    required this.priceRange,
    required this.direction,
  }) : super(key: key);

  final Product product;
  final double? discountedPrice;
  final PriceRange priceRange;
  final Axis direction;

  @override
  Widget build(BuildContext context) {
    final isVertical = direction == Axis.vertical;

    return Column(
        crossAxisAlignment:
            isVertical ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [
          const SizedBox(height: Dimensions.paddingSizeSmall),
          Row(
              mainAxisAlignment: isVertical
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.spaceBetween,
              children: [
                product.rating != null &&
                        product.rating!.isNotEmpty &&
                        (product.rating!.first.average?.length ?? 0) > 0
                    ? _ProductRatingView(
                        isVertical: isVertical, product: product)
                    : const SizedBox(),
                if (!isVertical) ProductWishListButton(product: product)
              ]),
          const SizedBox(height: Dimensions.paddingSizeExtraSmall),
          Text(
            product.name ?? '',
            maxLines: 2,
            textAlign:
                direction == Axis.vertical ? TextAlign.center : TextAlign.start,
            overflow: TextOverflow.ellipsis,
            style: rubikRegular,
          ),
          const SizedBox(height: Dimensions.paddingSizeSmall),
          _PriceView(
              product: product,
              discountedPrice: discountedPrice,
              price: priceRange.startPrice ?? 0,
              direction: direction),
        ]);
  }
}

class _ProductRatingView extends StatelessWidget {
  const _ProductRatingView({
    Key? key,
    required this.isVertical,
    required this.product,
  }) : super(key: key);

  final bool isVertical;
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment:
            isVertical ? MainAxisAlignment.center : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.star_rounded,
              color: ColorResources.getRatingColor(context), size: 20),
          const SizedBox(width: Dimensions.paddingSizeSmall),
          Text(
              double.parse(product.rating?.first.average ?? '0')
                  .toStringAsFixed(1),
              style: rubikMedium),
        ]);
  }
}

class ProductWishListButton extends StatelessWidget {
  final Product product;
  const ProductWishListButton({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<WishListProvider>(builder: (context, wishListProvider, _) {
      return InkWell(
        onTap: () {
          if (Provider.of<AuthProvider>(context, listen: false).isLoggedIn()) {
            List<int?> productIdList = [];
            productIdList.add(product.id);

            if (wishListProvider.wishIdList.contains(product.id)) {
              ResponsiveHelper.showDialogOrBottomSheet(
                  context,
                  CustomAlertDialogWidget(
                    title: getTranslated('remove_from_wish_list', context),
                    subTitle: getTranslated(
                        'remove_this_item_from_your_favorite_list', context),
                    icon: Icons.contact_support_outlined,
                    leftButtonText: getTranslated('cancel', context),
                    rightButtonText: getTranslated('remove', context),
                    buttonColor:
                        Theme.of(context).colorScheme.error.withOpacity(0.9),
                    onPressRight: () {
                      Navigator.pop(context);
                      wishListProvider.removeFromWishList(product, context);
                    },
                  ));
            } else {
              wishListProvider.addToWishList(product);
            }
          } else {
            showCustomSnackBar(
                getTranslated('now_you_are_in_guest_mode', context), context);
          }
        },
        child: Container(
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor.withOpacity(0.9),
            border: Border.all(
                width: 0.6,
                color: Theme.of(context).hintColor.withOpacity(0.1)),
            borderRadius: BorderRadius.circular(Dimensions.radiusSizeDefault),
          ),
          alignment: Alignment.center,
          child: Icon(
              wishListProvider.wishIdList.contains(product.id)
                  ? Icons.favorite
                  : Icons.favorite_border,
              color: wishListProvider.wishIdList.contains(product.id)
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).primaryColor,
              size: Dimensions.paddingSizeDefault),
        ),
      );
    });
  }
}

class ProductImageView extends StatelessWidget {
  const ProductImageView({
    Key? key,
    required this.product,
    required this.isExistInCart,
    required this.cartModel,
    required this.cartIndex,
    required this.direction,
    this.newarrival,
  }) : super(key: key);

  final Product product;
  final bool isExistInCart;
  final CartModel? cartModel;
  final int? cartIndex;
  final Axis? direction;
  final bool? newarrival;

  @override
  Widget build(BuildContext context) {
    final SplashProvider splashProvider =
        Provider.of<SplashProvider>(context, listen: false);
    final isVertical = direction == Axis.vertical;

    return Consumer<CartProvider>(builder: (context, cartProvider, _) {
      List<String> images = product.image ?? [];
      return Container(
        decoration: BoxDecoration(
          border: Border.all(
              color: Theme.of(context).primaryColor.withOpacity(0.05),
              width: 1),
          borderRadius: BorderRadius.circular(Dimensions.paddingSizeDefault),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(Dimensions.paddingSizeDefault),
          child: Container(
            decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius:
                    BorderRadius.circular(Dimensions.paddingSizeDefault),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).focusColor.withOpacity(0.05),
                    blurRadius: 30,
                    offset: const Offset(15, 15),
                  )
                ]),
            child: Stack(children: [
              (images.length > 1 && newarrival == false)
                  ? CarouselSlider(
                      options: CarouselOptions(
                        height: 180,
                        viewportFraction: 1.0,
                        enlargeCenterPage: true,
                        autoPlay: true,
                      ),
                      items: images.map((image) {
                        // Check if baseUrls is not null before using it
                        final productImageUrl =
                            splashProvider.baseUrls?.productImageUrl;
                        if (productImageUrl != null) {
                          return CustomImageWidget(
                            image: '$productImageUrl/$image',
                            height: 160,
                            width: isVertical ? 350 : 150,
                          );
                        } else {
                          // Handle the case where productImageUrl is null
                          return SizedBox(); // Or you could show a placeholder image instead
                        }
                      }).toList(),
                    )
                  : CustomImageWidget(
                      image:
                          '${splashProvider.baseUrls!.productImageUrl}/${images.isNotEmpty ? images[0] : ''}',
                      height: 160,
                      width: isVertical ? 350 : 150,
                    ),
              if (isVertical)
                Positioned.fill(
                    child: Padding(
                  padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: ProductWishListButton(product: product),
                  ),
                )),
              Positioned.fill(
                  child: Padding(
                padding: const EdgeInsets.all(Dimensions.paddingSizeSmall)
                    .copyWith(top: isVertical ? 55 : 10),
                child: Align(
                  alignment: Alignment.topRight,
                  child: InkWell(
                    onTap: () {
                      if (product.variations == null ||
                          product.variations!.isEmpty) {
                        if (isExistInCart) {
                          showCustomSnackBar(
                              getTranslated('already_added', context), context);
                        } else if ((cartModel?.stock ?? 0) < 1) {
                          showCustomSnackBar(
                              getTranslated('out_of_stock', context), context);
                        } else {
                          cartProvider.addToCart(cartModel!, null);
                          showCustomSnackBar(
                              getTranslated('added_to_cart', context), context,
                              isError: false);
                        }
                      } else {
                        Navigator.of(context).pushNamed(
                            Routes.getProductDetailsRoute(product.id));
                      }
                    },
                    child: Container(
                      height: isExistInCart ? 80 : 35,
                      width: 35,
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor.withOpacity(0.9),
                        border: Border.all(
                            width: 0.6,
                            color:
                                Theme.of(context).hintColor.withOpacity(0.2)),
                        borderRadius:
                            BorderRadius.circular(Dimensions.radiusSizeDefault),
                      ),
                      alignment: Alignment.center,
                      child: isExistInCart
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                  InkWell(
                                    onTap: () => cartProvider.setQuantity(
                                      true,
                                      cartModel,
                                      cartModel?.stock,
                                      context,
                                      true,
                                      cartProvider
                                          .getCartProductIndex(cartModel),
                                    ),
                                    child: const Icon(Icons.add),
                                  ),
                                  const SizedBox(
                                      height: Dimensions.paddingSizeExtraSmall),
                                  Text(
                                      '${cartProvider.cartList[cartIndex!]?.quantity}',
                                      style: rubikBold.copyWith(
                                          color: Theme.of(context)
                                              .textTheme
                                              .titleLarge
                                              ?.color)),
                                  const SizedBox(
                                      height: Dimensions.paddingSizeExtraSmall),
                                  InkWell(
                                    onTap: () {
                                      if (cartProvider
                                              .cartList[cartIndex!]!.quantity! >
                                          1) {
                                        cartProvider.setQuantity(
                                          false,
                                          cartModel,
                                          cartModel!.stock,
                                          context,
                                          true,
                                          cartProvider
                                              .getCartProductIndex(cartModel),
                                        );
                                      } else if (cartProvider
                                              .cartList[cartIndex!]?.quantity ==
                                          1) {
                                        cartProvider.removeFromCart(
                                            cartProvider.cartList[cartIndex!]!);
                                      }
                                    },
                                    child: const Icon(Icons.remove_outlined),
                                  ),
                                ])
                          : Icon(
                              Icons.shopping_cart,
                              size: Dimensions.paddingSizeDefault,
                              color: Theme.of(context).primaryColor,
                            ),
                    ),
                  ),
                ),
              )),
              product.discount != 0
                  ? Positioned(
                      top: 0,
                      left: 0,
                      child: Transform.rotate(
                        angle: -0.5,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(8),
                              bottomLeft: Radius.circular(8),
                            ),
                          ),
                          child: Text(
                            product.discountType == 'percent'
                                ? '-${product.discount}%'
                                : '-${PriceConverterHelper.convertPrice(product.discount)}',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    )
                  : const SizedBox(),
            ]),
          ),
        ),
      );
    });
  }
}

class _PriceView extends StatelessWidget {
  const _PriceView({
    Key? key,
    required this.product,
    required this.discountedPrice,
    required this.price,
    this.direction = Axis.vertical,
  }) : super(key: key);

  final Product product;
  final double? discountedPrice;
  final double price;
  final Axis? direction;

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: direction == Axis.vertical
            ? MainAxisAlignment.center
            : MainAxisAlignment.start,
        children: [
          product.price! > discountedPrice!
              ? CustomDirectionalityWidget(
                  child: Text(PriceConverterHelper.convertPrice(price),
                      style: rubikRegular.copyWith(
                        color: Theme.of(context).hintColor,
                        decoration: TextDecoration.lineThrough,
                        fontSize: Dimensions.fontSizeExtraSmall,
                      )),
                )
              : const SizedBox(),
          Flexible(
              child: CustomDirectionalityWidget(
            child: Text(
              PriceConverterHelper.convertPrice(
                price,
                discount: product.discount,
                discountType: product.discountType,
              ),
              style: rubikMedium.copyWith(
                  color: Theme.of(context).textTheme.bodyLarge?.color),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          )),
        ]);
  }
}
