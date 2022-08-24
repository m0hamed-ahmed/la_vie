import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_vie/presentation/controller/login/cubit.dart';
import 'package:la_vie/presentation/controller/login/states.dart';
import 'package:la_vie/presentation/widgets/loading_widget.dart';
import 'package:la_vie/presentation/resources/assets_manager.dart';
import 'package:la_vie/presentation/resources/color_manager.dart';
import 'package:la_vie/presentation/resources/font_manager.dart';
import 'package:la_vie/presentation/resources/routes_manager.dart';
import 'package:la_vie/presentation/resources/strings_manager.dart';
import 'package:la_vie/presentation/resources/styles_manager.dart';
import 'package:la_vie/presentation/resources/values_manager.dart';
import 'package:la_vie/presentation/widgets/background_shape.dart';
import 'package:la_vie/presentation/widgets/custom_button.dart';
import 'package:la_vie/presentation/widgets/custom_text_form_field.dart';
import 'package:la_vie/presentation/widgets/la_vie_logo.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  final TextEditingController _textEditingControllerEmail = TextEditingController();
  final TextEditingController _textEditingControllerPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: AppSize.s0),
      body: BlocBuilder<LoginCubit, LoginStates>(
        builder: (context, state) {
          LoginCubit cubit = LoginCubit.get(context);
          return AbsorbPointer(
            absorbing: state is LoginLoadingState ? true : false,
            child: Container(
              color: state is LoginLoadingState ? ColorManager.black.withOpacity(0.02) : null,
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
                                  onTap: () {},
                                  child: Column(
                                    children: [
                                      Text(StringManager.login, style: getRegularStyle(color: ColorManager.primary, fontSize: FontSize.s18)),
                                      const SizedBox(height: AppSize.s10),
                                      Container(
                                        width: AppSize.s50,
                                        height: AppSize.s3,
                                        color: ColorManager.primary,
                                      ),
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: () => Navigator.pushReplacementNamed(context, Routes.registerRoute),
                                  child: Column(
                                    children: [
                                      Text(StringManager.signUp, style: getRegularStyle(color: ColorManager.grey1, fontSize: FontSize.s18)),
                                      const SizedBox(height: AppSize.s10),
                                      Container(
                                        width: AppSize.s50,
                                        height: AppSize.s3,
                                        color: Colors.transparent,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: AppSize.s50),
                            Form(
                              key: _loginFormKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
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
                                    isValidatorRequired: true,
                                    obscureText: cubit.isShowPassword,
                                    suffix: IconButton(
                                      onPressed: () {
                                        cubit.changeShowPassword(!cubit.isShowPassword);
                                      },
                                      icon: Icon(cubit.isShowPassword ? Icons.visibility : Icons.visibility_off, color: ColorManager.primary),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: TextButton(
                                      onPressed: () => Navigator.pushNamed(context, Routes.forgetPasswordRoute),
                                      child: Text('${StringManager.forgetPassword}?', style: getMediumStyle(color: ColorManager.primary)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: AppSize.s50),
                            CustomButton(
                              onPressed: () {
                                FocusScope.of(context).unfocus();
                                if(_loginFormKey.currentState!.validate()) {
                                  cubit.login(
                                    context,
                                    _textEditingControllerEmail.text,
                                    _textEditingControllerPassword.text,
                                  );
                                }
                              },
                              text: StringManager.login,
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
                  if(state is LoginLoadingState) const LoadingWidget(),
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
    _textEditingControllerEmail.dispose();
    _textEditingControllerPassword.dispose();
    super.dispose();
  }
}