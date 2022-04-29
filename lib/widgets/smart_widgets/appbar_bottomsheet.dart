import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies_app/views/search_shows/search_shows_view_model.dart';

import '../../theme/colors.dart';
import '../../theme/styles.dart';

Widget appbarBottomSheet(Size size, SearchShowsViewModel viewModel, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Flexible(
          child: Container(
            height: size.height * 0.080,
            width: size.width,
            margin: const EdgeInsets.only(left: 15, right: 15, bottom: 8),
            decoration: BoxDecoration(
              border: Border.all(color: kWhiteColor),
              borderRadius: BorderRadius.circular(20),
              color: Colors.transparent,
            ),
            child: Center(
              child: TextField(
                showCursor: true,
                controller: viewModel.searchController,
                cursorColor: MyStyles.themeData().primaryColor,
                keyboardType: TextInputType.name,
                textAlignVertical: TextAlignVertical.center,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                      RegExp(r'[A-Za-z0-9#+-.?_%*&@!$/=();:"" ]*')),
                  LengthLimitingTextInputFormatter(25),
                ],
                // ignore: avoid_types_as_parameter_names
                onChanged: (text) {
                  if (text.isEmpty) {
                    viewModel.isSearchTaped = false;
                  }
                },
                scrollPadding: const EdgeInsets.symmetric(horizontal: 7),
                style: GoogleFonts.nunito(
                    color: MyStyles.themeData().cardColor,
                    fontSize: size.height * 0.020,
                    fontWeight: FontWeight.w300),
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: GoogleFonts.nunito(
                      color: MyStyles.themeMode().hintTextColor,
                      fontSize: size.height * 0.018,
                      fontWeight: FontWeight.w300),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide:
                        BorderSide(color: MyStyles.themeData().cardColor),
                    gapPadding: 0,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      color: MyStyles.themeData().primaryColor,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide:
                        BorderSide(color: MyStyles.themeMode().textColor),
                    gapPadding: 0,
                  ),
                  suffixIcon: InkWell(
                    onTap: () {
                      if (viewModel.searchController.text.isNotEmpty) {
                        viewModel.isLoading = true;
                        if (viewModel.isSearchTaped == false) {
                        // ignore: cascade_invocations
                        viewModel.isSearchTaped = true;
                        FocusScope.of(context)
                            .requestFocus(FocusNode());
                        } else {
                          viewModel.isSearchTaped = false;
                        }
                      }
                    },
                    child: Icon(
                      Icons.search_rounded,
                      color: MyStyles.themeData().cardColor,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
