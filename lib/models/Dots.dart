import 'package:flutter/material.dart';

class Dots extends StatelessWidget {
  int numberOfDots;
  int selectedPhotoIndex;

  Dots({this.numberOfDots, this.selectedPhotoIndex});

  Widget _activeDot() {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(left: 3.0, right: 3.0),
        child: Container(
          height: 10.0,
          width: 10.0,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey, spreadRadius: 0.0, blurRadius: 2.0)
              ]),
        ),
      ),
    );
  }

  Widget _inactiveDot() {
    return new Container(
        child: new Padding(
          padding: const EdgeInsets.only(left: 3.0, right: 3.0),
          child: Container(
            height: 8.0,
            width: 8.0,
            decoration: BoxDecoration(
                color: Colors.grey, borderRadius: BorderRadius.circular(4.0)),
          ),
        ));
  }

  List<Widget> _buildDots() {
    List<Widget> dots = List<Widget>();
    for (int i = 0; i < numberOfDots; ++i) {
      dots.add(i == selectedPhotoIndex ? _activeDot() : _inactiveDot());
    }
    return dots;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _buildDots(),
    );
  }
}