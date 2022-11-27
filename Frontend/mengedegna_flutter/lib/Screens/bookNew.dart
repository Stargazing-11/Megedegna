// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last, unnecessary_brace_in_string_interps, prefer_final_fields
import 'package:flutter/material.dart';
import 'package:mengedegna_flutter/Screens/bookInformation.dart';

import 'Common/common.dart';

class BookNew extends StatefulWidget {
  const BookNew({super.key});

  @override
  State<BookNew> createState() => _BookNewState();
}

class _BookNewState extends State<BookNew> {
  DateTime _dateTime = DateTime(2019);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              width: 250,
              child: Text(
                'Book a New Trip',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            field('Start City'),
            field('Destination'),
            Column(
              children: [
                Text('Pick A Date:',
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 15,
                    )),
                SizedBox(
                  height: 4,
                ),
                MaterialButton(
                  color: Color.fromARGB(255, 52, 153, 131),
                  onPressed: () {
                    showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2021),
                            lastDate: DateTime(DateTime.now().year + 2))
                        .then((value) => {
                              setState(() {
                                _dateTime = value!;
                              })
                            });
                  },
                  child: Container(
                    width: 170,
                    padding: EdgeInsets.symmetric(horizontal: 3, vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _dateTime == DateTime(2019)
                              ? " "
                              : '${_dateTime.day.toString()}/${_dateTime.month.toString()}/${_dateTime.year.toString()}',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              decoration: TextDecoration.underline,
                              decorationThickness: 5),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(Icons.date_range),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            ElevatedButton(onPressed: () {}, child: Text('Next')),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.white,
        backgroundColor: Color.fromARGB(78, 0, 0, 0),
        elevation: 2.0,
        currentIndex: 2,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.list_alt_rounded,
              ),
              label: 'Booked Trips'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.create_rounded,
              ),
              label: 'Book New'),
        ],
      ),
    );
  }
}
