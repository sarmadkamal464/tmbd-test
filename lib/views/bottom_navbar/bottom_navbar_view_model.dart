import 'package:movies_app/views/favorite_tv_shows/favorite_tv_shows_view.dart';
import 'package:movies_app/views/search_shows/search_shows_view.dart';
import 'package:movies_app/views/tv_shows/tv_shows_view.dart';
import 'package:stacked/stacked.dart';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class BottomNavbarViewModel extends FutureViewModel {
    final GlobalKey<CurvedNavigationBarState> bottomNavigationKey =
      GlobalKey<CurvedNavigationBarState>();
  var screens = [
    const TvShowsView(),
    const SearchShowsView(),
    const FavoriteTvShowsView(),
  ];
  int _bottomIndexSelected;
  int get bottomIndexSelected => _bottomIndexSelected;
  set bottomIndexSelected(int value) {
    _bottomIndexSelected = value;
    notifyListeners();
  }

  BottomNavbarViewModel() {
    bottomIndexSelected = 0;
  }

  @override
  Future<String> futureToRun() => getData();

  Future<String> getData() async {
    try {} catch (e) {
      print(e);
    }
    return 'success';
  }
}
