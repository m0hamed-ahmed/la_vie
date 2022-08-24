import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:la_vie/core/network/api_constance.dart';
import 'package:la_vie/presentation/resources/assets_manager.dart';
import 'package:la_vie/presentation/resources/color_manager.dart';
import 'package:la_vie/presentation/resources/font_manager.dart';
import 'package:la_vie/presentation/resources/styles_manager.dart';
import 'package:la_vie/presentation/resources/values_manager.dart';
import 'package:shimmer/shimmer.dart';

class BlogDetailsScreen extends StatelessWidget {
  final dynamic item;

  const BlogDetailsScreen({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: AppSize.s0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            height: AppSize.s300,
            child: CachedNetworkImage(
              imageUrl: ApiConstance.baseUrl + item['item'].imageUrl,
              placeholder: (context, url) => Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: Container(
                  width: double.infinity,
                  height: AppSize.s300,
                  color: Colors.grey,
                ),
              ),
              errorWidget: (context, url, error) => Image.asset(ImageAssets.defaultBlogImage, width: double.infinity, height: AppSize.s300, fit: BoxFit.fill),
              imageBuilder: (context, imageProvider) => Container(
                width: double.infinity,
                height: AppSize.s300,
                decoration: BoxDecoration(
                  image: DecorationImage(image: imageProvider, fit: BoxFit.fill),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppPadding.p16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item['item'].name, style: getBoldStyle(color: ColorManager.black, fontSize: FontSize.s22)),
                const SizedBox(height: AppSize.s10),
                Text(item['item'].description, style: getRegularStyle(color: ColorManager.grey1, fontSize: FontSize.s16)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}