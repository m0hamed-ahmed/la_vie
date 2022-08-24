import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_vie/core/utils/my_behavior.dart';
import 'package:la_vie/presentation/controller/blogs/cubit.dart';
import 'package:la_vie/presentation/controller/cart/cubit.dart';
import 'package:la_vie/presentation/controller/create_post/cubit.dart';
import 'package:la_vie/presentation/controller/discussion_forums/cubit.dart';
import 'package:la_vie/presentation/controller/exam/cubit.dart';
import 'package:la_vie/presentation/controller/login/cubit.dart';
import 'package:la_vie/presentation/controller/main/cubit.dart';
import 'package:la_vie/presentation/controller/main/plants/cubit.dart';
import 'package:la_vie/presentation/controller/main/seeds/cubit.dart';
import 'package:la_vie/presentation/controller/main/tools/cubit.dart';
import 'package:la_vie/presentation/controller/profile/cubit.dart';
import 'package:la_vie/presentation/controller/splash/cubit.dart';
import 'package:la_vie/presentation/resources/routes_manager.dart';
import 'package:la_vie/presentation/resources/strings_manager.dart';
import 'package:la_vie/presentation/resources/theme_manager.dart';
import 'package:la_vie/presentation/controller/forget_password/cubit.dart';
import 'package:la_vie/presentation/controller/register/cubit.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SplashCubit()),
        BlocProvider(create: (context) => LoginCubit()),
        BlocProvider(create: (context) => RegisterCubit()),
        BlocProvider(create: (context) => ForgetPasswordCubit()),
        BlocProvider(create: (context) => MainCubit()),
        BlocProvider(create: (context) => CartCubit()),
        BlocProvider(create: (context) => ProfileCubit()),
        BlocProvider(create: (context) => PlantsCubit()..getPlants()),
        BlocProvider(create: (context) => SeedsCubit()..getSeeds()),
        BlocProvider(create: (context) => ToolsCubit()..getTools()),
        BlocProvider(create: (context) => DiscussionForumsCubit()..getDiscussionForums()),
        BlocProvider(create: (context) => CreatePostCubit()),
        BlocProvider(create: (context) => BlogsCubit()..getBlogs()),
        BlocProvider(create: (context) => ExamCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: StringManager.appName,
        theme: getApplicationTheme(),
        initialRoute: Routes.splashRoute,
        onGenerateRoute: RouteGenerator.getRoute,
        builder: (context, child) {
          return ScrollConfiguration(
            behavior: MyBehavior(),
            child: child!,
          );
        },
      ),
    );
  }
}