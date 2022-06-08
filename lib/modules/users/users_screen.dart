import 'package:flutter/material.dart';
import 'package:test_app/models/user/user_model.dart';

class UsersScreen extends StatelessWidget {
  final List<UserModel> users = [
    //List<Object>
    UserModel(id: 1, name: 'Hozan', phone: '07826030525'),
    UserModel(id: 2, name: 'Ali', phone: '07721234567'),
    UserModel(id: 3, name: 'Osama', phone: '07502589654'),
    UserModel(id: 1, name: 'Hozan', phone: '07826030525'),
    UserModel(id: 2, name: 'Ali', phone: '07721234567'),
    UserModel(id: 3, name: 'Osama', phone: '07502589654'),
    UserModel(id: 1, name: 'Hozan', phone: '07826030525'),
    UserModel(id: 2, name: 'Ali', phone: '07721234567'),
    UserModel(id: 3, name: 'Osama', phone: '07502589654'),
    UserModel(id: 1, name: 'Hozan', phone: '07826030525'),
    UserModel(id: 2, name: 'Ali', phone: '07721234567'),
    UserModel(id: 3, name: 'Osama', phone: '07502589654'),
  ];

  Widget buildUserItem(UserModel user) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 25.0,
              child: Text(
                '${user.id}',
                style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(width: 20.0),
            Column(
              mainAxisSize:
                  MainAxisSize.min, //it will fit according to the content
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.name,
                  style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                ),
                Text(
                  user.phone,
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users'),
      ),
      body: ListView.separated(
          itemBuilder: (context, index) => buildUserItem(users[index]),
          separatorBuilder: (context, index) => Padding(
                padding: const EdgeInsetsDirectional.only(start: 20.0),
                child: Container(
                  width: double.infinity,
                  height: 1.0,
                  color: Colors.grey[300],
                ),
              ),
          itemCount: users.length),
    );
  }
}
