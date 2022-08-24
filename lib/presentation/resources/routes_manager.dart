import 'package:flutter/material.dart';
import 'package:la_vie/presentation/resources/strings_manager.dart';
import 'package:la_vie/presentation/screens/blog_details_screen/blog_details_screen.dart';
import 'package:la_vie/presentation/screens/blogs/blogs_screen.dart';
import 'package:la_vie/presentation/screens/cart/cart_screen.dart';
import 'package:la_vie/presentation/screens/create_post/create_post_screen.dart';
import 'package:la_vie/presentation/screens/discussion_forums/discussion_forums_screen.dart';
import 'package:la_vie/presentation/screens/exam/exam_screen.dart';
import 'package:la_vie/presentation/screens/forget_password/forget_password_screen.dart';
import 'package:la_vie/presentation/screens/login/login_screen.dart';
import 'package:la_vie/presentation/screens/main/main_screen.dart';
import 'package:la_vie/presentation/screens/notification/notifications_screen.dart';
import 'package:la_vie/presentation/screens/profile/profile_screen.dart';
import 'package:la_vie/presentation/screens/register/register_screen.dart';
import 'package:la_vie/presentation/screens/scan_details/scan_details_screen.dart';
import 'package:la_vie/presentation/screens/splash/splash_screen.dart';

class Routes {
  static const String splashRoute = '/';
  static const String loginRoute = '/loginRoute';
  static const String registerRoute = '/registerRoute';
  static const String forgetPasswordRoute = '/forgetPasswordRoute';
  static const String mainRoute = '/mainRoute';
  static const String cartRoute = '/cartRoute';
  static const String discussionForumsRoute = '/discussionForumsRoute';
  static const String createPostRoute = '/createPostRoute';
  static const String blogsRoute = '/blogsRoute';
  static const String blogDetailsRoute = '/blogDetailsRoute';
  static const String scanDetailsRoute = '/scanDetailsRoute';
  static const String notificationsRoute = '/notificationsRoute';
  static const String profileRoute = '/profileRoute';
  static const String examRoute = '/examRoute';
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch(routeSettings.name) {
      case Routes.splashRoute: return MaterialPageRoute(builder: (_) => const SplashScreen());
      case Routes.loginRoute: return MaterialPageRoute(builder: (_) => const LoginScreen());
      case Routes.registerRoute: return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case Routes.forgetPasswordRoute: return MaterialPageRoute(builder: (_) => const ForgetPasswordScreen());
      case Routes.mainRoute: return MaterialPageRoute(builder: (_) => const MainScreen());
      case Routes.cartRoute: return MaterialPageRoute(builder: (_) => const CartScreen());
      case Routes.discussionForumsRoute: return MaterialPageRoute(builder: (_) => const DiscussionForumsScreen());
      case Routes.createPostRoute: return MaterialPageRoute(builder: (_) => const CreatePostScreen());
      case Routes.blogsRoute: return MaterialPageRoute(builder: (_) => const BlogsScreen());
      case Routes.blogDetailsRoute: return MaterialPageRoute(builder: (_) => BlogDetailsScreen(item: routeSettings.arguments));
      case Routes.scanDetailsRoute: return MaterialPageRoute(builder: (_) => const ScanDetailsScreen());
      case Routes.notificationsRoute: return MaterialPageRoute(builder: (_) => const NotificationsScreen());
      case Routes.profileRoute: return MaterialPageRoute(builder: (_) => const ProfileScreen());
      case Routes.examRoute: return MaterialPageRoute(builder: (_) => const ExamScreen());

      default: return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text(StringManager.noRouteFound)
        ),
        body: const Center(
          child: Text(StringManager.noRouteFound)
        ),
      )
    );
  }
}