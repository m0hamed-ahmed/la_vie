import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_vie/presentation/controller/forget_password/states.dart';
import 'package:la_vie/presentation/resources/assets_manager.dart';
import 'package:la_vie/presentation/resources/color_manager.dart';
import 'package:la_vie/presentation/resources/font_manager.dart';
import 'package:la_vie/presentation/resources/strings_manager.dart';
import 'package:la_vie/presentation/resources/styles_manager.dart';
import 'package:la_vie/presentation/resources/values_manager.dart';
import 'package:la_vie/presentation/controller/forget_password/cubit.dart';
import 'package:la_vie/presentation/widgets/background_shape.dart';
import 'package:la_vie/presentation/widgets/custom_button.dart';
import 'package:la_vie/presentation/widgets/custom_text_form_field.dart';
import 'package:la_vie/presentation/widgets/la_vie_logo.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final GlobalKey<FormState> _forgetPasswordFormKey = GlobalKey<FormState>();
  final TextEditingController _textEditingControllerEmail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: AppSize.s0),
      body: BlocBuilder<ForgetPasswordCubit, ForgetPasswordStates>(
        builder: (context, state) {
          ForgetPasswordCubit cubit = ForgetPasswordCubit.get(context);
          return state is ForgetPasswordLoadingState ? const Center(child: CircularProgressIndicator()) : Stack(
            alignment: Alignment.center,
            children: [
              const BackgroundShape(alignment: AlignmentDirectional.topEnd, image: ImageAssets.imageTop),
              const BackgroundShape(alignment: AlignmentDirectional.bottomStart, image: ImageAssets.imageBottom),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p32),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: AppPadding.p32),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const LaVieLogo(),
                        const SizedBox(height: AppSize.s50),
                        Text(StringManager.forgetPassword, style: getRegularStyle(color: ColorManager.primary, fontSize: FontSize.s18)),
                        const SizedBox(height: AppSize.s10),
                        Form(
                          key: _forgetPasswordFormKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(StringManager.email, style: getMediumStyle(color: ColorManager.grey2)),
                              const SizedBox(height: AppSize.s5),
                              CustomTextFormField(
                                controller: _textEditingControllerEmail,
                                prefixIcon: Icons.email,
                                textInputType: TextInputType.emailAddress,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: AppSize.s50),
                        CustomButton(
                          onPressed: () => cubit.forgetPassword(),
                          text: StringManager.forgetPassword,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _textEditingControllerEmail.dispose();
    super.dispose();
  }
}