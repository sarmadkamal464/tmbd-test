import 'package:flutter/material.dart';
import 'package:movies_app/views/search_shows/components/search_gridview.dart';
import 'package:stacked/stacked.dart';
import '../../widgets/dumb_widgets/appbar.dart';
import '../../widgets/smart_widgets/appbar_bottomsheet.dart';
import 'search_shows_view_model.dart';
          
class SearchShowsView extends StatelessWidget {
  const SearchShowsView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     var size = MediaQuery.of(context).size;
    return ViewModelBuilder<SearchShowsViewModel>.reactive(
      builder: (BuildContext context, SearchShowsViewModel viewModel, Widget _) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(130),
            child: AppBarWidget(
              title: 'Popular TV Shows',
              bottomChild: appbarBottomSheet(size, viewModel, context),
            ),
          ),
          body: searchShowsGridView(
            size: size,
            viewModel: viewModel,
          ),
        );
      },
      viewModelBuilder: () => SearchShowsViewModel(),
    );
  }
}
