import 'package:flutter/material.dart';
import 'package:test_magang_suitmedia/screens/secondscreen.dart';
import 'package:test_magang_suitmedia/colors.dart';

class FirstScreen extends StatefulWidget {

  const FirstScreen({super.key});

  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _sentenceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Image.asset(
            'assets/bg.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 60),
                    child: Image.asset('assets/ic_photo.png'),
                  ),
                ),
                Center(
                  child: Column(
                    children: [
                      Container(
                        height: 39.88,
                        padding: EdgeInsets.symmetric(horizontal: 32.0),
                        child: TextField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            hintText: 'Name',
                            hintStyle: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              color: pickColors.hintText.withOpacity(0.36),
                            ),
                            fillColor: pickColors.primary,
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: BorderSide(
                                width: 0.5,
                              ),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 16.0,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 39.88,
                        margin: EdgeInsets.only(top: 20),
                        padding: EdgeInsets.symmetric(horizontal: 32.0),
                        child: TextField(
                          controller: _sentenceController,
                          decoration: InputDecoration(
                            hintText: 'Palindrome',
                            hintStyle: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              fontSize: 16.0,
                              color: pickColors.hintText.withOpacity(0.36),
                            ),
                            fillColor: pickColors.primary,
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: BorderSide(
                                width: 0.5,
                              ),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 16.0,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 40.0),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 32.0),
                          child: ElevatedButton(
                            onPressed: () {
                              bool isPalindrome =
                                  palindromeCheck(_sentenceController.text);
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("palindromeCheck"),
                                    content: Text('${isPalindrome ? 'is' : 'not'}Palindrome'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('OK'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              primary: pickColors.elevatedBtn,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              minimumSize: Size(double.infinity, 41.0),
                            ),
                            child: Text('CHECK',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                                fontSize: 14.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10.0),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 32.0),
                          child: ElevatedButton(
                            onPressed: () {
                              String name = _nameController.text;
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SecondScreen(
                                    name: name,
                                    choosenName: '',
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
                            child: Text('NEXT',
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
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

bool palindromeCheck(String sentence) {
  String cleanedSentence = sentence.replaceAll(' ', '').toLowerCase();
  String reversedSentence = cleanedSentence.split('').reversed.join('');
  return cleanedSentence == reversedSentence && cleanedSentence.length > 1;
}
