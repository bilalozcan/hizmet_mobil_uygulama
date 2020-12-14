import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_star_rating/flutter_star_rating.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hizmet_mobil_uygulama/mainFdu.dart';
import 'package:hizmet_mobil_uygulama/models/Person.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String name;
  List<Widget> kisiBilgileri;
  LinkedHashMap<String, dynamic> comments;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    kisiBilgileri = List<Widget>();
    comments = LinkedHashMap<String, dynamic>();
    getPersonData(firebaseAuth.currentUser.uid.toString());
    deneme();
    Pages();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //getPersonData(firebaseAuth.currentUser.uid.toString());
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
              title: FutureBuilder(
                //future: getPersonData(firebaseAuth.currentUser.uid.toString()),
                builder: (context, snapshot) {
                  if (name != null) {
                    return Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.height / 12,
                          top: MediaQuery.of(context).size.height / 25),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Icon(Icons.account_circle_outlined, size: 54),
                          SizedBox(
                            width: 25,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                name,
                                style: TextStyle(fontSize: 12),
                              ),
                              Text(
                                "DERECE",
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  } else
                    return CircularProgressIndicator(
                      backgroundColor: Colors.red,
                    );
                },
              ),
              /*Padding(
                padding: EdgeInsets.only(left: MediaQuery.of(context).size.height / 12, top: MediaQuery.of(context).size.height / 25),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Icon(Icons.account_circle_outlined, size: 54),
                      SizedBox(width: 25,),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              deneme(),
                              style: TextStyle(fontSize: 12),
                            ),
                            Text(
                              "DERECE",
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                    ],
                  ),
              ),*/
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              kisiBilgileri,
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> Pages() {
    debugPrint("Pages cagırıldı");
    debugPrint(comments.length.toString());
    //var name;
    comments.forEach((key, value) async {
      debugPrint(key);
      //name =await getPersonData(key);
      debugPrint("İsim"+key);
        kisiBilgileri.add(kisiBilgisiContainer(
            await getPersonData(key), "xxxx", 4.0, Icons.account_circle));
    });
    //debugPrint("kisiBilgileri"+kisiBilgileri.length.toString());
    setState(() {
      debugPrint(kisiBilgileri.length.toString());
    });
  }

  Widget kisiBilgisiContainer(
      String name, String surname, double derece, var icon) {
    return FutureBuilder(
      builder: (context, snapshot) {
        if (name != null) {
          return Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Icon(icon, size: 30),
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
                            ))),
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

  getPersonData(String uid) async /*Farklı bir klasörde olabilir */
  {
    var my = await collection.doc("${firebaseAuth.currentUser.uid}").get();
    String personData = my.data()["name"];
    if (uid == firebaseAuth.currentUser.uid.toString()) {
      name = personData;
    }
    return personData;
    /*setState(() {
      kisiBilgileri.add(kisiBilgisiContainer(
          personData, "xxxx", 4.0, Icons.account_circle));
    });*/
  }

  deneme() async {
    var commentCollection = firebaseFirestore.collection("Comments");
    var commentDocs =
        commentCollection.doc(firebaseAuth.currentUser.uid.toString()).get();
    var a = await commentDocs;
    debugPrint("runtype a " + a.data().runtimeType.toString());
    debugPrint("runtype comments " + comments.runtimeType.toString());
    setState(() {
      comments = a.data();
    });
  }
}
