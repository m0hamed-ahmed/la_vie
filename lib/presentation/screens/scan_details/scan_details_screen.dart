import 'package:flutter/material.dart';
import 'package:la_vie/presentation/resources/assets_manager.dart';
import 'package:la_vie/presentation/resources/color_manager.dart';
import 'package:la_vie/presentation/resources/font_manager.dart';
import 'package:la_vie/presentation/resources/routes_manager.dart';
import 'package:la_vie/presentation/resources/strings_manager.dart';
import 'package:la_vie/presentation/resources/styles_manager.dart';
import 'package:la_vie/presentation/resources/values_manager.dart';
import 'package:la_vie/presentation/widgets/custom_button.dart';

class ScanDetailsScreen extends StatelessWidget {
  final double bottomNavigationBarHeight = 80.0;

  const ScanDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                padding: const EdgeInsets.only(left: AppPadding.p30),
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height/2,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: AppSize.s50,
                          height: AppSize.s50,
                          padding: const EdgeInsets.all(AppPadding.p10),
                          decoration: BoxDecoration(
                            color: ColorManager.black.withOpacity(0.64),
                            borderRadius: BorderRadius.circular(AppSize.s10),
                          ),
                          child: Image.asset(ImageAssets.sunLight),
                        ),
                        const SizedBox(width: AppSize.s15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                  children: [
                                    TextSpan(text: '78', style: getBoldStyle(color: ColorManager.white, fontSize: FontSize.s22)),
                                    WidgetSpan(
                                      child: Transform.translate(
                                        offset: const Offset(2, -10),
                                        child: Text('%', style: getBoldStyle(color: ColorManager.white, fontSize: FontSize.s16)),
                                      ),
                                    )
                                  ]
                              ),
                            ),
                            Text(StringManager.sunLight, style: getRegularStyle(color: ColorManager.white)),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSize.s20),
                    Row(
                      children: [
                        Container(
                          width: AppSize.s50,
                          height: AppSize.s50,
                          padding: const EdgeInsets.all(AppPadding.p10),
                          decoration: BoxDecoration(
                            color: ColorManager.black.withOpacity(0.64),
                            borderRadius: BorderRadius.circular(AppSize.s10),
                          ),
                          child: Image.asset(ImageAssets.waterCapacity),
                        ),
                        const SizedBox(width: AppSize.s15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                  children: [
                                    TextSpan(text: '10', style: getBoldStyle(color: ColorManager.white, fontSize: FontSize.s22)),
                                    WidgetSpan(
                                      child: Transform.translate(
                                        offset: const Offset(2, -10),
                                        child: Text('%', style: getBoldStyle(color: ColorManager.white, fontSize: FontSize.s16)),
                                      ),
                                    )
                                  ]
                              ),
                            ),
                            Text(StringManager.waterCapacity, style: getRegularStyle(color: ColorManager.white)),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSize.s20),
                    Row(
                      children: [
                        Container(
                          width: AppSize.s50,
                          height: AppSize.s50,
                          padding: const EdgeInsets.all(AppPadding.p10),
                          decoration: BoxDecoration(
                            color: ColorManager.black.withOpacity(0.64),
                            borderRadius: BorderRadius.circular(AppSize.s10),
                          ),
                          child: Image.asset(ImageAssets.temperature),
                        ),
                        const SizedBox(width: AppSize.s15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                  children: [
                                    TextSpan(text: '29', style: getBoldStyle(color: ColorManager.white, fontSize: FontSize.s22)),
                                    WidgetSpan(
                                      child: Transform.translate(
                                        offset: const Offset(0, -10),
                                        child: Text('°', style: getBoldStyle(color: ColorManager.white, fontSize: FontSize.s16)),
                                      ),
                                    ),
                                    TextSpan(text: ' C', style: getBoldStyle(color: ColorManager.white, fontSize: FontSize.s22)),
                                  ]
                              ),
                            ),
                            Text(StringManager.temperature, style: getRegularStyle(color: ColorManager.white)),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: AppPadding.p30, right: AppPadding.p30),
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height/2 - MediaQuery.of(context).padding.top - bottomNavigationBarHeight,
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
                        Text('SNAKE PLANT (SANSEVIERIA)', style: getBoldStyle(color: ColorManager.black, fontSize: FontSize.s20)),
                        const SizedBox(height: AppSize.s5),
                        Text('Native to southern Africa, snake plants are well adapted to conditions similar to those in southern regions of the United States. Because of this, they may be grown outdoors for part of all of the year in USDA zones 8 and warmer', style: getRegularStyle(color: ColorManager.grey4)),
                        const SizedBox(height: AppSize.s20),
                        Text('Common Snake Plant Diseases', style: getBoldStyle(color: ColorManager.black, fontSize: FontSize.s18)),
                        const SizedBox(height: AppSize.s5),
                        Text("A widespread problem with snake plants is root rot. This results from over-watering the soil of the plant and is most common in the colder months of the year. When room rot occurs, the plant roots can die due to a lack of oxygen and an overgrowth of fungus within the soil. If the snake plant's soil is soggy, certain microorganisms such as Rhizoctonia and Pythium can begin to populate and multiply, spreading disease throughout", style: getRegularStyle(color: ColorManager.grey4)),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
          height: bottomNavigationBarHeight,
          padding: const EdgeInsets.only(left: AppPadding.p30, right: AppPadding.p30, top: AppPadding.p10, bottom: AppPadding.p20),
          child: CustomButton(
            onPressed: () => Navigator.pushNamed(context, Routes.blogsRoute),
            text: StringManager.goToBlog,
            radius: AppSize.s10,
            height: AppSize.s50,
          )
      ),
    );
  }
}