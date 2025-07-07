import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreenMain extends StatefulWidget {
  const SplashScreenMain({super.key});

  @override
  State<SplashScreenMain> createState() => _SplashScreenMainState();
}

class _SplashScreenMainState extends State<SplashScreenMain> {
  @override
  Widget build(BuildContext context) {
    return Container(child: Column(
      children: [
        Container(
          height: 150.h,
          width: 150.w,
          child: Image.asset("assets/image/logo-otaqu.png")),
        Text("App powered by Otaqu")

      ],
    ),);
  }
}