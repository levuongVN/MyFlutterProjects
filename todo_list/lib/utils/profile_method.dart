  import 'package:flutter/material.dart';

Container profileMethod() {
    return Container(
            margin: EdgeInsets.only(right: 10, bottom: 5),
            padding: EdgeInsets.all(3),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [Colors.purple, Colors.orange],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage("assets/images/Image1.jpg"),
            ),
          );
  }