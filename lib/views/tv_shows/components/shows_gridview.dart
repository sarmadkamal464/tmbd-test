import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/utils/urls.dart';
import '../../../theme/styles.dart';
import '../tv_shows_view_model.dart';

Widget popularShowsGridView({Size size, TvShowsViewModel viewModel}) {
  return StreamBuilder(
      stream: viewModel.tvShowResult().asStream(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  'Error',
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  maxLines: 2,
                  style: GoogleFonts.poppins(
                    color: Colors.redAccent,
                    fontSize: size.height * 0.024,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting &&
            viewModel.isLoading) {
          return Center(
              child: CircularProgressIndicator(
            color: MyStyles.themeData().primaryColor,
          ));
        }

        if (snapshot.hasData && snapshot.data.length == 0) {
          return Center(
            child: Text(
              'No Shows Available',
              style: GoogleFonts.poppins(
                color: MyStyles.themeMode().cardColor,
                fontSize: size.height * 0.024,
                fontWeight: FontWeight.w600,
              ),
            ),
          );
        }
        viewModel.isLoading = false;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: StaggeredGridView.countBuilder(
            shrinkWrap: true,
            crossAxisCount: 4,
            physics: const ScrollPhysics(),
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) => GestureDetector(
              onTap: () {},
              child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 3.0, vertical: 5.0),
                height: size.height * 0.32,
                width: double.infinity,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: MyStyles.themeMode().itemTileColor,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.network(
                        snapshot.data[index]['poster_path'] != null
                            ? '${Urls.imagePath}/${snapshot.data[index]['poster_path']}'
                            : 'https://user-images.githubusercontent.com/24848110/33519396-7e56363c-d79d-11e7-969b-09782f5ccbab.png',
                        width: double.infinity,
                        height: size.height * 0.270,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        height: 45,
                        width: 45,
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.white,
                        ),
                        child: 
                        viewModel.getFavoriteList != null
                            ? viewModel.getFavoriteList
                                        .contains(snapshot.data[index]['id']) 
                                ? Center(
                                    child: IconButton(
                                      alignment: Alignment.center,
                                      onPressed: () {
                                        viewModel.updateFavoriteList(
                                            index: index,
                                            id: snapshot.data[index]['id']);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            backgroundColor: Colors.redAccent,
                                            content: Text(
                                              'Removed from WishList',
                                              style: GoogleFonts.poppins(
                                                  fontSize: size.height * 0.018,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        );
                                      },
                                      icon: Icon(
                                        Icons.favorite,
                                        size: size.height * 0.030,
                                        color: Colors.redAccent,
                                      ),
                                    ),
                                  )
                                : Center(
                                    child: IconButton(
                                      onPressed: () {
                                        viewModel.updateFavoriteList(
                                            index: index,
                                            id: snapshot.data[index]['id']);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            backgroundColor: Colors.greenAccent,
                                            content: Text(
                                              'Added to WishList',
                                              style: GoogleFonts.poppins(
                                                  fontSize: size.height * 0.018,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        );
                                      },
                                      icon: Icon(
                                        Icons.favorite_border,
                                        size: size.height * 0.030,
                                      ),
                                    ),
                                  )
                            : Center(
                                child: IconButton(
                                  onPressed: () {
                                    viewModel.updateFavoriteList(
                                        index: index,
                                        id: snapshot.data[index]['id']);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor: Colors.greenAccent,
                                        content: Text(
                                          'Added to WishList',
                                          style: GoogleFonts.poppins(
                                              fontSize: size.height * 0.018,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    );
                                  },
                                  icon: Icon(
                                    Icons.favorite_border,
                                    size: size.height * 0.030,
                                  ),
                                ),
                              ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 170.0, left: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Spacer(),
                            Container(
                              padding: const EdgeInsets.only(right: 10),
                              alignment: snapshot.data[index]
                                          ['original_language'] ==
                                      'ar'
                                  ? Alignment.bottomRight
                                  : Alignment.bottomLeft,
                              child: Text(
                                snapshot.data[index]['original_name'],
                                textAlign: TextAlign.left,
                                overflow: TextOverflow.ellipsis,
                                softWrap: false,
                                maxLines: 2,
                                style: GoogleFonts.poppins(
                                  color: MyStyles.themeData().primaryColor,
                                  fontSize: size.height * 0.020,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: size.height * 0.008,
                            ),
                            snapshot.data[index]['overview'] == ''
                                ? Flexible(
                                    child: Container(
                                      padding: const EdgeInsets.only(right: 10),
                                      alignment: snapshot.data[index]
                                                  ['original_language'] ==
                                              'ar'
                                          ? Alignment.topRight
                                          : Alignment.topLeft,
                                      child: Text(
                                        snapshot.data[index]
                                                    ['original_language'] ==
                                                'ar'
                                            ? 'لا يوجد وصف متاح'
                                            : 'No description available',
                                        textAlign: TextAlign.right,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: GoogleFonts.poppins(
                                          color: MyStyles.themeMode().textColor,
                                          fontSize: size.height * 0.016,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  )
                                : Flexible(
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 0.0),
                                      child: Text(
                                        snapshot.data[index]['overview'],
                                        textAlign: TextAlign.left,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: GoogleFonts.poppins(
                                          color: MyStyles.themeMode().textColor,
                                          fontSize: size.height * 0.016,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            staggeredTileBuilder: (int index) =>
                StaggeredTile.count(2, index.isOdd ? 3.5 : 3.5),
            mainAxisSpacing: 4.0,
            crossAxisSpacing: 4.0,
          ),
        );
      });
}
