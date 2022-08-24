import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_vie/presentation/controller/discussion_forums/cubit.dart';
import 'package:la_vie/presentation/controller/discussion_forums/states.dart';
import 'package:la_vie/presentation/resources/color_manager.dart';
import 'package:la_vie/presentation/resources/enum.dart';
import 'package:la_vie/presentation/resources/routes_manager.dart';
import 'package:la_vie/presentation/resources/strings_manager.dart';
import 'package:la_vie/presentation/resources/values_manager.dart';
import 'package:la_vie/presentation/screens/discussion_forums/pages/all_forums_page.dart';
import 'package:la_vie/presentation/screens/discussion_forums/pages/my_forums_page.dart';
import 'package:la_vie/presentation/screens/discussion_forums/widgets/forum_item.dart';
import 'package:la_vie/presentation/widgets/custom_text_form_field.dart';

class DiscussionForumsScreen extends StatefulWidget {
  const DiscussionForumsScreen({Key? key}) : super(key: key);

  @override
  State<DiscussionForumsScreen> createState() => _DiscussionForumsScreenState();
}

class _DiscussionForumsScreenState extends State<DiscussionForumsScreen> {
  TextEditingController textEditingControllerSearch = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DiscussionForumsCubit, DiscussionForumsStates>(
      builder: (context, state) {
        DiscussionForumsCubit cubit = DiscussionForumsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text(StringManager.discussionForums),
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_ios_rounded),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(AppPadding.p16),
            child: Column(
              children: [
                CustomTextFormField(
                  controller: textEditingControllerSearch,
                  prefixIcon: Icons.search,
                  prefixIconColor: ColorManager.grey9,
                  hint: StringManager.search,
                  fillColor: ColorManager.grey8,
                  borderColor: ColorManager.grey8,
                  borderRadius: AppSize.s10,
                ),
                const SizedBox(height: AppSize.s10),
                Row(
                  children: [
                    ForumItem(text: StringManager.allForums, onPressed: () => cubit.changeForumsItem(Forums.allForums), isSelected: cubit.forum == Forums.allForums),
                    const SizedBox(width: AppSize.s10),
                    ForumItem(text: StringManager.myForums, onPressed: () => cubit.changeForumsItem(Forums.myForums), isSelected: cubit.forum == Forums.myForums),
                  ],
                ),
                const SizedBox(height: AppSize.s10),
                getPage(cubit.forum),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => Navigator.pushNamed(context, Routes.createPostRoute),
            child: Icon(Icons.add, color: ColorManager.white),
          ),
        );
      }
    );
  }

  Widget getPage(Forums forum) {
    switch(forum) {
      case Forums.allForums: return const AllForumsPage();
      case Forums.myForums: return const MyForumsPage();
    }
  }

  @override
  void dispose() {
    textEditingControllerSearch.dispose();
    super.dispose();
  }
}