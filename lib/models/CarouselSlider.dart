import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hizmet_mobil_uygulama/ui/HomePage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Dots.dart';

class CarouselSlider extends StatefulWidget {
  //String _email;
  List<String> _photoPaths;

  CarouselSlider({@required List<String> photoPaths}) {
    this._photoPaths = photoPaths;
    //this._email = email;
  }

  @override
  _CarouselSliderState createState() => _CarouselSliderState();
}

class _CarouselSliderState extends State<CarouselSlider> {
  int _photosIndex;

  void _prevImage() {
    setState(() {
      _photosIndex =
          (_photosIndex > 0 ? _photosIndex - 1 : widget._photoPaths.length - 1);
    });
  }

  void _nextImage() {
    setState(() {
      if (_photosIndex == widget._photoPaths.length - 1) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      } else {
        _photosIndex++;
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _photosIndex = 0;
    firstSignInWithEmail();
  }

  firstSignInWithEmail() async {
    SharedPreferences value = await SharedPreferences.getInstance();
    setState(() {
      value.setInt("login", 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/carouselPhotos/photo1.jpg"),
              fit: BoxFit.fill),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              color: Colors.blue[900],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  CupertinoButton(
                    child: Text(
                      "Geri",
                      style: TextStyle(color: Colors.green),
                    ),
                    onPressed: _prevImage,
                  ),
                  Dots(
                      numberOfDots: widget._photoPaths.length,
                      selectedPhotoIndex: _photosIndex),
                  CupertinoButton(
                    child: Text(
                      _photosIndex == widget._photoPaths.length - 1
                          ? "BAŞLAYALIM"
                          : "İLERİ",
                      style: TextStyle(color: Colors.green),
                    ),
                    onPressed: _nextImage,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
