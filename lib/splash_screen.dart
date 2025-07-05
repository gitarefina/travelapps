import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int _currentIndex = 0;
  final CarouselSliderController _controller = CarouselSliderController();

  final List<String> image = [
    'https://img.antaranews.com/cache/800x533/2024/10/02/Kunjungan-Wisman-Tertinggi-021024-hnd-7.jpg.webp',
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

  void lastSlide(){
     setState(() {
      _currentIndex =image.length-1;
    });
    _controller.animateToPage(_currentIndex);

  }

  final List<String> textList = [
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
                          return Container(
                            width: 10,
                            height: 10,
                            margin: const EdgeInsets.symmetric(horizontal: 4.0),
                            decoration: BoxDecoration(
                              color: _currentIndex == index
                                  ? Colors.white
                                  : Colors.grey,
                              borderRadius: BorderRadius.circular(100),
                            ),
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
  List<Widget> textListImage(){
    return [
        Positioned(child: Text("data")),
        Positioned(child: Text("data"))

    ];
  }
  List<Widget> buttonIndex() {
    return [
      Positioned(
        bottom: 100,
        left: 10,
        child: ElevatedButton(
          onPressed: prefSlide,
          child: Container(child: Text("Skip")),
        ),
      ),

      Positioned(
        bottom: 100,
        right: 10,
        child: ElevatedButton(
          onPressed: nextSlide,
          child: Container(child: Text("Next")),
        ),
      ),
    ];
  }

  List<Widget> buttonLastIndex() {
    return[ Positioned(
        bottom: 100,

      child: Center(
        child: ElevatedButton(
          onPressed: lastSlide,
          child: Text("Getting Started"),
        ),
      ),
    )];
  }
}
