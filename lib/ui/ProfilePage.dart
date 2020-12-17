import 'dart:collection';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_star_rating/flutter_star_rating.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hizmet_mobil_uygulama/utils/ToastMessage.dart';
import 'package:hizmet_mobil_uygulama/viewmodel/user_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String name, surname, email;
  int degree;
  DateTime datetime;
  String _profilePhoto;
  PickedFile _profilFoto;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    UserModel _userModel = Provider.of<UserModel>(context);
    name = _userModel.user.name;
    surname = _userModel.user.surname;
    email = _userModel.user.email;
    degree = _userModel.user.degree;
    datetime = _userModel.user.dateOfBirth;
    _profilePhoto =_userModel.user.profileURL;
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            actions: [
              IconButton(
                icon: Icon(Icons.settings),
                onPressed: () {},
              )
            ],
            expandedHeight: MediaQuery.of(context).size.height / 4,
            floating: true,
            pinned: true,
            snap: false,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.height / 12,
                    top: MediaQuery.of(context).size.height / 25),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      child: InkWell(
                        onLongPress: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return Container(
                                  height: 160,
                                  child: Column(
                                    children: [
                                      ListTile(
                                        leading:
                                            Icon(Icons.camera_alt_outlined),
                                        title: Text("Kameradan Çek"),
                                        onTap: () {
                                          _kameradanFotoCek(context);
                                        },
                                      ),
                                      ListTile(
                                        leading: Icon(Icons.image_outlined),
                                        title: Text("Galeriden Seç"),
                                        onTap: () {
                                          _galeridenResimSec(context);
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              });
                        },
                        child: CircleAvatar(
                          radius: 75,
                          backgroundColor: Colors.white,
                          backgroundImage: _profilFoto == null
                              ? NetworkImage(_userModel.user.profileURL)
                              : FileImage(File(_profilFoto.path)),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          name + " " + surname,
                          style: TextStyle(fontSize: 12),
                        ),
                        Center(
                          child: StarRating(
                            rating: degree.toDouble(),
                            spaceBetween: 5.0,
                            starConfig: StarConfig(
                              fillColor: Colors.deepOrange,
                              size: 10,
                              // other props
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              Pages(),
            ),
          )
        ],
      ),
    );

  }

  Widget kisiBilgisiContainer(
      String name, String surname, double derece, String profilePhoto) {
    return FutureBuilder(
      builder: (context, snapshot) {
        if (name != null) {
          return Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  height: 25,
                  width: 25,
                  child: CircleAvatar(
                    radius: 75,
                    backgroundColor: Colors.white,
                    backgroundImage: _profilFoto == null
                    ? NetworkImage(_profilePhoto)
                    : FileImage(File(_profilFoto.path)),
                  ),
                ),
                SizedBox(
                  width: 25,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      name + " " + surname,
                      style: TextStyle(fontSize: 12),
                    ),
                    Center(
                      child: StarRating(
                        rating: derece,
                        spaceBetween: 5.0,
                        starConfig: StarConfig(
                          fillColor: Colors.deepOrange,
                          size: 10,
                          // other props
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        } else
          return CircularProgressIndicator(
            backgroundColor: Colors.black,
          );
      },
    );
  }

  List<Widget> Pages() {
    return [
      kisiBilgisiContainer(name, surname, degree.toDouble(), _profilePhoto),
      Text(
        "İlanlar Sayfası",
        style: TextStyle(fontSize: 25, color: Colors.black),
      ),
      kisiBilgisiContainer(name, surname, degree.toDouble(), _profilePhoto),
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
      kisiBilgisiContainer(name, surname, degree.toDouble(), _profilePhoto),
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

  void _kameradanFotoCek(BuildContext context) async {
    var _yeniResim =
        await ImagePicker.platform.pickImage(source: ImageSource.camera);

    setState(() {
      _profilFoto = _yeniResim;
      _profilFotoGuncelle(context);
      Navigator.of(context).pop();
    });
  }

  void _galeridenResimSec(BuildContext context) async {
    var _yeniResim =
        await ImagePicker.platform.pickImage(source: ImageSource.gallery);

    setState(() {
      _profilFoto = _yeniResim;
      _profilFotoGuncelle(context);
      Navigator.of(context).pop();
    });
  }

  void _profilFotoGuncelle(BuildContext context) async {
    final _userModel = Provider.of<UserModel>(context, listen: false);
    if (_profilFoto  != null) {
      var url = await _userModel.uploadFile(
          _userModel.user.userID, "profil_foto", File(_profilFoto.path));

      if (url != null) {
        _profilePhoto = url;
        _userModel.user.profileURL = url;
        /*showToast(
            context, "Profil fotoğrafınız başarıyla güncellendi", Colors.green);*/
      }
    }
  }
}
