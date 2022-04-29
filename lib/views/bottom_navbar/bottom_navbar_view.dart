import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';

import '../../theme/styles.dart';
import './bottom_navbar_view_model.dart';

class BottomNavbarView extends StatelessWidget {
  const BottomNavbarView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return ViewModelBuilder<BottomNavbarViewModel>.reactive(
      viewModelBuilder: () => BottomNavbarViewModel(),
      builder: (
        BuildContext context,
        BottomNavbarViewModel model,
        Widget child,
      ) {
        return SafeArea(
          top: false,
          child: WillPopScope(
            onWillPop: () async => false,
            child: Scaffold(
              extendBody: true,
              body: model.screens[model.bottomIndexSelected],
              bottomNavigationBar: CurvedNavigationBar(
                backgroundColor: Colors.transparent,
                index: model.bottomIndexSelected,
                key: model.bottomNavigationKey,
                color: MyStyles.themeData().primaryColor,
                buttonBackgroundColor: MyStyles.themeData().primaryColor,
                items: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      model.bottomIndexSelected != 0
                          ? SizedBox(height: size.height * 0.015)
                          : SizedBox(height: size.height * 0),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.home_rounded,
                          color: MyStyles.themeData().backgroundColor,
                        ),
                      ),
                      model.bottomIndexSelected != 0
                          ? Text(
                              'Home',
                              style: GoogleFonts.ubuntu(
                                  fontSize: size.height * 0.014,
                                  fontWeight: FontWeight.w500,
                                  color: MyStyles.themeData().backgroundColor),
                            )
                          : Container()
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      model.bottomIndexSelected != 1
                          ? SizedBox(height: size.height * 0.015)
                          : SizedBox(height: size.height * 0),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.search,
                          color: MyStyles.themeData().backgroundColor,
                        ),
                      ),
                      model.bottomIndexSelected != 1
                          ? Text(
                              'Search',
                              style: GoogleFonts.ubuntu(
                                  fontSize: size.height * 0.014,
                                  color: MyStyles.themeData().backgroundColor),
                            )
                          : Container()
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      model.bottomIndexSelected != 2
                          ? SizedBox(height: size.height * 0.015)
                          : SizedBox(height: size.height * 0),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.favorite_rounded,
                          color: MyStyles.themeData().backgroundColor,
                        ),
                      ),
                      model.bottomIndexSelected != 2
                          ? Text(
                              'Favorite',
                              style: GoogleFonts.ubuntu(
                                  fontSize: size.height * 0.014,
                                  color: MyStyles.themeData().backgroundColor),
                            )
                          : Container()
                    ],
                  ),
                ],
                animationCurve: Curves.easeInOut,
                animationDuration: const Duration(milliseconds: 600),
                letIndexChange: (index) => true,
                onTap: (index) {
                  model.bottomIndexSelected = index;
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
