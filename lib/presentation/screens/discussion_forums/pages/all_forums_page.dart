import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_vie/presentation/controller/discussion_forums/cubit.dart';
import 'package:la_vie/presentation/controller/discussion_forums/states.dart';
import 'package:la_vie/presentation/resources/color_manager.dart';
import 'package:la_vie/presentation/resources/font_manager.dart';
import 'package:la_vie/presentation/resources/strings_manager.dart';
import 'package:la_vie/presentation/resources/styles_manager.dart';
import 'package:la_vie/presentation/resources/values_manager.dart';
import 'package:la_vie/presentation/screens/discussion_forums/widgets/discussion_forums_item.dart';

class AllForumsPage extends StatelessWidget {
  const AllForumsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DiscussionForumsCubit, DiscussionForumsStates>(
        builder: (context, state) {
          DiscussionForumsCubit cubit = DiscussionForumsCubit.get(context);
          return state is GetDiscussionForumsLoadingState
              ? const Padding(
            padding: EdgeInsets.only(top: AppPadding.p200),
            child: Center(child: CircularProgressIndicator()),
          )
              : cubit.discussionForums.isEmpty
              ? Padding(
            padding: const EdgeInsets.only(top: AppPadding.p200),
            child: Center(child: Text(StringManager.notFoundData, style: getBoldStyle(color: ColorManager.black, fontSize: FontSize.s20))),
          )
          : Expanded(
            child: ListView.separated(
              itemCount: cubit.discussionForums.length,
              itemBuilder: (context, index) => DiscussionForumsItem(discussionForum: cubit.discussionForums[index]),
              separatorBuilder: (context, index) => const SizedBox(height: AppSize.s20),
            ),
          );
        }
    );
  }
}