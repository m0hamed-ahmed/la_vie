import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_vie/presentation/controller/blogs/cubit.dart';
import 'package:la_vie/presentation/controller/blogs/states.dart';
import 'package:la_vie/presentation/resources/color_manager.dart';
import 'package:la_vie/presentation/resources/font_manager.dart';
import 'package:la_vie/presentation/resources/strings_manager.dart';
import 'package:la_vie/presentation/resources/styles_manager.dart';
import 'package:la_vie/presentation/resources/values_manager.dart';
import 'package:la_vie/presentation/screens/blogs/widgets/blog_item.dart';

class BlogsScreen extends StatelessWidget {
  const BlogsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BlogsCubit, BlogsStates>(
      builder: (context, state) {
        BlogsCubit cubit = BlogsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text(StringManager.blogs),
          ),
          body: state is GetBlogsLoadingState
              ? const Padding(
            padding: EdgeInsets.only(top: AppPadding.p200),
            child: Center(child: CircularProgressIndicator()),
          )
              : cubit.blog.plants.isEmpty
              ? Padding(
            padding: const EdgeInsets.only(top: AppPadding.p200),
            child: Center(child: Text(StringManager.notFoundData, style: getBoldStyle(color: ColorManager.black, fontSize: FontSize.s20))),
          ) : ListView.separated(
            padding: const EdgeInsets.all(AppPadding.p16),
            itemCount: cubit.blog.plants.length,
            itemBuilder: (context, index) => BlogItem(item: cubit.blog.plants[index]),
            separatorBuilder: (context, index) => const SizedBox(height: AppSize.s20),
          ),
        );
      }
    );
  }
}