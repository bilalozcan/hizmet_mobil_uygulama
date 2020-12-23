import 'package:flutter/material.dart';
import 'package:hizmet_mobil_uygulama/models/Hizmet.dart';
import 'package:hizmet_mobil_uygulama/viewmodel/user_model.dart';
import 'package:provider/provider.dart';
import 'package:date_format/date_format.dart';

class HizmetDetailPage extends StatefulWidget {
  Hizmet _hizmet;

  @override
  _HizmetDetailPageState createState() => _HizmetDetailPageState(_hizmet);

  HizmetDetailPage(this._hizmet);
}

class _HizmetDetailPageState extends State<HizmetDetailPage> {
  Hizmet _hizmet;

  _HizmetDetailPageState(this._hizmet);

  @override
  Widget build(BuildContext context) {
    UserModel _userModel = Provider.of<UserModel>(context);
    _userModel.differentUser(_hizmet.publisher);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _hizmet.category +
              " -> " +
              _hizmet.subCategory +
              " -> " +
              _hizmet.hizmet,
          style: TextStyle(fontSize: 16),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: Icon(Icons.chat_outlined, size: 32),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Consumer<UserModel>(
            builder: (context, userModel, child) {
              if (userModel.getDifferentUser != null) {
                return Card(
                  child: ListTile(
                    title: Text(userModel.getDifferentUser.name +
                        userModel.getDifferentUser.surname),
                    leading: CircleAvatar(
                      backgroundImage:
                          NetworkImage(userModel.getDifferentUser.profileURL),
                    ),
                  ),
                );
              } else {
                return CircularProgressIndicator(
                  backgroundColor: Colors.red,
                );
              }
            },
          ),
          SizedBox(
            height: 15,
          ),
          Center(
            child: Text(
              _hizmet.title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),

          Padding(
            padding: EdgeInsets.only(left: 15,top: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.date_range),
                SizedBox(width: 20,),
                Text(formatDate(_hizmet.publishedAt, [dd, '-', mm, '-', yyyy , '  ',HH, ':', nn,])),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 15,top: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.location_on_outlined),
                SizedBox(width: 20,),
                Text(_hizmet.address),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 15,top: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.visibility_outlined),
                SizedBox(width: 20,),
                Text(_hizmet.review.toString()),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 15,top: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.payment),
                SizedBox(width: 20,),
                Text(_hizmet.payment.toString() + " TL"),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 15,top: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.assignment_outlined),
                SizedBox(width: 20,),
                Text(_hizmet.detail),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
