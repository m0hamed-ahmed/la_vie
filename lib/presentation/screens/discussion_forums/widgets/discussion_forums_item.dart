import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:la_vie/core/network/api_constance.dart';
import 'package:la_vie/domain/entities/discussion_forum.dart';
import 'package:la_vie/presentation/resources/assets_manager.dart';
import 'package:la_vie/presentation/resources/color_manager.dart';
import 'package:la_vie/presentation/resources/font_manager.dart';
import 'package:la_vie/presentation/resources/strings_manager.dart';
import 'package:la_vie/presentation/resources/styles_manager.dart';
import 'package:la_vie/presentation/resources/values_manager.dart';
import 'package:shimmer/shimmer.dart';

class DiscussionForumsItem extends StatelessWidget {
  final DiscussionForum discussionForum;

  const DiscussionForumsItem({Key? key, required this.discussionForum}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(AppPadding.p16),
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(color: ColorManager.grey7),
              left: BorderSide(color: ColorManager.grey7),
              right: BorderSide(color: ColorManager.grey7),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    clipBehavior: Clip.antiAlias,
                    width: AppSize.s50,
                    height: AppSize.s50,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: CachedNetworkImage(
                      imageUrl: discussionForum.forumUser.imageUrl,
                      placeholder: (context, url) => Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        child: Container(
                          width: AppSize.s50,
                          height: AppSize.s50,
                          decoration: const BoxDecoration(
                            color: Colors.grey,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        clipBehavior: Clip.antiAlias,
                        width: AppSize.s50,
                        height: AppSize.s50,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Image.asset(ImageAssets.image3, width: AppSize.s50, height: AppSize.s50)
                      ),
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(image: imageProvider, fit: BoxFit.fill),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSize.s10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${discussionForum.forumUser.firstName} ${discussionForum.forumUser.lastName}', style: getBoldStyle(color: ColorManager.black)),
                      Text('a month ago', style: getRegularStyle(color: ColorManager.grey4, fontSize: FontSize.s12))
                    ],
                  )
                ],
              ),
              const SizedBox(height: AppSize.s10),
              Text(discussionForum.title, style: getBoldStyle(color: ColorManager.primary, fontSize: FontSize.s16)),
              const SizedBox(height: AppSize.s10),
              Text(discussionForum.description, style: getRegularStyle(color: ColorManager.grey10)),
            ],
          ),
        ),
        SizedBox(
          width: double.infinity,
          height: AppSize.s300,
          child: discussionForum.imageUrl == null
            ? Image.asset(ImageAssets.image4, width: double.infinity, height: AppSize.s300, fit: BoxFit.fill)
            : CachedNetworkImage(
            imageUrl: ApiConstance.baseUrl + discussionForum.imageUrl!,
            placeholder: (context, url) => Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: Container(
                width: double.infinity,
                height: AppSize.s300,
                color: Colors.grey,
              ),
            ),
            errorWidget: (context, url, error) => Image.asset(ImageAssets.image4, width: double.infinity, height: AppSize.s300),
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                image: DecorationImage(image: imageProvider, fit: BoxFit.fill),
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSize.s10),
        Row(
          children: [
            Row(
              children: [
                Icon(Icons.favorite_border, color: ColorManager.grey1, size: 18),
                const SizedBox(width: AppSize.s3),
                Text('${discussionForum.forumLikes.length} ${StringManager.likes}', style: getBoldStyle(color: ColorManager.grey1))
              ],
            ),
            const SizedBox(width: AppSize.s20),
            Row(
              children: [
                Icon(Icons.comment, color: ColorManager.grey1, size: AppSize.s18),
                const SizedBox(width: AppSize.s3),
                Text('${discussionForum.forumComments.length} ${StringManager.replies}', style: getBoldStyle(color: ColorManager.grey1))
              ],
            ),
          ],
        ),
      ],
    );
  }
}