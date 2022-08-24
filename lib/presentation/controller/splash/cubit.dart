import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_vie/core/utils/cache_helper.dart';
import 'package:la_vie/presentation/controller/splash/states.dart';
import 'package:la_vie/presentation/resources/constants_manager.dart';
import 'package:la_vie/presentation/resources/routes_manager.dart';

class SplashCubit extends Cubit<SplashStates> {
  SplashCubit() : super(SplashInitialState());

  static SplashCubit get(context) => BlocProvider.of(context);

  Timer? timer;

  void startDelay(BuildContext context) {
    timer = Timer(const Duration(seconds: AppConstants.splashDelay), () => _goNext(context));
  }

  void _goNext(BuildContext context) async {
    timer?.cancel();
    if(CacheHelper.getData(key: PREFERENCES_KEY_USER_DATA) == null) {
      Navigator.pushReplacementNamed(context, Routes.loginRoute);
    }
    else {
      Navigator.pushReplacementNamed(context, Routes.mainRoute);
    }
  }
}