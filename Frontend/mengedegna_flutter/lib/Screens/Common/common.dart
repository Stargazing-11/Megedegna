// ignore_for_file: prefer_const_constructors, unnecessary_brace_in_string_interps, prefer_if_null_operators, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:mengedegna_flutter/Screens/register.dart';

Widget field(name) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        '${name}:',
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
      Container(
          width: 180,
          height: 30,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(100),
              border: Border.all(width: 2, color: Colors.black)),
          margin: EdgeInsets.all(5),
          child: TextField(
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    gapPadding: 2, borderRadius: BorderRadius.circular(100)),
              ),
              onChanged: (name) {})),
    ],
  );
}

Widget button(lable, icon, context, page) {
  return Container(
    padding: EdgeInsets.fromLTRB(0, 5, 0, 10),
    margin: EdgeInsets.only(bottom: 20),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(100)),
    child: ElevatedButton(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => page,
          ),
        );
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            lable,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ), // <-- Text
          SizedBox(
            width: 5,
          ),
          icon != null
              ? icon
              : SizedBox(
                  width: 0,
                ),
        ],
      ),
    ),
  );
}
