import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_vie/core/utils/app.dart';
import 'package:la_vie/core/utils/bloc_observer.dart';
import 'package:la_vie/core/utils/cache_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await CacheHelper.init();

  BlocOverrides.runZoned(() => runApp(const MyApp()), blocObserver: MyBlocObserver());
}