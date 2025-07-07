import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SplashScreenMain extends StatefulWidget {
  const SplashScreenMain({super.key});

  @override
  State<SplashScreenMain> createState() => _SplashScreenMainState();
}

class _SplashScreenMainState extends State<SplashScreenMain> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () {
      // Replace this with your target screen
      context.go('/home'); // or use push if needed
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Container(
            height: 300.h,
            width: 300.w,
            child: Image.asset("assets/image/logo-otaqu.png"),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 100),
            child: Align(
              
              alignment: Alignment.bottomCenter,
              child: Text("App powered by Otaqu",style: TextStyle(color: const Color.fromARGB(255, 88, 87, 87),fontFamily: 'nunito',fontSize: 20.sp),)),
          ),
        ],
      ),
    );
  }
}
