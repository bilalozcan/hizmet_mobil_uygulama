import 'package:flutter/material.dart';
import 'models/CarouselSlider.dart';

class tutorialStepScreen extends StatefulWidget {
  @override
  _tutorialStepScreenState createState() => _tutorialStepScreenState();
}

class _tutorialStepScreenState extends State<tutorialStepScreen> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: CarouselSlider(photoPaths: [
        "assets/carouselPhotos/photo1.jpg",
        "assets/carouselPhotos/photo2.jpg",
        "assets/carouselPhotos/photo3.jpg"
      ]),
    );
  }
}
