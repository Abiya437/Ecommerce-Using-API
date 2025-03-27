import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarouselSliderWidget extends StatelessWidget {
  final List<String> imageUrls;

  const CarouselSliderWidget({super.key, required this.imageUrls});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 180.0,
        autoPlay: true,
        enlargeCenterPage: true,
        aspectRatio: 16 / 9,
      ),
      items: imageUrls.map((url) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(15.0),
          child: Image.asset(
            url,
            fit: BoxFit.cover,
            width: double.infinity,
          ),
        );
      }).toList(),
    );
  }
}
