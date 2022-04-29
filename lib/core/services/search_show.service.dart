import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:movies_app/core/base/base_service.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import '../utils/urls.dart';


class SearchShowsService extends BaseService {
  SearchShowsService();

  // ignore: missing_return
  Future<List<Map<String, dynamic>>> searchShows({
    BuildContext context,
    String searchInput,
  }) async {
    List<Map<String, dynamic>> result;

    const baseURL = Urls.baseUrl;
    const user = '$baseURL/search/tv';
    var uri = Uri.parse('$user?${Urls.apiKey}&query=$searchInput');

    var hdrs = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };
    try {
      final response = await http.get(uri, headers: hdrs);
      // var jsonResponse = json.decode(response.body);
      if (response.statusCode == 200) {
        var jsonResult = json.decode(response.body)['results'];
        result = List<Map<String, dynamic>>.from(jsonResult);
        return result;
      }
    } on SocketException {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.redAccent,
          dismissDirection: DismissDirection.horizontal,
          elevation: 10,
          content: Text(
            'Something went wrong! Please try later',
            style: GoogleFonts.poppins(
                fontSize: 14, color: Colors.white, fontWeight: FontWeight.w600),
          ),
        ),
      );
    }
  }
}
