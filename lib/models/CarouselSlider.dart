import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hizmet_mobil_uygulama/ui/MainPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Dots.dart';

class CarouselSlider extends StatefulWidget {
  String _email;
  List<String> _photoPaths;
  CarouselSlider({@required List<String> photoPaths,@required String email})
  {
    this._photoPaths=photoPaths;
    this._email=email;
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
      if(_photosIndex==widget._photoPaths.length-1) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MainPage()));
      }
      else {
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

  firstSignInWithEmail ()async
  {
    SharedPreferences value=await SharedPreferences.getInstance();
    setState(() {
      value.setInt("${widget._email}",1);
    });

  }

  @override
  Widget build(BuildContext context) {
   return Material(
     child: Container(
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
                      height:((MediaQuery.of(context).size.height)/2)-11,
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
              Container(height:300,child: Column(mainAxisAlignment: MainAxisAlignment.center,children: [Text("Hizmet Uygulamasi",style: TextStyle(fontSize:24),)],),),

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
                        _photosIndex==widget._photoPaths.length-1?"BAŞLAYALIM":"İLERİ",
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

