import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:movies_app/core/logger.dart';

import '../../core/locator.dart';
import '../../core/services/shows.service.dart';
import '../../core/utils/user_secure.storage.dart';

class FavoriteTvShowsViewModel extends FutureViewModel {
  Logger log;

  //  Imports
  final ShowsService _showsService = locator<ShowsService>();

  // Properties
  List<int> _getFavoriteList;
  List<int> get getFavoriteList => _getFavoriteList;
  set getFavoriteList(List<int> value) {
    _getFavoriteList = value;
    notifyListeners();
  }

  List<Map<String, dynamic>> result;
  List<Map<String, dynamic>> filteredResult;

  // construction
  FavoriteTvShowsViewModel() {
    log = getLogger(runtimeType.toString());
    filteredResult = [];
  }

  // public methods
  Future<void> tvShowResult({BuildContext context}) async {
    result = await _showsService.getTvShows(context: context);
    
  }

  @override
  Future<String> futureToRun() => getData();

  Future<String> getData() async {
    try {
      getFavoriteList = await UserSecureStorage.getFavorites();
      await tvShowResult();
      for (var i = 0; i < result.length; i++) {
      if (getFavoriteList.contains(result[i]['id'])) {
        filteredResult.add(result[i]);
      }
    }
    } catch (e) {
      print(e);
    }
    return 'success';
  }
}
