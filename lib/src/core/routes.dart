import 'package:flutter/material.dart';
import 'package:ninja_connect/src/features/authentication/models/app_user.dart';
import 'package:ninja_connect/src/features/authentication/views/login_view.dart';
import 'package:ninja_connect/src/features/authentication/views/register_view.dart';
import 'package:ninja_connect/src/features/authentication/views/verify_email_view.dart';
import 'package:ninja_connect/src/features/forum/views/add_forum_view.dart';
import 'package:ninja_connect/src/features/home/views/dashboard_view.dart';
import 'package:ninja_connect/src/features/start_up/views/onboarding_view.dart';
import 'package:ninja_connect/src/features/start_up/views/welcome_view.dart';

class Routes {
  static const onboard = '/onboardingView';
  static const login = '/loginView';
  static const register = '/registerView';
  static const naija = '/9jaHome';
  static const welcome = '/welcomeView';
  static const verifyEmail = '/verifyEmail';
  static const home = '/homeView';
  static const chat = '/chatView';
  static const profile = '/profileView';
  static const add = '/addForum';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case onboard:
        return MaterialPageRoute(builder: (_) => const OnboardingView());
      case welcome:
        return MaterialPageRoute(builder: (_) => const WelcomeView());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginView());
      case register:
        return MaterialPageRoute(builder: (_) => const RegisterView());
      case naija:
        final appUser = settings.arguments as AppUser;
        return MaterialPageRoute(builder: (_) => DashboardView(user: appUser));
      case verifyEmail:
        return MaterialPageRoute(builder: (_) => const VerifyEmailView());
      case add:
        return MaterialPageRoute(builder: (_) => const AddForumView());
      // case chat:
      //   return MaterialPageRoute(builder: (_) => const chatView());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
