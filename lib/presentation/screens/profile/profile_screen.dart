import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_vie/core/utils/methods.dart';
import 'package:la_vie/presentation/controller/profile/cubit.dart';
import 'package:la_vie/presentation/controller/profile/states.dart';
import 'package:la_vie/presentation/resources/assets_manager.dart';
import 'package:la_vie/presentation/resources/color_manager.dart';
import 'package:la_vie/presentation/resources/font_manager.dart';
import 'package:la_vie/presentation/resources/strings_manager.dart';
import 'package:la_vie/presentation/resources/styles_manager.dart';
import 'package:la_vie/presentation/resources/values_manager.dart';
import 'package:shimmer/shimmer.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ProfileCubit, ProfileStates>(
        builder: (context, state) {
          ProfileCubit cubit = ProfileCubit.get(context);
          return state is ProfileLoadingState ? const Center(child: CircularProgressIndicator())
          : Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(ImageAssets.image2),
                fit: BoxFit.fill,
              ),
            ),
            child: Container(
              color: ColorManager.black.withOpacity(0.3),
              child: ListView(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
                    constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height * 0.10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                          padding: EdgeInsets.zero,
                          icon: Icon(Icons.arrow_back, color: ColorManager.white),
                        ),
                        IconButton(
                          onPressed: () {
                            Methods.showAskDialog(context, StringManager.logout, StringManager.logoutMsg, isYesOrNo: true).then((value) {
                              if(value) {
                                cubit.logout(context);
                              }
                            });
                          },
                          visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                          padding: EdgeInsets.zero,
                          icon: Icon(Icons.keyboard_control, color: ColorManager.white),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height * 0.25,
                    ),
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          clipBehavior: Clip.antiAlias,
                          width: AppSize.s100,
                          height: AppSize.s100,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: CachedNetworkImage(
                            imageUrl: cubit.userModel.imageUrl,
                            placeholder: (context, url) => Shimmer.fromColors(
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade100,
                              child: Container(
                                width: AppSize.s100,
                                height: AppSize.s100,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                            errorWidget: (context, url, error) => const CircleAvatar(radius: AppSize.s50),
                            imageBuilder: (context, imageProvider) => Container(
                              width: AppSize.s100,
                              height: AppSize.s100,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(image: imageProvider, fit: BoxFit.fill),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: AppSize.s10),
                        Text('${cubit.userModel.firstName} ${cubit.userModel.lastName}', style: getBoldStyle(color: ColorManager.white, fontSize: FontSize.s24)),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: AppPadding.p30, right: AppPadding.p30),
                    constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height * 0.65 - MediaQuery.of(context).padding.top,
                    ),
                    decoration: BoxDecoration(
                      color: ColorManager.white,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(AppSize.s30),
                        topRight: Radius.circular(AppSize.s30),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: AppPadding.p30, bottom: AppPadding.p10),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(AppSize.s10),
                              decoration: BoxDecoration(
                                color: ColorManager.pointColor,
                                borderRadius: BorderRadius.circular(AppSize.s10),
                              ),
                              child: Row(
                                children: [
                                  Image.asset(ImageAssets.point),
                                  const SizedBox(width: AppSize.s10),
                                  Text('You have 0 points', style: getBoldStyle(color: ColorManager.black, fontSize: FontSize.s16)),
                                ],
                              ),
                            ),
                            const SizedBox(height: AppSize.s20),
                            Text(StringManager.editProfile, style: getBoldStyle(color: ColorManager.black, fontSize: FontSize.s18)),
                            const SizedBox(height: AppSize.s20),
                            InkWell(
                              onTap: () => cubit.showUpdateNameDialog(context: context),
                              child: Container(
                                padding: const EdgeInsets.all(AppSize.s16),
                                decoration: BoxDecoration(
                                  border: Border.all(color: ColorManager.black.withOpacity(0.2)),
                                  borderRadius: BorderRadius.circular(AppSize.s10),
                                  color: ColorManager.white,
                                  boxShadow: [BoxShadow(color: ColorManager.black.withOpacity(0.1), spreadRadius: AppSize.s1, blurRadius: AppSize.s5)],
                                ),
                                child: Row(
                                  children: [
                                    Image.asset(ImageAssets.change),
                                    const SizedBox(width: AppSize.s10),
                                    Text(StringManager.changeName, style: getBoldStyle(color: ColorManager.black, fontSize: FontSize.s16)),
                                    const Spacer(),
                                    const Icon(Icons.arrow_forward),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: AppSize.s20),
                            InkWell(
                              onTap: () => cubit.showUpdateEmailDialog(context: context),
                              child: Container(
                                padding: const EdgeInsets.all(AppSize.s16),
                                decoration: BoxDecoration(
                                  border: Border.all(color: ColorManager.black.withOpacity(0.2)),
                                  borderRadius: BorderRadius.circular(AppSize.s10),
                                  color: ColorManager.white,
                                  boxShadow: [BoxShadow(color: ColorManager.black.withOpacity(0.1), spreadRadius: AppSize.s1, blurRadius: AppSize.s5)],
                                ),
                                child: Row(
                                  children: [
                                    Image.asset(ImageAssets.change),
                                    const SizedBox(width: AppSize.s10),
                                    Text(StringManager.changeEmail, style: getBoldStyle(color: ColorManager.black, fontSize: FontSize.s16)),
                                    const Spacer(),
                                    const Icon(Icons.arrow_forward),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}