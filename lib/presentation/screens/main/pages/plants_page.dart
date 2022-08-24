import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_vie/presentation/controller/main/plants/cubit.dart';
import 'package:la_vie/presentation/controller/main/plants/states.dart';
import 'package:la_vie/presentation/resources/color_manager.dart';
import 'package:la_vie/presentation/resources/font_manager.dart';
import 'package:la_vie/presentation/resources/strings_manager.dart';
import 'package:la_vie/presentation/resources/styles_manager.dart';
import 'package:la_vie/presentation/resources/values_manager.dart';
import 'package:la_vie/presentation/screens/main/widgets/product_item.dart';

class PlantsPage extends StatelessWidget {
  const PlantsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlantsCubit, PlantsStates>(
      builder: (context, state) {
        PlantsCubit cubit = PlantsCubit.get(context);
        return state is GetPlantsLoadingState
          ? const Padding(
            padding: EdgeInsets.only(top: AppPadding.p200),
            child: Center(child: CircularProgressIndicator()),
          )
          : cubit.plants.isEmpty
        ? Padding(
          padding: const EdgeInsets.only(top: AppPadding.p200),
          child: Center(child: Text(StringManager.notFoundData, style: getBoldStyle(color: ColorManager.black, fontSize: FontSize.s20))),
        )
        : GridView.builder(
          padding: const EdgeInsets.only(bottom: AppPadding.p10),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: cubit.plants.length,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: AppSize.s220,
            mainAxisExtent: AppSize.s300,
          ),
          itemBuilder: (context, index) => ProductItem(item: cubit.plants[index]),
        );
      }
    );
  }
}