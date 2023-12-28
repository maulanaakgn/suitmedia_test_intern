import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:test_magang_suitmedia/colors.dart';
import 'package:test_magang_suitmedia/screens/secondscreen.dart';

class ThirdScreen extends StatefulWidget {
  final String name;
  
  const ThirdScreen({Key? key, required this.name}) : super(key: key);

  @override
  _ThirdScreenState createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  List<User> _listUsers = [];
  late String name;

  int page = 1;
  int perPage = 10;

  @override
  void initState() {
    super.initState();
    getListUser();
    name = widget.name;
  }

  Future<void> getListUser() async {
    final uri = Uri.parse('https://reqres.in/api/users')
        .replace(queryParameters: {'page': '$page', 'per_page': '$perPage'});

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> usersData = data['data'];

      setState(() {
        _listUsers.addAll(usersData.map((user) => User.fromJson(user)).toList());
        page++;
      });
    }
  }

  Future<void> refreshUsers() async {
    setState(() {
      _listUsers.clear();
      page = 1;
    });
    await getListUser();
  }

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
          'Third Screen',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            fontSize: 18.0,
            color: pickColors.secondary,
          ),
        ),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: refreshUsers,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              if (scrollInfo is ScrollEndNotification &&
                  scrollInfo.metrics.extentAfter == 0) {
                getListUser();
              }
              return false;
            },
            child: ListView.builder(
              itemCount: _listUsers.length + 1,
              itemBuilder: (context, index) {
                if (index < _listUsers.length) {
                  return Container(
                    height: 80.0,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Color(0xFFE2E3E4),
                          width: 0.5,
                        ),
                      ),
                    ),
                    child: ListTile(
                      title: Text('${_listUsers[index].firstName} ${_listUsers[index].lastName}'),
                      subtitle: Text(_listUsers[index].email),
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(_listUsers[index].avatar),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SecondScreen(
                              name: name,
                              choosenName: _listUsers[index].firstName + _listUsers[index].lastName,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                } else if (index == _listUsers.length) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

class User {
  final int id;
  final String email;
  final String firstName;
  final String lastName;
  final String avatar;

  User({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.avatar,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      avatar: json['avatar'],
    );
  }
}