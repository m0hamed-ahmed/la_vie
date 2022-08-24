import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_vie/presentation/controller/exam/cubit.dart';
import 'package:la_vie/presentation/controller/exam/states.dart';
import 'package:la_vie/presentation/resources/color_manager.dart';
import 'package:la_vie/presentation/resources/font_manager.dart';
import 'package:la_vie/presentation/resources/strings_manager.dart';
import 'package:la_vie/presentation/resources/styles_manager.dart';
import 'package:la_vie/presentation/resources/values_manager.dart';
import 'package:la_vie/presentation/widgets/custom_button.dart';

class ExamScreen extends StatelessWidget {
  const ExamScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(StringManager.courseExam),
      ),
      body: BlocBuilder<ExamCubit, ExamStates>(
        builder: (context, state) {
          ExamCubit cubit = ExamCubit.get(context);
          return Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text('Question ', style: getMediumStyle(color: ColorManager.black, fontSize: FontSize.s36)),
                      Text(cubit.currentQuestion.toString(), style: getMediumStyle(color: ColorManager.primary, fontSize: FontSize.s36)),
                      Text('/ ${cubit.totalNumberOfQuestions}'),
                    ],
                  ),
                  const SizedBox(height: AppSize.s40),
                  Text('What is the user experience?', style: getBoldStyle(color: ColorManager.black, fontSize: FontSize.s20)),
                  const SizedBox(height: AppSize.s40),
                  Column(
                    children: List.generate(3, (index) => Container(
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.only(bottom: AppSize.s30),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: ColorManager.primary, width: 2),
                      ),
                      child: InkWell(
                        onTap: () => cubit.changeCorrectIndex(index),
                        child: Row(
                          children: [
                            Flexible(
                                child: Text('The user experience is how the developer feels about a user.', style: getMediumStyle(color: ColorManager.black, fontSize: FontSize.s16))
                            ),
                            const SizedBox(width: AppSize.s10),
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  width: AppSize.s25,
                                  height: AppSize.s25,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(color: ColorManager.primary, width: AppSize.s2),
                                  ),
                                ),
                                cubit.correctIndex[cubit.currentQuestion-1] == null
                                  ? Container()
                                  : cubit.correctIndex[cubit.currentQuestion-1] == index ? Container(
                                  width: AppSize.s15,
                                  height: AppSize.s15,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: ColorManager.primary,
                                  ),
                                ) : Container()
                              ],
                            ),
                          ],
                        ),
                      ),
                    )),
                  ),
                  const SizedBox(height: AppSize.s40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        child: CustomButton(
                          onPressed: () => cubit.backCurrentQuestion(),
                          text: StringManager.back,
                          radius: 10,
                          buttonColor: ColorManager.white,
                          borderColor: ColorManager.primary,
                          elevation: 0,
                          textColor: ColorManager.primary,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: CustomButton(
                          onPressed: () => cubit.nextCurrentQuestion(),
                          text: StringManager.next,
                          radius: 10,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}