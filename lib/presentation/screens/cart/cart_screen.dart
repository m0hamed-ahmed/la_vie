import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_vie/presentation/controller/cart/cubit.dart';
import 'package:la_vie/presentation/controller/cart/states.dart';
import 'package:la_vie/presentation/resources/color_manager.dart';
import 'package:la_vie/presentation/resources/font_manager.dart';
import 'package:la_vie/presentation/resources/strings_manager.dart';
import 'package:la_vie/presentation/resources/styles_manager.dart';
import 'package:la_vie/presentation/resources/values_manager.dart';
import 'package:la_vie/presentation/screens/cart/widgets/cart_empty.dart';
import 'package:la_vie/presentation/screens/cart/widgets/cart_item.dart';
import 'package:la_vie/presentation/widgets/custom_button.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(StringManager.myCart),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: BlocBuilder<CartCubit, CartStates>(
        builder: (context, state) {
          CartCubit cubit = CartCubit.get(context);
          return Padding(
            padding: const EdgeInsets.all(AppPadding.p20),
            child: cubit.cart.isEmpty ? const CartEmpty() : Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    itemCount: cubit.cart.length,
                    itemBuilder: (context, index) => CartItem(cart: cubit.cart[index]),
                    separatorBuilder: (context, index) => const SizedBox(height: AppSize.s10),
                  ),
                ),
                const SizedBox(height: AppSize.s20),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(StringManager.total, style: getBoldStyle(color: ColorManager.black, fontSize: FontSize.s20)),
                        Row(
                          children: [
                            Text(cubit.getTotalPrice().toString(), style: getBoldStyle(color: ColorManager.primary, fontSize: FontSize.s16)),
                            const SizedBox(width: AppSize.s3),
                            Text(StringManager.egp, style: getBoldStyle(color: ColorManager.primary, fontSize: FontSize.s20)),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSize.s20),
                    CustomButton(onPressed: () {}, text: StringManager.checkout, height: AppSize.s50, radius: AppSize.s10),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}