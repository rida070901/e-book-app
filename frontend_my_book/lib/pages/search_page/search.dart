import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_book/pages/search_page/search_controller.dart';
import 'package:my_book/pages/search_page/search_widgets.dart';

import '../../common/widgets/base_text_widget.dart';
import 'bloc/search_blocs.dart';
import 'bloc/search_states.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {

  late MySearchController _searchController;

  @override
  void didChangeDependencies() {
    _searchController = MySearchController(context: context);
    _searchController.init();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(builder: (context, state) {
      return Scaffold(
        appBar: buildAppBar("Search"),
        body: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 20.h),
              sliver: SliverToBoxAdapter(
                child: searchView(context, "books you might like", home: false),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 0),
              sliver: SliverToBoxAdapter(
                child: SingleChildScrollView(

                  child: searchList(state),
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}
