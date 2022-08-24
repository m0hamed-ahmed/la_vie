import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_vie/presentation/controller/main/seeds/cubit.dart';
import 'package:la_vie/presentation/controller/main/seeds/states.dart';
import 'package:la_vie/presentation/resources/color_manager.dart';
import 'package:la_vie/presentation/resources/font_manager.dart';
import 'package:la_vie/presentation/resources/strings_manager.dart';
import 'package:la_vie/presentation/resources/styles_manager.dart';
import 'package:la_vie/presentation/resources/values_manager.dart';
import 'package:la_vie/presentation/screens/main/widgets/product_item.dart';

class SeedsPage extends StatelessWidget {
  const SeedsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SeedsCubit, SeedsStates>(
        builder: (context, state) {
          SeedsCubit cubit = SeedsCubit.get(context);
          return state is GetSeedsLoadingState
              ? const Padding(
            padding: EdgeInsets.only(top: AppPadding.p200),
            child: Center(child: CircularProgressIndicator()),
          )
              : cubit.seeds.isEmpty
              ? Padding(
            padding: const EdgeInsets.only(top: AppPadding.p200),
            child: Center(child: Text(StringManager.notFoundData, style: getBoldStyle(color: ColorManager.black, fontSize: FontSize.s20))),
          )
              : GridView.builder(
            padding: const EdgeInsets.only(bottom: AppPadding.p10),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: cubit.seeds.length,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: AppSize.s220,
              mainAxisExtent: AppSize.s300,
            ),
            itemBuilder: (context, index) => ProductItem(item: cubit.seeds[index]),
          );
        }
    );
  }
}