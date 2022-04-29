import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:movies_app/core/logger.dart';

import '../../core/locator.dart';
import '../../core/services/search_show.service.dart';

class SearchShowsViewModel extends FutureViewModel {
  Logger log;
  final SearchShowsService _searchShowsService = locator<SearchShowsService>();
  
  // properties
  TextEditingController searchController = TextEditingController();

  bool _isSearchTaped;
  bool get isSearchTaped => this._isSearchTaped;
  set isSearchTaped(bool value) {
    _isSearchTaped = value;
    notifyListeners();
  }

  bool isLoading;
  var searchResult;

  // constructor
  SearchShowsViewModel() {
    log = getLogger(runtimeType.toString());
    isSearchTaped = false;
    isLoading = true;
  }

  // public methods

  // Get searched tv shows data from api service
  Future<List<Map<String, dynamic>>> searchData({BuildContext context}) async {
    searchResult = await _searchShowsService.searchShows(context: context, searchInput: searchController.text.trim());
    return searchResult;
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
