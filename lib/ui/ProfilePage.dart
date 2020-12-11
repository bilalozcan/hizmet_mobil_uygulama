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
      appBar: AppBar(
        actions: [
          Container(
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

              ],
            ),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Colors.green,
            toolbarHeight: MediaQuery.of(context).size.height/3,
            automaticallyImplyLeading: false,
            actions: [
                 Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.black12,
                      ),
                    ),
                  ],
                ),
            ],
            floating: true,
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
