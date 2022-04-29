
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../core/locator.dart';
import '../../theme/styles.dart';

class AppBarWidget extends StatelessWidget {
  final bool leading;
  final List<Widget> action;
  final String title;
  final Widget bottomChild;
  //imports
  final NavigationService _nav = locator<NavigationService>();

  AppBarWidget({
    this.leading = true,
    this.title,
    this.action, this.bottomChild,
  });
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return AppBar(
      title: Text(
        title,
        style: GoogleFonts.nunito(
          color: MyStyles.themeData().primaryColor,
          fontSize: size.height * 0.030,
          fontWeight: FontWeight.w800,
        ),
      ),
      centerTitle: true,
      elevation: 0.0,
      leading: leading ?
           IconButton(
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: MyStyles.themeData().primaryColor,
                size: size.height * 0.030,
              ),
              onPressed: () {
                _nav.back();
              },
            )
          : Container(),
      actions:action,
      backgroundColor: MyStyles.themeData().backgroundColor,
      bottom: PreferredSize(
            preferredSize: const Size.fromHeight(100),
            child: bottomChild,
          ),
    );
  }
}
