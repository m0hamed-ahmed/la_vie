import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_vie/core/network/api_constance.dart';
import 'package:la_vie/domain/entities/cart.dart';
import 'package:la_vie/presentation/controller/cart/cubit.dart';
import 'package:la_vie/presentation/controller/cart/states.dart';
import 'package:la_vie/presentation/resources/assets_manager.dart';
import 'package:la_vie/presentation/resources/color_manager.dart';
import 'package:la_vie/presentation/resources/font_manager.dart';
import 'package:la_vie/presentation/resources/styles_manager.dart';
import 'package:la_vie/presentation/resources/values_manager.dart';
import 'package:shimmer/shimmer.dart';

class CartItem extends StatelessWidget {
  final Cart cart;

  const CartItem({Key? key, required this.cart}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartStates>(
      builder: (context, state) {
        CartCubit cubit = CartCubit.get(context);
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSize.s15),
          ),
          elevation: AppSize.s5,
          shadowColor: ColorManager.black.withOpacity(0.4),
          child: Padding(
            padding: const EdgeInsets.all(AppPadding.p10),
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
                    imageUrl: ApiConstance.baseUrl + cart.item.imageUrl,
                    placeholder: (context, url) => Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        width: AppSize.s100,
                        height: AppSize.s100,
                        color: Colors.grey,
                      ),
                    ),
                    errorWidget: (context, url, error) => Image.asset(ImageAssets.image, width: AppSize.s100, height: AppSize.s100),
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(image: imageProvider, fit: BoxFit.fill),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: AppSize.s20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(cart.item.name, style: getBoldStyle(color: ColorManager.black, fontSize: FontSize.s18)),
                      const SizedBox(height: AppSize.s10),
                      Text('${cubit.getQuantity(cart.item) * 70} EGP', style: getBoldStyle(color: ColorManager.primary, fontSize: FontSize.s16)),
                      const SizedBox(height: AppSize.s20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: AppPadding.p5),
                            decoration: BoxDecoration(
                              color: ColorManager.grey5,
                              borderRadius: BorderRadius.circular(AppSize.s10),
                            ),
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () => cubit.decrementQuantity(cart.item),
                                  visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                                  padding: EdgeInsets.zero,
                                  icon: Icon(Icons.remove, color: ColorManager.primary, size: AppSize.s16),
                                ),
                                const SizedBox(width: AppSize.s3),
                                Text(cubit.getQuantity(cart.item).toString(), style: getBoldStyle(color: ColorManager.black)),
                                const SizedBox(width: AppSize.s3),
                                IconButton(
                                  onPressed: () => cubit.incrementQuantity(cart.item),
                                  visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                                  padding: EdgeInsets.zero,
                                  icon: Icon(Icons.add, color: ColorManager.primary, size: AppSize.s16),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () => cubit.removeFromCart(cart.item),
                            icon: Icon(Icons.delete, color: ColorManager.primary),
                          )
                        ],
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