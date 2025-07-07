import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int _currentIndex = 0;
  final CarouselSliderController _controller = CarouselSliderController();

  final List<String> image = [
    'https://digital.ihg.com/is/image/ihg/intercontinental-bali-9719167392-2x1.png',
    'https://img.antaranews.com/cache/800x533/2024/10/02/Kunjungan-Wisman-Tertinggi-021024-hnd-7.jpg.webp',
    'https://img.antaranews.com/cache/800x533/2024/10/02/Kunjungan-Wisman-Tertinggi-021024-hnd-7.jpg.webp',
  ];

  void nextSlide() {
    setState(() {
      _currentIndex = (_currentIndex + 1) % image.length;
    });
    _controller.animateToPage(_currentIndex);
  }

  void prefSlide() {
    setState(() {
      _currentIndex = (_currentIndex - 1) % image.length;
    });
    _controller.animateToPage(_currentIndex);
  }

  void lastSlide(BuildContext context) {
    setState(() {
      _currentIndex = image.length - 1;
    });
    _controller.animateToPage(_currentIndex);
  }

  final List<String> textList = [
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
  ];

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      child: Stack(
        children: [
          ClipRRect(
            child: CarouselSlider.builder(
              carouselController: _controller,
              itemCount: image.length,
              itemBuilder: (context, index, realIndex) {
                return Stack(
                  children: [
                    Image.network(
                      image[index],

                      fit: BoxFit.cover,
                      height: height,
                      width: width,
                    ),
                    Positioned(
                      bottom: 24,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(image.length, (index) {
                          return Column(
                            children: [
                              Container(
                                width: 10,
                                height: 10,
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 4.0,
                                ),
                                decoration: BoxDecoration(
                                  color: _currentIndex == index
                                      ? Colors.white
                                      : Colors.grey,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                              ),
                            ],
                          );
                        }),
                      ),
                    ),
                  ],
                );
              },

              options: CarouselOptions(
                // autoPlayCurve: Curves.fastOutSlowIn,
                height: MediaQuery.of(context).size.height,
                viewportFraction: 1.0, // ensures full width
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                autoPlay: false,
                enlargeCenterPage: true,
              ),
            ),
          ),
          ...textListImage(),
          ...(_currentIndex == image.length - 1
              ? buttonLastIndex()
              : buttonIndex()),
        ],
      ),
    );
  }

  List<Widget> textListImage() {
    List<Widget> widgets = [];

    for (var i = 0; i < textList.length; i++) {
      widgets.add(
        Positioned(
          bottom: 50,

          child: Container(
            child: Text(
              softWrap: true,
              overflow: TextOverflow.visible,

              textList[i],
              style: TextStyle(
                color: Colors.white,
                fontFamily: "nunito",
                fontSize: 15.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      );
    }

    return widgets;
  }

  List<Widget> buttonIndex() {
    return [
      Positioned(
        bottom: 100,
        left: 50,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(
              50,
              255,
              201,
              14,
            ), // button background color
          ),

          onPressed: prefSlide,
          child: Positioned(
            bottom: 200,
            left: 30,
            child: Center(
              child: Container(
                height: 49.h,
                width: 100.w,
                child: Text(
                  "Travel Easy",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: "nunito",
                    fontSize: 32.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),

      Positioned(
        bottom: 100,
        right: 30,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(
              50,
              255,
              201,
              14,
            ), // button background color
          ),
          onPressed: nextSlide,
          child:
          
           Container(
            height: 49.h,
            width: 100.w,

            child: Text(
              "Next",
              style: TextStyle(
                color: Colors.white,
                fontFamily: "nunito",
                fontSize: 32.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    ];
  }

  List<Widget> buttonLastIndex() {
    return [
  Positioned(
        bottom: 100,
        right: 30,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(
              50,
              255,
              201,
              14,
            ), // button background color
          ),
          onPressed:() {
            print("ketrigger gaa");
              context.go('/home');

              setState(() {
                setState(() {
                  _currentIndex = image.length - 1;
                });
                _controller.animateToPage(_currentIndex);
              });
          },
          child:
          
           Container(
            height: 49.h,
            width: 100.w,

            child: Text(
              "Getting started",
              style: TextStyle(
                color: Colors.white,
                fontFamily: "nunito",
                fontSize: 32.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
  


     
    ];
  }
}
