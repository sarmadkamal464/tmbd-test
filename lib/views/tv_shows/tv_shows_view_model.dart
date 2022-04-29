import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:movies_app/core/locator.dart';
import 'package:movies_app/core/services/shows.service.dart';
import 'package:movies_app/core/utils/user_secure.storage.dart';
import 'package:stacked/stacked.dart';
import 'package:movies_app/core/logger.dart';

class TvShowsViewModel extends FutureViewModel {
  Logger log;
  final ShowsService _showsService = locator<ShowsService>();

  // Properties

  List<bool> _isFavoriteList;
  List<bool> get isFavoriteList => _isFavoriteList;
  set isFavoriteList(List<bool> value) {
    _isFavoriteList = value;
    notifyListeners();
  }

  List<int> _getFavoriteList;
  List<int> get getFavoriteList => _getFavoriteList;
  set getFavoriteList(List<int> value) {
    _getFavoriteList = value;
    notifyListeners();
  }

  int _selectedIndex;
  int get selectedIndex => _selectedIndex;
  set selectedIndex(int value) {
    _selectedIndex = value;
    notifyListeners();
  }

  List<int> favoriteList;

  bool isLoading;
  dynamic result;

  // Constructor
  TvShowsViewModel() {
    log = getLogger(runtimeType.toString());
    isLoading = true;
    selectedIndex = -1;
    favoriteList = [];
    getFavoriteList = [];
    isFavoriteList = List<bool>.filled(20, false, growable: true);
  }

  // Public Methods

  // Get tv shows data from api service
  Future<List<Map<String, dynamic>>> tvShowResult(
      {BuildContext context}) async {
    result = await _showsService.getTvShows(context: context);
    return result;
  }

  // update favorite list in local storage
  Future<void> updateFavoriteList({int index, int id}) async {
    isFavoriteList[index] = !isFavoriteList[index];
    if (!getFavoriteList.contains(id)) {
      getFavoriteList.add(id);
      await UserSecureStorage.setFavorites(getFavoriteList);
    } else {
      getFavoriteList.remove(id);
      await UserSecureStorage.setFavorites(getFavoriteList);
    }
    notifyListeners();
  }

  @override
  Future<String> futureToRun() => getData();

  Future<String> getData() async {
    try {
      getFavoriteList = await UserSecureStorage.getFavorites();
    } catch (e) {
      print(e);
    }
    return 'success';
  }
}
