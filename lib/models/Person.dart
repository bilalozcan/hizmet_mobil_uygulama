import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_star_rating/flutter_star_rating.dart';

class Person {
  @override
  String name;
  String surname;
  double derece;
  var icon;

  Person(this.name, this.surname, this.derece, this.icon);

  /*Widget kisiBilgisiContainer() {
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
                    )
                )
              ),
            ],
          ),
        ],
      ),
    );
  }*/

}
