import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_star_rating/flutter_star_rating.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hizmet_mobil_uygulama/main.dart';
import 'package:hizmet_mobil_uygulama/models/Person.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String name;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            actions: [IconButton(icon: Icon(Icons.settings), onPressed: (){},)],
            expandedHeight: MediaQuery.of(context).size.height / 4,
            floating: true,
            pinned: true,
            snap: false,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: FutureBuilder(future: getPersonData(),builder: (context,snapshot){
                if(name!=null)
                  {
                    return Padding(
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
                  }
                else
                  return CircularProgressIndicator();
              },),
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
              Pages(),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> Pages() {
    return [
      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //crossAxisAlignment: CrossAxisAlignment.end,
      kisiBilgisiContainer("Mehmet","Arsay",4.0,Icons.account_circle),
      SizedBox(
        height: 300,
      ),
      kisiBilgisiContainer("Fatih Dursun","Üzer",3.0,Icons.person),
      SizedBox(
        height: 300,
      ),
      kisiBilgisiContainer("Bilal","Özcan",5.0,Icons.account_circle),
      SizedBox(
        height: 300,
      ),
    ];
  }
  Widget kisiBilgisiContainer(String name,String surname,double derece,var icon) {
    return Container(
      child:
          Row(
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
                          )
                      )
                  ),
                ],
              ),
            ],
          ),
    );
  }
  getPersonData() /*Farklı bir klasörde olabilir */
  {
    collection.doc("${firebaseAuth.currentUser.email}").get().then((value) {
      setState(() {
        name=value.data()["name"];
      });
    });
  }
}

