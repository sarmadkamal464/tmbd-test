import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:movies_app/views/tv_shows/tv_shows_view.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../core/locator.dart';
import '../../theme/styles.dart';

Widget bottomNavigation({
  BuildContext context,
  int selectedIndex,
}) {
  //imports
  var size = MediaQuery.of(context).size;
  final NavigationService _router = locator<NavigationService>();
  return BottomAppBar(
    // notchMargin: size.height * 0.015,
    elevation: 0.0,
    color: selectedIndex == 1 || selectedIndex == 2
        ? MyStyles.themeData().secondaryHeaderColor
        : MyStyles.themeData().backgroundColor,
    //  shape: CircularNotchedRectangle(),
    child: Container(
      height: size.height * 0.090,
      decoration: BoxDecoration(
          color: MyStyles.themeData().primaryColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
          boxShadow: [
            BoxShadow(
                blurRadius: 12,
                color:
                    MyStyles.themeData().secondaryHeaderColor.withOpacity(0.50),
                offset: const Offset(4, 0),
                spreadRadius: 0)
          ]),
      child: Padding(
        padding: const EdgeInsets.only(top: 0.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BottomIcon(
              icon: Icon(
                Icons.home_rounded,
                color: MyStyles.themeData().backgroundColor,
              ),
              padding: const EdgeInsets.all(0.0),
              index: 0,
              selectedIndex: selectedIndex,
              title: 'Home',
              pressEvent: () async {
                await _router.navigateToView(
                  const TvShowsView(),
                );
              },
            ),
            BottomIcon(
              icon: Icon(
                Icons.favorite_rounded,
                color: MyStyles.themeData().backgroundColor,
              ),
              padding: const EdgeInsets.all(0.0),
              index: 0,
              selectedIndex: selectedIndex,
              title: 'Favorite',
              pressEvent: () async {
                await _router.navigateToView(
                  const TvShowsView(),
                );
              },
            ),
          ],
        ),
      ),
    ),
  );
}

class BottomIcon extends StatelessWidget {
  const BottomIcon({
    Key key,
    this.icon,
    this.padding,
    this.pressEvent,
    this.selectedIndex,
    this.index,
    this.title,
  }) : super(key: key);

  final Widget icon;
  final String title;
  final EdgeInsetsGeometry padding;
  final GestureTapCallback pressEvent;
  final int selectedIndex;
  final int index;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          // width: 30,
          height: 30,
          child: IconButton(
            onPressed: pressEvent,
            padding: const EdgeInsets.all(0),
            icon: icon,
          ),
        ),
        index == selectedIndex
            ? Text(
                title,
                style: GoogleFonts.nunito(
                    fontSize: size.height * 0.018,
                    color: index == selectedIndex
                        ? MyStyles.themeData().backgroundColor
                        : MyStyles.themeMode().textColor,
                    fontWeight: index == selectedIndex
                        ? FontWeight.w700
                        : FontWeight.w400),
              )
            : Container(
                height: size.height * 0.018,
              ),
      ],
    );
  }
}
