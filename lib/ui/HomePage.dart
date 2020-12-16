
import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hizmet_mobil_uygulama/models/Category.dart';
import 'package:hizmet_mobil_uygulama/ui/HizmetVerPage.dart';

import 'ProfilePage.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentNavigationBarIndex;
  Category _category;
  String _value;
  bool _pressed;

  @override
  void initState() {
    super.initState();
    _currentNavigationBarIndex = 0;
    _pressed = false;
    connectJson();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        exit(0);
      },
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          onTap: (currentIndex) {
            setState(() {
              _currentNavigationBarIndex = currentIndex;
            });
            if (_currentNavigationBarIndex == 1)
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HizmetVerPage(_category)));
          },
          currentIndex: _currentNavigationBarIndex,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined), label: "Anasayfa"),
            BottomNavigationBarItem(
                icon: Icon(Icons.add_box_outlined, size: 40),
                label: "Hizmet Ver"),
            BottomNavigationBarItem(
                icon: Icon(Icons.check_box_outlined, size: 40),
                label: "Hizmetlerim"),
            BottomNavigationBarItem(
                icon: Icon(Icons.chat_outlined), label: "Sohbet")
          ],
        ),
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              automaticallyImplyLeading: false,
              actions: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(Icons.account_circle),
                        iconSize: 35,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProfilePage()));
                        },
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 1.2,
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            prefixIcon: IconButton(
                              icon: Icon(
                                Icons.search,
                                color: Colors.black,
                              ),
                              onPressed: () {
                                setState(() {
                                  _pressed = true;
                                });
                              },
                            ),
                            hintText: "Hizmet Ara",
                          ),
                          onChanged: (value) {
                            setState(() {
                              _value = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              floating: true,
            ),
            SliverList(
              delegate: SliverChildListDelegate(Search("asd")),
            ),
          ],
        ),
      ),
    );
  }

  void connectJson() {
    DefaultAssetBundle.of(context)
        .loadString("assets/Category.json")
        .then((gelenJson) {
      LinkedHashMap<String, dynamic> map = json.decode(gelenJson.toString());
      _category = Category.fromJson(map);
    }).catchError((onError) => print(onError));
  }

  List<Widget> Search(String value) {
    if (value != null || value != "")
      return List.filled(50, Text(value));
    else
      return Pages();
  }

  List<Widget> Pages() {
    return [
      Text(
        "İlanlar Sayfası",
        style: TextStyle(fontSize: 25, color: Colors.black),
      ),
      Text(
        "İlanlar Sayfası",
        style: TextStyle(fontSize: 25, color: Colors.black),
      ),
      SizedBox(
        height: 300,
      ),
      SizedBox(
        height: 300,
      ),
      Text(
        "İlanlar Sayfası",
        style: TextStyle(fontSize: 25, color: Colors.black),
      ),
      SizedBox(
        height: 300,
      ),
      Text(
        "İlanlar Sayfası",
        style: TextStyle(fontSize: 25, color: Colors.black),
      ),
      SizedBox(
        height: 30,
      ),
      Text(
        "İlanlar Sayfası",
        style: TextStyle(fontSize: 25, color: Colors.black),
      ),
    ];
  }
/*Dialog(child: CarouselSlider(photoPaths:["assets/carouselPhotos/photo1.jpg","assets/carouselPhotos/photo2.jpg","assets/carouselPhotos/photo3.jpg"]),),*/
}
