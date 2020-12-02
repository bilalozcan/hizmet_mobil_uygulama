import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CarouselSlider extends StatefulWidget {
  List<String> _photoPaths;
  CarouselSlider({@required List<String> photoPaths})
  {
    this._photoPaths=photoPaths;
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
      _photosIndex =
          (_photosIndex == widget._photoPaths.length - 1 ? 0 : _photosIndex + 1);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget._photoPaths = [
      "assets/carouselPhotos/photo1.jpg",
      "assets/carouselPhotos/photo2.jpg",
      "assets/carouselPhotos/photo3.jpg",
    ];
    _photosIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
   return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(widget._photoPaths[_photosIndex]),
                          fit: BoxFit.cover),
                    ),
                    height:(MediaQuery.of(context).size.height)/2,
                  ),
                  /*Positioned(
                    top: ((MediaQuery.of(context).size.height)/2)-32,
                    child: Dots(
                        numberOfDots: widget._photoPaths.length,
                        selectedPhotoIndex: _photosIndex),
                    left: (MediaQuery.of(context).size.width / 2) - 32,
                  ),*/
                  /*Positioned(left:(MediaQuery.of(context).size.width)-128,child: IconButton(icon: Icon(Icons.close),onPressed:(){
                    Navigator.of(context).pop();
                  },),)*/
                ],
              ),
            ),
            Container(height:200,child: Column(mainAxisAlignment: MainAxisAlignment.center,children: [Text("Hizmet Uygulamasi",style: TextStyle(fontSize:24),)],),),

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
                  Dots(numberOfDots: widget._photoPaths.length,
                      selectedPhotoIndex: _photosIndex),
                  CupertinoButton(
                    child: Text(
                      "İleri",
                      style: TextStyle(color: Colors.green),
                    ),
                    onPressed: _nextImage,
                  ),

                ],
              ),
            )
          ],
        ),
      );
  }
}

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
