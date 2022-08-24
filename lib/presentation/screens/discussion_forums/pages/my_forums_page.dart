import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_vie/core/utils/cache_helper.dart';
import 'package:la_vie/data/models/user_model.dart';
import 'package:la_vie/domain/entities/user.dart';
import 'package:la_vie/presentation/controller/discussion_forums/cubit.dart';
import 'package:la_vie/presentation/controller/discussion_forums/states.dart';
import 'package:la_vie/presentation/resources/color_manager.dart';
import 'package:la_vie/presentation/resources/font_manager.dart';
import 'package:la_vie/presentation/resources/strings_manager.dart';
import 'package:la_vie/presentation/resources/styles_manager.dart';
import 'package:la_vie/presentation/resources/values_manager.dart';
import 'package:la_vie/presentation/screens/discussion_forums/widgets/discussion_forums_item.dart';

class MyForumsPage extends StatelessWidget {
  const MyForumsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User user = UserModel.fromLocalJson(json.decode(CacheHelper.getData(key: PREFERENCES_KEY_USER_DATA)));
    
    return BlocBuilder<DiscussionForumsCubit, DiscussionForumsStates>(
        builder: (context, state) {
          DiscussionForumsCubit cubit = DiscussionForumsCubit.get(context);
          return state is GetDiscussionForumsLoadingState
              ? const Padding(
            padding: EdgeInsets.only(top: AppPadding.p200),
            child: Center(child: CircularProgressIndicator()),
          )
              : cubit.discussionForums.where((element) => element.userId == user.userId).toList().isEmpty
              ? Padding(
            padding: const EdgeInsets.only(top: AppPadding.p200),
            child: Center(child: Text(StringManager.notFoundData, style: getBoldStyle(color: ColorManager.black, fontSize: FontSize.s20))),
          )
              : Expanded(
            child: ListView.separated(
              itemCount: cubit.discussionForums.where((element) => element.userId == user.userId).toList().length,
              itemBuilder: (context, index) => DiscussionForumsItem(discussionForum: cubit.discussionForums.where((element) => element.userId == user.userId).toList()[index]),
              separatorBuilder: (context, index) => const SizedBox(height: AppSize.s20),
            ),
          );
        }
    );
  }
}