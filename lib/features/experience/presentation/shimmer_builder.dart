import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerBuilder extends StatelessWidget {
  final double width;
  final double height;
  final BorderRadius borderRadius;

  const ShimmerBuilder({
    Key? key,
    required this.width,
    required this.height,
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: borderRadius,
        ),
      ),
    );
  }
}
