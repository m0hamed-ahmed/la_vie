import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:la_vie/core/network/api_constance.dart';
import 'package:la_vie/presentation/resources/assets_manager.dart';
import 'package:la_vie/presentation/resources/color_manager.dart';
import 'package:la_vie/presentation/resources/font_manager.dart';
import 'package:la_vie/presentation/resources/routes_manager.dart';
import 'package:la_vie/presentation/resources/styles_manager.dart';
import 'package:la_vie/presentation/resources/values_manager.dart';
import 'package:shimmer/shimmer.dart';

class BlogItem extends StatelessWidget {
  final dynamic item;

  const BlogItem({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, Routes.blogDetailsRoute, arguments: {'item': item}),
      child: Container(
        padding: const EdgeInsets.all(AppPadding.p10),
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(AppSize.s10),
          boxShadow: [BoxShadow(color: ColorManager.black.withOpacity(0.07), spreadRadius: AppSize.s1, blurRadius: AppSize.s10)],
        ),
        child: Row(
          children: [
            Container(
              clipBehavior: Clip.antiAlias,
              width: AppSize.s100,
              height: AppSize.s100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSize.s10),
              ),
              child: CachedNetworkImage(
                imageUrl: ApiConstance.baseUrl + item.imageUrl,
                placeholder: (context, url) => Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Container(
                    width: AppSize.s100,
                    height: AppSize.s100,
                    color: Colors.grey,
                  ),
                ),
                errorWidget: (context, url, error) => Image.asset(ImageAssets.defaultBlogImage, width: AppSize.s100, height: AppSize.s100, fit: BoxFit.fill),
                imageBuilder: (context, imageProvider) => Container(
                  width: AppSize.s100,
                  height: AppSize.s100,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: imageProvider, fit: BoxFit.fill),
                  ),
                ),
              ),
            ),
            const SizedBox(width: AppSize.s10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('2 days ago', style: getRegularStyle(color: ColorManager.primary)),
                  const SizedBox(height: AppSize.s10),
                  Text(item.name, overflow: TextOverflow.ellipsis, maxLines: 1, style: getBoldStyle(color: ColorManager.black, fontSize: FontSize.s18)),
                  const SizedBox(height: AppSize.s5),
                  Text(item.description, overflow: TextOverflow.ellipsis, maxLines: 2, style: getRegularStyle(color: ColorManager.grey1)),
                ],
              )
            ),
          ],
        ),
      ),
    );
  }
}