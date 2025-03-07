import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_book/common/routes/route_names.dart';
import 'package:my_book/pages/home_page/home_page_controller.dart';
import 'package:my_book/pages/home_page/home_page_widgets.dart';
import '../../common/entities/user.dart';
import '../../common/values/colors.dart';
import '../../common/widgets/base_text_widget.dart';
import 'bloc/home_page_blocs.dart';
import 'bloc/home_page_states.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeController _homeController;
  late UserItem userProfile;

  // @override
  // void initState(){
  //   super.initState();
  // }

  @override
  void didChangeDependencies(){
    _homeController = HomeController(context: context);
    _homeController.init();
    userProfile = _homeController.userProfile!;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBarHomePage(userProfile!.avatar.toString()),
      body: RefreshIndicator(
        color: AppColors.warmPink,
        onRefresh: (){
          return HomeController(context: context).init();
        },
        child: BlocBuilder<HomePageBloc, HomePageState>(
          builder: (context, state) {
            //print("----------from homepage ${state.bookListIndex}");
            //print("${state.bookItem[2].name}");
            if(state.bookItem.isEmpty){
              HomeController(context: context).init(); //recall api qe te rimarrim data when restarting app
            }
            return Container(
              margin: EdgeInsets.symmetric(vertical: 0, horizontal: 25.w),
              child: CustomScrollView(
                //crossAxisAlignment: CrossAxisAlignment.start,
                slivers: [
                  SliverToBoxAdapter(child: homePageText("Hello", color: AppColors.strongGrey,)),
                  SliverToBoxAdapter(child: homePageText(userProfile!.name!, top: 5,)),
                  SliverToBoxAdapter(child: searchView(context, "search a book..", home: true)), //searchView(context, "Search book..")),
                  SliverToBoxAdapter(child: slideMenu(context, state)),
                  SliverToBoxAdapter(child: menuView(context, _homeController, state)),
                  SliverPadding(
                    padding: EdgeInsets.symmetric( vertical: 18.h, horizontal: 0.w),
                    sliver: SliverGrid(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 15,
                          crossAxisSpacing: 20,
                          childAspectRatio: 0.9),
                      delegate: SliverChildBuilderDelegate(
                          childCount: state.bookItem.length,
                              (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushNamed(AppRoutes.BOOK_DETAILS,
                                  arguments: {
                                    "id": state.bookItem.elementAt(index).id,
                                  }
                                );
                              },
                               child: //state.bookItem.isEmpty ?
                              // const Center(
                              //   child: CircularProgressIndicator(
                              //     backgroundColor: AppColors.greyBackground,
                              //     color: AppColors.warmPink))
                              // :
                              bookGrid(state.bookItem[index]),
                            );
                          }
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
