import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_vie/core/utils/cache_helper.dart';
import 'package:la_vie/core/utils/methods.dart';
import 'package:la_vie/presentation/controller/main/cubit.dart';
import 'package:la_vie/presentation/controller/main/states.dart';
import 'package:la_vie/presentation/resources/assets_manager.dart';
import 'package:la_vie/presentation/resources/color_manager.dart';
import 'package:la_vie/presentation/resources/enum.dart';
import 'package:la_vie/presentation/resources/routes_manager.dart';
import 'package:la_vie/presentation/resources/strings_manager.dart';
import 'package:la_vie/presentation/resources/values_manager.dart';
import 'package:la_vie/presentation/screens/main/pages/plants_page.dart';
import 'package:la_vie/presentation/screens/main/pages/seeds_page.dart';
import 'package:la_vie/presentation/screens/main/pages/tools_page.dart';
import 'package:la_vie/presentation/screens/main/widgets/bottom_app_bar_item.dart';
import 'package:la_vie/presentation/screens/main/widgets/category_item.dart';
import 'package:la_vie/presentation/widgets/custom_button.dart';
import 'package:la_vie/presentation/widgets/custom_text_form_field.dart';
import 'package:la_vie/presentation/widgets/la_vie_logo.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  TextEditingController textEditingControllerSearch = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainStates>(
      builder: (context, state) {
        MainCubit cubit = MainCubit.get(context);
        return WillPopScope(
          onWillPop: () => Methods.showAskDialog(context, StringManager.areYouSure, StringManager.exitApp, isYesOrNo: true),
          child: Scaffold(
            appBar: AppBar(
              title: const LaVieLogo(),
              actions: [
                // if(DateTime.fromMillisecondsSinceEpoch(CacheHelper.getData(key: PREFERENCES_KEY_EXAM_TIME)).isBefore(DateTime(DateTime.now())))
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
                  child: IconButton(
                    onPressed: () {
                      CacheHelper.setData(key: PREFERENCES_KEY_EXAM_TIME, value: DateTime.now().millisecondsSinceEpoch);
                      Navigator.pushNamed(context, Routes.examRoute);
                    },
                    icon: Icon(Icons.help, color: ColorManager.primary, size: AppSize.s30),
                  ),
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(AppPadding.p16),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextFormField(
                            controller: textEditingControllerSearch,
                            prefixIcon: Icons.search,
                            prefixIconColor: ColorManager.grey4,
                            hint: StringManager.search,
                            fillColor: ColorManager.grey5,
                            borderColor: ColorManager.grey5,
                            borderRadius: AppSize.s10,
                          ),
                        ),
                        const SizedBox(width: AppSize.s20),
                        CustomButton(
                          onPressed: () => Navigator.pushNamed(context, Routes.cartRoute),
                          width: AppSize.s50,
                          radius: AppSize.s10,
                          image: ImageAssets.shoppingCart,
                        )
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: AppMargin.m25),
                      height: AppSize.s40,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          CategoryItem(text: StringManager.plants, onPressed: () => cubit.changeCategoryItem(Categories.plants), isSelected: cubit.category == Categories.plants),
                          CategoryItem(text: StringManager.seeds, onPressed: () => cubit.changeCategoryItem(Categories.seeds), isSelected: cubit.category == Categories.seeds),
                          CategoryItem(text: StringManager.tools, onPressed: () => cubit.changeCategoryItem(Categories.tools), isSelected: cubit.category == Categories.tools),
                        ],
                      ),
                    ),
                    getPage(cubit.category),
                  ],
                ),
              ),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            floatingActionButton: FloatingActionButton(
              onPressed: () {},
              backgroundColor: ColorManager.primary,
              child: Image.asset(ImageAssets.home),
            ),
            bottomNavigationBar: BottomAppBar(
              color: ColorManager.white,
              notchMargin: AppSize.s8,
              shape: const AutomaticNotchedShape(
                RoundedRectangleBorder(),
                StadiumBorder(side: BorderSide()),
              ),
              child: SizedBox(
                child: Padding(
                  padding: const EdgeInsets.all(AppPadding.p8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      BottomAppBarItem(image: ImageAssets.leave, onTap: () => Navigator.pushNamed(context, Routes.discussionForumsRoute)),
                      BottomAppBarItem(image: ImageAssets.qrCodeScan, onTap: () => Navigator.pushNamed(context, Routes.scanDetailsRoute)),
                      const SizedBox(width: AppSize.s40),
                      BottomAppBarItem(image: ImageAssets.bell, onTap: () => Navigator.pushNamed(context, Routes.notificationsRoute)),
                      BottomAppBarItem(image: ImageAssets.user, onTap: () => Navigator.pushNamed(context, Routes.profileRoute)),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget getPage(Categories category) {
    switch(category) {
      case Categories.plants: return const PlantsPage();
      case Categories.seeds: return const SeedsPage();
      case Categories.tools: return const ToolsPage();
    }
  }

  @override
  void dispose() {
    textEditingControllerSearch.dispose();
    super.dispose();
  }
}