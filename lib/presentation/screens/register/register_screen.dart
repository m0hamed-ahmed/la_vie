import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_vie/core/utils/methods.dart';
import 'package:la_vie/presentation/controller/register/states.dart';
import 'package:la_vie/presentation/widgets/loading_widget.dart';
import 'package:la_vie/presentation/resources/assets_manager.dart';
import 'package:la_vie/presentation/resources/color_manager.dart';
import 'package:la_vie/presentation/resources/font_manager.dart';
import 'package:la_vie/presentation/resources/routes_manager.dart';
import 'package:la_vie/presentation/resources/strings_manager.dart';
import 'package:la_vie/presentation/resources/styles_manager.dart';
import 'package:la_vie/presentation/resources/values_manager.dart';
import 'package:la_vie/presentation/controller/register/cubit.dart';
import 'package:la_vie/presentation/widgets/background_shape.dart';
import 'package:la_vie/presentation/widgets/custom_button.dart';
import 'package:la_vie/presentation/widgets/custom_text_form_field.dart';
import 'package:la_vie/presentation/widgets/la_vie_logo.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _signUpFormKey = GlobalKey<FormState>();
  final TextEditingController _textEditingControllerFirstName = TextEditingController();
  final TextEditingController _textEditingControllerLastName = TextEditingController();
  final TextEditingController _textEditingControllerEmail = TextEditingController();
  final TextEditingController _textEditingControllerPassword = TextEditingController();
  final TextEditingController _textEditingControllerConfirmPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: AppSize.s0),
      body: BlocBuilder<RegisterCubit, RegisterStates>(
        builder: (context, state) {
          RegisterCubit cubit = RegisterCubit.get(context);
          return AbsorbPointer(
            absorbing: state is RegisterLoadingState ? true : false,
            child: Container(
              color: state is RegisterLoadingState ? ColorManager.black.withOpacity(0.02) : null,
              child: Stack(
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                InkWell(
                                  onTap: () => Navigator.pushReplacementNamed(context, Routes.loginRoute),
                                  child: Column(
                                    children: [
                                      Text(StringManager.login, style: getRegularStyle(color: ColorManager.grey1, fontSize: FontSize.s18)),
                                      const SizedBox(height: AppSize.s10),
                                      Container(
                                        width: AppSize.s50,
                                        height: AppSize.s3,
                                        color: Colors.transparent,
                                      ),
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: () {},
                                  child: Column(
                                    children: [
                                      Text(StringManager.signUp, style: getRegularStyle(color: ColorManager.primary, fontSize: FontSize.s18)),
                                      const SizedBox(height: AppSize.s10),
                                      Container(
                                        width: AppSize.s50,
                                        height: AppSize.s3,
                                        color: ColorManager.primary,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: AppSize.s50),
                            Form(
                              key: _signUpFormKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(StringManager.firstName, style: getMediumStyle(color: ColorManager.grey2)),
                                          const SizedBox(height: AppSize.s5),
                                          CustomTextFormField(
                                            controller: _textEditingControllerFirstName,
                                            prefixIcon: Icons.person,
                                            isValidatorRequired: true,
                                          ),
                                        ],
                                      )),
                                      const SizedBox(width: AppSize.s10),
                                      Expanded(child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(StringManager.lastName, style: getMediumStyle(color: ColorManager.grey2)),
                                          const SizedBox(height: AppSize.s5),
                                          CustomTextFormField(
                                            controller: _textEditingControllerLastName,
                                            prefixIcon: Icons.person,
                                            isValidatorRequired: true,
                                          ),
                                        ],
                                      )),
                                    ],
                                  ),
                                  const SizedBox(height: AppSize.s25),

                                  Text(StringManager.email, style: getMediumStyle(color: ColorManager.grey2)),
                                  const SizedBox(height: AppSize.s5),
                                  CustomTextFormField(
                                    controller: _textEditingControllerEmail,
                                    prefixIcon: Icons.email,
                                    textInputType: TextInputType.emailAddress,
                                    isValidatorRequired: true,
                                  ),
                                  const SizedBox(height: AppSize.s25),

                                  Text(StringManager.password, style: getMediumStyle(color: ColorManager.grey2)),
                                  const SizedBox(height: AppSize.s5),
                                  CustomTextFormField(
                                    controller: _textEditingControllerPassword,
                                    prefixIcon: Icons.password,
                                    textInputType: TextInputType.visiblePassword,
                                    obscureText: cubit.isShowPassword,
                                    isValidatorRequired: true,
                                    suffix: IconButton(
                                      onPressed: () {
                                        cubit.changeShowPassword(!cubit.isShowPassword);
                                      },
                                      icon: Icon(cubit.isShowPassword ? Icons.visibility : Icons.visibility_off, color: ColorManager.primary),
                                    ),
                                  ),
                                  const SizedBox(height: AppSize.s25),

                                  Text(StringManager.confirmPassword, style: getMediumStyle(color: ColorManager.grey2)),
                                  const SizedBox(height: AppSize.s5),
                                  CustomTextFormField(
                                    controller: _textEditingControllerConfirmPassword,
                                    prefixIcon: Icons.password,
                                    textInputType: TextInputType.visiblePassword,
                                    obscureText: cubit.isShowPassword,
                                    isValidatorRequired: true,
                                    suffix: IconButton(
                                      onPressed: () {
                                        cubit.changeShowPassword(!cubit.isShowPassword);
                                      },
                                      icon: Icon(cubit.isShowPassword ? Icons.visibility : Icons.visibility_off, color: ColorManager.primary),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: AppSize.s50),
                            CustomButton(
                              onPressed: () {
                                FocusScope.of(context).unfocus();
                                if(_signUpFormKey.currentState!.validate()) {
                                  if(_textEditingControllerPassword.text == _textEditingControllerConfirmPassword.text) {
                                    cubit.register(
                                      context,
                                      _textEditingControllerFirstName.text.trim(),
                                      _textEditingControllerLastName.text.trim(),
                                      _textEditingControllerEmail.text.trim(),
                                      _textEditingControllerPassword.text,
                                    );
                                  } else {
                                    Methods.showToastMessage(StringManager.passwordNotMatch, toastColor: ColorManager.red700);
                                  }
                                }
                              },
                              text: StringManager.signUp,
                            ),
                            const SizedBox(height: AppSize.s20),
                            Row(
                              children: [
                                Expanded(child: Divider(color: ColorManager.grey4)),
                                const SizedBox(width: AppSize.s10),
                                Text(StringManager.orContinueWith, style: getRegularStyle(color: ColorManager.grey4)),
                                const SizedBox(width: AppSize.s10),
                                Expanded(child: Divider(color: ColorManager.grey4)),
                              ],
                            ),
                            const SizedBox(height: AppSize.s20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                    FocusScope.of(context).unfocus();
                                  },
                                  child: Image.asset(ImageAssets.googleIc, width: AppSize.s25),
                                ),
                                const SizedBox(width: AppSize.s20),
                                InkWell(
                                  onTap: () {
                                    FocusScope.of(context).unfocus();
                                  },
                                  child: Image.asset(ImageAssets.facebookIc, width: AppSize.s30),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  if(state is RegisterLoadingState) const LoadingWidget(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _textEditingControllerFirstName.dispose();
    _textEditingControllerLastName.dispose();
    _textEditingControllerEmail.dispose();
    _textEditingControllerPassword.dispose();
    _textEditingControllerConfirmPassword.dispose();
    super.dispose();
  }
}