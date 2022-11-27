// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last, unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';
import 'package:mengedegna_flutter/Screens/booked.dart';

import 'Common/common.dart';

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Mengedegna',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            CircleAvatar(
              backgroundImage: AssetImage(
                'assets/images/Logo.jpeg',
              ),
              radius: 70,
            ),
            Container(
              padding: EdgeInsets.all(10),
              width: 200,
              child: Text(
                'Sign Up',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            field('First Name'),
            field('Last Name'),
            field('Phone'),
            field('Password'),
            button('Sign up', null, context, Booked()),
            TextButton(
                onPressed: () {}, child: Text('Already have an Account? Login'))
          ],
        ),
      ),
    );
  }
}
