import 'package:klixstore/features/home/widgets/arrow_icon_button_widget.dart';
import 'package:klixstore/helper/responsive_helper.dart';
import 'package:klixstore/main.dart';
import 'package:klixstore/utill/dimensions.dart';
import 'package:flutter/material.dart';

class CustomSliderListWidget extends StatefulWidget {
  final ScrollController controller;
  final double verticalPosition;
  final double horizontalPosition;
  final bool isShowForwardButton;
  final Widget child;
  const CustomSliderListWidget({
    Key? key,
    required this.controller,
    required this.verticalPosition,
    this.horizontalPosition = 0,
    required this.child,
    this.isShowForwardButton = true,
  }) : super(key: key);

  @override
  State<CustomSliderListWidget> createState() => _CustomSliderListWidgetState();
}

class _CustomSliderListWidgetState extends State<CustomSliderListWidget> {
  bool showBackButton = false;
  bool showForwardButton = false;
  bool isFirstTime = true;

  @override
  void initState() {
    widget.controller.addListener(_checkScrollPosition);
    super.initState();
  }

  @override
  void dispose() {
    if (ResponsiveHelper.isDesktop(Get.context!)) {
      widget.controller.dispose();
    }
    super.dispose();
  }

  void _checkScrollPosition() {
    setState(() {
      if (widget.controller.position.pixels <= 0) {
        showBackButton = false;
      } else {
        showBackButton = true;
      }

      if (widget.controller.position.pixels >=
          widget.controller.position.maxScrollExtent) {
        showForwardButton = false;
      } else {
        showForwardButton = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isShowForwardButton && isFirstTime) {
      setState(() {
        showForwardButton = true;
      });
    }
    isFirstTime = false;

    return ResponsiveHelper.isDesktop(context)
        ? Stack(
            children: [
              widget.child,
              if (showBackButton)
                Positioned(
                  top: widget.verticalPosition,
                  left: widget.horizontalPosition,
                  child: ArrowIconButtonWidget(
                    isRight: false,
                    onTap: () => widget.controller.animateTo(
                        widget.controller.offset - Dimensions.webScreenWidth,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut),
                  ),
                ),
              if (showForwardButton)
                Positioned(
                  top: widget.verticalPosition,
                  right: widget.horizontalPosition,
                  child: ArrowIconButtonWidget(
                    onTap: () => widget.controller.animateTo(
                        widget.controller.offset + Dimensions.webScreenWidth,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut),
                  ),
                ),
            ],
          )
        : widget.child;
  }
}
