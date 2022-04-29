import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies_app/core/utils/urls.dart';
import 'package:stacked/stacked.dart';
import '../../theme/styles.dart';
import '../../widgets/dumb_widgets/appbar.dart';
import 'favorite_tv_shows_view_model.dart';

class FavoriteTvShowsView extends StatelessWidget {
  const FavoriteTvShowsView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return ViewModelBuilder<FavoriteTvShowsViewModel>.reactive(
      builder:
          (BuildContext context, FavoriteTvShowsViewModel viewModel, Widget _) {
        return viewModel.isBusy
            ? Center(
                child: CircularProgressIndicator(
                  color: MyStyles.themeData().primaryColor,
                ),
              )
            : Scaffold(
                appBar: PreferredSize(
                  preferredSize: const Size.fromHeight(60),
                  child: AppBarWidget(
                    title: 'Favorite TV Shows',
                    bottomChild: Container(),
                  ),
                ),
                body: viewModel.filteredResult.isEmpty
                    ? Center(
                        child: Text(
                          'No Favorite Shows Added',
                          style: GoogleFonts.poppins(
                            color: MyStyles.themeMode().cardColor,
                            fontSize: size.height * 0.024,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(bottom: 50),
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          itemCount: viewModel.filteredResult.length,
                          itemBuilder: (context, index) {
                            return wishlistContainer(
                              size: size,
                              viewModel: viewModel,
                              productImage: viewModel.filteredResult[index]
                                          ['poster_path'] !=
                                      null
                                  ? '${Urls.imagePath}/${viewModel.filteredResult[index]['poster_path']}'
                                  : 'https://user-images.githubusercontent.com/24848110/33519396-7e56363c-d79d-11e7-969b-09782f5ccbab.png',
                              productId: viewModel.filteredResult[index]['id'],
                              productName: viewModel.filteredResult[index]
                                  ['original_name'],
                              showDescription: viewModel.filteredResult[index]
                                          ['overview'] ==
                                      ''
                                  ? 'No Description available'
                                  : viewModel.filteredResult[index]['overview'],
                              context: context,
                              index: index,
                            );
                          },
                        ),
                      ),
              );
      },
      viewModelBuilder: () => FavoriteTvShowsViewModel(),
    );
  }

  Widget wishlistContainer({
    Size size,
    FavoriteTvShowsViewModel viewModel,
    String productName,
    String productImage,
    int productId,
    String showDescription,
    int index,
    BuildContext context,
    AsyncSnapshot<dynamic> snapshot,
  }) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: size.height * 0.160,
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        padding: const EdgeInsets.only(left: 10, right: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: MyStyles.themeData().backgroundColor,
            border: Border.all(
                color: MyStyles.themeData().primaryColor, width: 0.5)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: SizedBox(
                height: size.height * 0.100,
                width: size.width * 0.160,
                child: Image.network(productImage, fit: BoxFit.cover),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: SizedBox(
                        width: size.width * 0.450,
                        child: Text(
                          productName,
                          maxLines: 1,
                          softWrap: false,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.nunito(
                            fontSize: size.height * 0.022,
                            fontWeight: FontWeight.w600,
                            color: MyStyles.themeMode().textColor,
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      child: SizedBox(
                        width: size.width * 0.6,
                        child: Text(
                          showDescription,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: GoogleFonts.nunito(
                            fontSize: size.height * 0.020,
                            fontWeight: FontWeight.w600,
                            color: MyStyles.themeData().primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
