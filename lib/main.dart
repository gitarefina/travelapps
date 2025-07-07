import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:travelapp/features/experience/bloc/experience_bloc.dart';
import 'package:travelapp/features/experience/model/experience_model.dart';
import 'package:travelapp/features/experience/presentation/experience_page.dart';
import 'package:travelapp/features/home/bloc/home_bloc.dart';
import 'package:travelapp/features/home/presentation/home_page.dart';
import 'package:travelapp/helper/helper.dart';
import 'package:travelapp/helper/token_generate.dart';
import 'package:travelapp/service/database_service.dart';
import 'package:travelapp/service/destinations_service.dart';
import 'package:travelapp/service/experience_service.dart';
import 'package:travelapp/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  var tokenGenerate = TokenGenerate();

  final username = Helper.getUsername;
  final password = Helper.getPassword;
  print("usernamepassword$username$password");
  if (username != null && password != null) {
    TokenGenerate.setupDio(username, password);
    tokenGenerate.refreshNewToken(username, password);
  }
  runApp(
    ScreenUtilInit(
      designSize: const Size(412, 917),
      minTextAdapt: true,
      splitScreenMode: true,

      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ExperienceBloc>(
          create: (context) => ExperienceBloc(service: ExperienceService()),
        ),
        BlocProvider<HomeBloc>(
          create: (context) => HomeBloc(
            service: DestinationsService(),
            databaseService: DatabaseService(),
          ),
        ),
      ],
      child: MaterialApp.router(routerConfig: _router),
    );
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
    GoRoute(
      path: '/home',
      name: 'home',
      builder: (context, state) => HomePage(),
    ),
    GoRoute(
      path: '/experience/:id',
      name: 'experience',
      builder: (context, state) => ExperiencePage(),
    ),
  ],
);
