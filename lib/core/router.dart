// [ This is an auto generated file ]

import 'package:flutter/material.dart';
import 'package:movies_app/core/router_constants.dart';

import 'package:movies_app/views/tv_shows/tv_shows_view.dart' as view0;
import 'package:movies_app/views/favorite_tv_shows/favorite_tv_shows_view.dart' as view1;
import 'package:movies_app/views/bottom_navbar/bottom_navbar_view.dart' as view2;
import 'package:movies_app/views/search_shows/search_shows_view.dart' as view3;

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case tvShowsViewRoute:
        return MaterialPageRoute(builder: (_) => view0.TvShowsView());
      case favoriteTvShowsViewRoute:
        return MaterialPageRoute(builder: (_) => view1.FavoriteTvShowsView());
      case bottomNavbarViewRoute:
        return MaterialPageRoute(builder: (_) => view2.BottomNavbarView());
      case searchShowsViewRoute:
        return MaterialPageRoute(builder: (_) => view3.SearchShowsView());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}