import 'package:klixstore/common/enums/footer_type_enum.dart';
import 'package:klixstore/helper/responsive_helper.dart';
import 'package:klixstore/common/widgets/footer_web_widget.dart';
import 'package:flutter/material.dart';

import 'web_app_bar_widget.dart';

class NotFound extends StatelessWidget {
  const NotFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: ResponsiveHelper.isDesktop(context)
          ? const PreferredSize(
              preferredSize: Size.fromHeight(90), child: WebAppBarWidget())
          : null,
      body: SingleChildScrollView(
        child: Column(
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(
                  minHeight:
                      !ResponsiveHelper.isDesktop(context) && height < 600
                          ? height
                          : height - 400),
              child: Center(
                child: TweenAnimationBuilder(
                  curve: Curves.bounceOut,
                  duration: const Duration(seconds: 2),
                  tween: Tween<double>(begin: 12.0, end: 30.0),
                  builder:
                      (BuildContext context, dynamic value, Widget? child) {
                    return Text('Page Not Found',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: value));
                  },
                ),
              ),
            ),
            const FooterWebWidget(footerType: FooterType.nonSliver),
          ],
        ),
      ),
    );
  }
}
