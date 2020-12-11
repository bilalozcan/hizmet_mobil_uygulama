import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
              title: Padding(
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
                              "İsim Soyisim",
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
              ),
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
}
