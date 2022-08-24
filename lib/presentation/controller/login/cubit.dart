import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_vie/core/utils/cache_helper.dart';
import 'package:la_vie/core/utils/methods.dart';
import 'package:la_vie/data/data_source/remote_data_source.dart';
import 'package:la_vie/data/models/user_model.dart';
import 'package:la_vie/data/repository/repository.dart';
import 'package:la_vie/domain/repository/base_repository.dart';
import 'package:la_vie/domain/usecases/login_usecase.dart';
import 'package:la_vie/presentation/controller/login/states.dart';
import 'package:la_vie/presentation/controller/profile/cubit.dart';
import 'package:la_vie/presentation/resources/color_manager.dart';
import 'package:la_vie/presentation/resources/routes_manager.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  bool _isShowPassword = false;
  bool get isShowPassword => _isShowPassword;
  changeShowPassword(bool isShowPassword) {
    _isShowPassword = isShowPassword;
    emit(LoginChangeShowPasswordState());
  }

  login(BuildContext context, String email, String password) async {
    emit(LoginLoadingState());
    BaseRemoteDataSource baseRemoteDataSource = RemoteDataSource();
    BaseRepository baseRepository = Repository(baseRemoteDataSource);
    LoginUsecase loginUsecase  = LoginUsecase(baseRepository);
    await loginUsecase.execute(email, password).then((value) {
      value.fold((failure) {
        Methods.showToastMessage(failure.message, toastColor: ColorManager.red700);
        emit(LoginErrorState());
      }, (user) async {
        Methods.showToastMessage(user.message);
        emit(LoginSuccessState());
        await CacheHelper.setData(key: PREFERENCES_KEY_USER_DATA, value: json.encode(UserModel.toMap(user)));
        // ignore: use_build_context_synchronously
        context.read<ProfileCubit>().userModel = UserModel.fromLocalJson(json.decode(CacheHelper.getData(key: PREFERENCES_KEY_USER_DATA)));
        // ignore: use_build_context_synchronously
        Navigator.pushReplacementNamed(context, Routes.mainRoute);
      });
    });
  }
}