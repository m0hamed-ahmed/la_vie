import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_vie/core/utils/cache_helper.dart';
import 'package:la_vie/core/utils/methods.dart';
import 'package:la_vie/data/data_source/remote_data_source.dart';
import 'package:la_vie/data/models/user_model.dart';
import 'package:la_vie/data/repository/repository.dart';
import 'package:la_vie/domain/entities/user.dart';
import 'package:la_vie/domain/repository/base_repository.dart';
import 'package:la_vie/domain/usecases/update_user_usecase.dart';
import 'package:la_vie/presentation/controller/profile/states.dart';
import 'package:la_vie/presentation/resources/color_manager.dart';
import 'package:la_vie/presentation/resources/routes_manager.dart';
import 'package:la_vie/presentation/resources/strings_manager.dart';
import 'package:la_vie/presentation/resources/values_manager.dart';
import 'package:la_vie/presentation/widgets/custom_text_form_field.dart';

class ProfileCubit extends Cubit<ProfileStates> {
  ProfileCubit() : super(ProfileInitialState());

  static ProfileCubit get(context) => BlocProvider.of(context);

  UserModel userModel = UserModel.fromLocalJson(json.decode(CacheHelper.getData(key: PREFERENCES_KEY_USER_DATA)));

  Future<bool> showUpdateNameDialog({required BuildContext context}) async {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    String newFirstName = '';
    String newLastName = '';

    return (
        await (showDialog(
          context: context,
          builder: (context) => AlertDialog(
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(AppSize.s10))),
            title: Text(StringManager.changeName, style: Theme.of(context).textTheme.titleLarge!.copyWith(color: ColorManager.black)),
            titlePadding: const EdgeInsets.only(left: AppPadding.p16, right: AppPadding.p16, top: AppPadding.p16, bottom: AppPadding.p8),
            content: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Old Name', style: Theme.of(context).textTheme.titleSmall!.copyWith(color: ColorManager.grey1)),
                  const SizedBox(height: AppSize.s5),
                  CustomTextFormField(
                    controller: TextEditingController(text: '${userModel.firstName} ${userModel.lastName}'),
                    enabled: false,
                    prefixIcon: Icons.person,
                  ),

                  const SizedBox(height: AppSize.s10),

                  Text('New First Name', style: Theme.of(context).textTheme.titleSmall!.copyWith(color: ColorManager.grey1)),
                  const SizedBox(height: AppSize.s5),
                  CustomTextFormField(
                    controller: TextEditingController(text: newFirstName),
                    prefixIcon: Icons.person,
                    isValidatorRequired: true,
                    onChanged: (val) => newFirstName = val,
                  ),

                  const SizedBox(height: AppSize.s10),

                  Text('New Last Name', style: Theme.of(context).textTheme.titleSmall!.copyWith(color: ColorManager.grey1)),
                  const SizedBox(height: AppSize.s5),
                  CustomTextFormField(
                    controller: TextEditingController(text: newLastName),
                    prefixIcon: Icons.person,
                    isValidatorRequired: true,
                    onChanged: (val) => newLastName = val,
                  ),
                ],
              ),
            ),
            contentPadding: const EdgeInsets.only(top: AppPadding.p16, left: AppPadding.p16, right: AppPadding.p16, bottom: AppPadding.p8),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(StringManager.no, style: Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold)),
              ),
              TextButton(
                onPressed: () {
                  if(formKey.currentState!.validate()) {
                    updateName(context, userModel, newFirstName, newLastName);
                  }
                },
                child: Text(StringManager.yes, style: Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ))
    ) ?? false;
  }

  updateName(BuildContext context, User user, String newFirstName, String newLastName) async {
    emit(ProfileLoadingState());
    BaseRemoteDataSource baseRemoteDataSource = RemoteDataSource();
    BaseRepository baseRepository = Repository(baseRemoteDataSource);
    UpdateUserUsecase updateUserUsecase = UpdateUserUsecase(baseRepository);
    await updateUserUsecase.execute(newFirstName, newLastName, user.email, user.address??'address').then((value) {
      value.fold((failure) {
        Methods.showToastMessage(failure.message, toastColor: ColorManager.red700);
        emit(ProfileErrorState());
      }, (userAfterUpdate) async {
        // ignore: use_build_context_synchronously
        Navigator.of(context).pop(true);
        Methods.showToastMessage(userAfterUpdate.message);
        await CacheHelper.setData(key: PREFERENCES_KEY_USER_DATA, value: json.encode(UserModel.toMap(userAfterUpdate)));
        userModel = UserModel.fromLocalJson(json.decode(CacheHelper.getData(key: PREFERENCES_KEY_USER_DATA)));
        emit(ProfileSuccessState());
      });
    });
  }

  Future<bool> showUpdateEmailDialog({required BuildContext context}) async {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    String newEmail = '';

    return (
        await (showDialog(
          context: context,
          builder: (context) => AlertDialog(
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(AppSize.s10))),
            title: Text(StringManager.changeEmail, style: Theme.of(context).textTheme.titleLarge!.copyWith(color: ColorManager.black)),
            titlePadding: const EdgeInsets.only(left: AppPadding.p16, right: AppPadding.p16, top: AppPadding.p16, bottom: AppPadding.p8),
            content: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Old Email', style: Theme.of(context).textTheme.titleSmall!.copyWith(color: ColorManager.grey1)),
                  const SizedBox(height: AppSize.s5),
                  CustomTextFormField(
                    controller: TextEditingController(text: userModel.email),
                    enabled: false,
                    prefixIcon: Icons.email,
                  ),

                  const SizedBox(height: AppSize.s10),

                  Text('New Email', style: Theme.of(context).textTheme.titleSmall!.copyWith(color: ColorManager.grey1)),
                  const SizedBox(height: AppSize.s5),
                  CustomTextFormField(
                    controller: TextEditingController(text: newEmail),
                    textInputType: TextInputType.emailAddress,
                    prefixIcon: Icons.email,
                    isValidatorRequired: true,
                    onChanged: (val) => newEmail = val,
                  ),
                ],
              ),
            ),
            contentPadding: const EdgeInsets.only(top: AppPadding.p16, left: AppPadding.p16, right: AppPadding.p16, bottom: AppPadding.p8),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(StringManager.no, style: Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold)),
              ),
              TextButton(
                onPressed: () {
                  if(formKey.currentState!.validate()) {
                    updateEmail(context, userModel, newEmail);
                  }
                },
                child: Text(StringManager.yes, style: Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ))
    ) ?? false;
  }

  updateEmail(BuildContext context, User user, String newEmail) async {
    emit(ProfileLoadingState());
    BaseRemoteDataSource baseRemoteDataSource = RemoteDataSource();
    BaseRepository baseRepository = Repository(baseRemoteDataSource);
    UpdateUserUsecase updateUserUsecase = UpdateUserUsecase(baseRepository);
    await updateUserUsecase.execute(user.firstName, user.lastName, newEmail, user.address??'address').then((value) {
      value.fold((failure) {
        Methods.showToastMessage(failure.message, toastColor: ColorManager.red700);
        emit(ProfileErrorState());
      }, (userAfterUpdate) async {
        // ignore: use_build_context_synchronously
        Navigator.of(context).pop(true);
        Methods.showToastMessage(userAfterUpdate.message);
        await CacheHelper.setData(key: PREFERENCES_KEY_USER_DATA, value: json.encode(UserModel.toMap(userAfterUpdate)));
        userModel = UserModel.fromLocalJson(json.decode(CacheHelper.getData(key: PREFERENCES_KEY_USER_DATA)));
        emit(ProfileSuccessState());
      });
    });
  }

  logout(BuildContext context) async {
    await CacheHelper.removeData(key: PREFERENCES_KEY_USER_DATA);
    // ignore: use_build_context_synchronously
    Navigator.pushReplacementNamed(context, Routes.loginRoute);
  }
}