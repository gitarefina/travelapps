import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:travelapp/features/home/presentation/home_page.dart';
import 'package:travelapp/splash_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp.router(routerConfig: _router,);
  }
}

final GoRouter _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'splash',
      builder: (context, state) => SplashScreen(),
    ),
    GoRoute(path: '/home',name: 'home',builder: (context, state) => HomePage(),),
  ],
);
