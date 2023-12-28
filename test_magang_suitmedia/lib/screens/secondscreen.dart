import 'package:flutter/material.dart';
import 'package:test_magang_suitmedia/colors.dart';
import 'package:test_magang_suitmedia/screens/thirdscreen.dart';

class SecondScreen extends StatefulWidget {
  final String name;
  final String choosenName;

  const SecondScreen({Key? key, required this.name, required this.choosenName})
      : super(key: key);

  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Image.asset(
            'assets/ic_back.png',
            width: 48,
            height: 48,
            color: pickColors.icBack,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: pickColors.primary,
        title: Text(
          'Second Screen',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            fontSize: 18.0,
            color: pickColors.secondary,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 21),
        margin: EdgeInsets.only(top: 21),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome',
              style: TextStyle(
                fontFamily: 'Poppins', 
                fontWeight: FontWeight.w400, 
                fontSize: 12.0,
                color: pickColors.secondary,
              ),

            ),
            SizedBox(height: 4),
            Text(
              widget.name,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                fontSize: 18.0,
                color: pickColors.secondary,
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  widget.choosenName,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    fontSize: 24.0,
                    color: pickColors.secondary,
                  ),
                ),
              ),
            ),
            Container(
                  margin: EdgeInsets.only(top: 70.0, bottom: 35.0),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 29.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ThirdScreen(
                              name: widget.name,
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: pickColors.elevatedBtn,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        minimumSize: Size(double.infinity, 41.0)
                      ),
                      child: Text('Choose a User',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                  ),
                )
          ],
        ),
      ),
    );
  }
}
