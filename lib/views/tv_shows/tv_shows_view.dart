import 'package:flutter/material.dart';
import 'package:movies_app/views/tv_shows/components/shows_gridview.dart';
import 'package:movies_app/widgets/dumb_widgets/appbar.dart';
import 'package:stacked/stacked.dart';
import 'tv_shows_view_model.dart';

class TvShowsView extends StatelessWidget {
  const TvShowsView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return ViewModelBuilder<TvShowsViewModel>.reactive(
      builder: (BuildContext context, TvShowsViewModel viewModel, Widget _) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(70),
            child: AppBarWidget(
              title: 'Popular TV Shows',
              bottomChild: Container(),
            ),
          ),
          body: popularShowsGridView(
            size: size,
            viewModel: viewModel,
          ),
        );
      },
      viewModelBuilder: () => TvShowsViewModel(),
    );
  }
}


