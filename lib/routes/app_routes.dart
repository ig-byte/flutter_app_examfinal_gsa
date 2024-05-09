import 'package:flutter/material.dart';
import 'package:flutter_app_examfinal_gsa/screens/create_user_screen.dart';
import 'package:flutter_app_examfinal_gsa/screens/login_screen.dart';
import 'package:flutter_app_examfinal_gsa/screens/main_screen.dart';
import 'package:flutter_app_examfinal_gsa/screens/screens.dart';

class AppRoutes {
  static const initialRoute = 'login';
  static Map<String, Widget Function(BuildContext)> routes = {
    'mainScreen': (BuildContext context) => const MainScreen(),
    'login': (BuildContext context) => const LoginScreen(),
    'list': (BuildContext context) => const ListProductScreen(),
    'edit': (BuildContext context) => const EditProductScreen(),
    'edit_category': (BuildContext context) => const EditCategoryScreen(),
    'edit_proveedor': (BuildContext context) => const EditProveedorScreen(),
    'add_user': (BuildContext context) => const RegisterUserScreen(),
  };

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => const ErrorScreen(),
    );
  }
}
