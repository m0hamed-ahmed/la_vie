import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_vie/core/network/api_constance.dart';
import 'package:la_vie/presentation/controller/cart/cubit.dart';
import 'package:la_vie/presentation/controller/cart/states.dart';
import 'package:la_vie/presentation/resources/assets_manager.dart';
import 'package:la_vie/presentation/resources/color_manager.dart';
import 'package:la_vie/presentation/resources/font_manager.dart';
import 'package:la_vie/presentation/resources/strings_manager.dart';
import 'package:la_vie/presentation/resources/styles_manager.dart';
import 'package:la_vie/presentation/resources/values_manager.dart';
import 'package:la_vie/presentation/widgets/custom_button.dart';
import 'package:shimmer/shimmer.dart';

class ProductItem extends StatelessWidget {
  final dynamic item;

  const ProductItem({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartStates>(
        builder: (context, state) {
        CartCubit cubit = CartCubit.get(context);
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p5),
          child: SizedBox(
            width: AppSize.s220,
            height: AppSize.s300,
            child: Stack(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: AppMargin.m50),
                  decoration: BoxDecoration(
                    color: ColorManager.white,
                    borderRadius: BorderRadius.circular(AppSize.s10),
                    boxShadow: [BoxShadow(color: ColorManager.black.withOpacity(0.1), spreadRadius: AppSize.s2, blurRadius: AppSize.s5)],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(AppPadding.p10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: AppSize.s80,
                            height: AppSize.s150,
                            child: CachedNetworkImage(
                              imageUrl: ApiConstance.baseUrl + item.imageUrl,
                              placeholder: (context, url) => Shimmer.fromColors(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                child: Container(
                                  width: AppSize.s80,
                                  height: AppSize.s150,
                                  color: Colors.grey,
                                ),
                              ),
                              errorWidget: (context, url, error) => Image.asset(ImageAssets.image, width: AppSize.s80, height: AppSize.s150),
                              imageBuilder: (context, imageProvider) => Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(image: imageProvider, fit: BoxFit.fill),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: AppSize.s10),
                          const Spacer(),
                          Row(
                            children: [
                              SizedBox(
                                width: AppSize.s20,
                                height: AppSize.s20,
                                child: CustomButton(
                                  onPressed: () => cubit.inCart(item) ? cubit.decrementQuantity(item) : null,
                                  icon: Icons.remove,
                                  buttonColor: ColorManager.grey6,
                                  iconColor: ColorManager.grey1,
                                  radius: AppSize.s0,
                                  elevation: AppSize.s0,
                                ),
                              ),
                              SizedBox(
                                width: AppSize.s30,
                                height: AppSize.s18,
                                child: Center(
                                  child: Text(cubit.getQuantity(item).toString(), style: getBoldStyle(color: ColorManager.black, fontSize: FontSize.s16)),
                                ),
                              ),
                              SizedBox(
                                width: AppSize.s20,
                                height: AppSize.s20,
                                child: CustomButton(
                                  onPressed: () => cubit.inCart(item) ? cubit.incrementQuantity(item) : null,
                                  icon: Icons.add,
                                  buttonColor: ColorManager.grey6,
                                  iconColor: ColorManager.grey1,
                                  radius: AppSize.s0,
                                  elevation: AppSize.s0,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSize.s20),
                      Text(item.name, maxLines: 2, overflow: TextOverflow.ellipsis, style: getMediumStyle(color: ColorManager.black, fontSize: FontSize.s16)),
                      const SizedBox(height: AppSize.s5),
                      Text('${cubit.getQuantity(item)*70} EGP', style: getMediumStyle(color: ColorManager.black, fontSize: FontSize.s12)),
                      const SizedBox(height: AppSize.s10),
                      const Spacer(),
                      CustomButton(
                        onPressed: () => cubit.inCart(item) ? cubit.removeFromCart(item) : cubit.addToCart(item, cubit.getQuantity(item)),
                        text: cubit.inCart(item) ? StringManager.removeFromCart : StringManager.addToCart,
                        buttonColor: cubit.inCart(item) ? ColorManager.red700 : ColorManager.primary,
                        radius: AppSize.s10,
                        height: AppSize.s35,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}