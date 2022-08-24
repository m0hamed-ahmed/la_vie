import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_vie/presentation/controller/create_post/cubit.dart';
import 'package:la_vie/presentation/controller/create_post/states.dart';
import 'package:la_vie/presentation/resources/color_manager.dart';
import 'package:la_vie/presentation/resources/font_manager.dart';
import 'package:la_vie/presentation/resources/strings_manager.dart';
import 'package:la_vie/presentation/resources/styles_manager.dart';
import 'package:la_vie/presentation/resources/values_manager.dart';
import 'package:la_vie/presentation/widgets/custom_button.dart';
import 'package:la_vie/presentation/widgets/custom_text_form_field.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({Key? key}) : super(key: key);

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController textEditingControllerTitle = TextEditingController();
  TextEditingController textEditingControllerDescription = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(StringManager.createNewPost),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_rounded),
        ),
      ),
      body: BlocBuilder<CreatePostCubit, CreatePostStates>(
        builder: (context, state) {
          CreatePostCubit cubit = CreatePostCubit.get(context);
          return Padding(
            padding: const EdgeInsets.all(AppPadding.p16),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    InkWell(
                      onTap: () => cubit.changeImage(),
                      borderRadius: BorderRadius.circular(AppSize.s10),
                      child: Container(
                        clipBehavior: Clip.antiAlias,
                        width: AppSize.s140,
                        height: AppSize.s140,
                        decoration: BoxDecoration(
                          border: Border.all(color: ColorManager.primary),
                          borderRadius: BorderRadius.circular(AppSize.s10),
                        ),
                        child: cubit.image != null ? Image.file(File(cubit.image!.path), fit: BoxFit.fill) : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add, color: ColorManager.primary),
                            const SizedBox(height: AppSize.s5),
                            Text(StringManager.addPhoto, style: getRegularStyle(color: ColorManager.primary, fontSize: FontSize.s16)),
                          ],
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(StringManager.title),
                        const SizedBox(height: AppSize.s10),
                        CustomTextFormField(
                          controller: textEditingControllerTitle,
                          isValidatorRequired: true,
                        )
                      ],
                    ),
                    const SizedBox(height: AppSize.s20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(StringManager.description),
                        const SizedBox(height: AppSize.s10),
                        CustomTextFormField(
                          controller: textEditingControllerDescription,
                          maxLines: 10,
                          isValidatorRequired: true,
                        )
                      ],
                    ),
                    const SizedBox(height: AppSize.s20),
                    CustomButton(
                      onPressed: () {
                        if(_formKey.currentState!.validate()) {
                          cubit.createPost(
                            context: context,
                            title: textEditingControllerTitle.text.trim(),
                            description: textEditingControllerDescription.text.trim(),
                            imageBase64: "data:image/png;base64,${base64Encode(File(cubit.image!.path).readAsBytesSync())}",
                          );
                        }
                      },
                      text: StringManager.post,
                      radius: AppSize.s10,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    textEditingControllerTitle.dispose();
    textEditingControllerDescription.dispose();
    super.dispose();
  }
}