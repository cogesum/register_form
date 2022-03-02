import 'package:flutter/material.dart';
import 'package:flutter_app7/model/model.dart';

class UserInfoPage extends StatelessWidget {
  User userInfo;
  UserInfoPage({Key? key, required this.userInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Info"),
        centerTitle: true,
      ),
      body: Card(
        margin: EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              title: Text(
                "${userInfo.name}",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              subtitle: Text("${userInfo.story}"),
              leading: Icon(
                Icons.person,
                color: Colors.black,
              ),
              trailing: Text("${userInfo.country}"),
            ),
            ListTile(
              title: Text(
                "${userInfo.phone}",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              leading: Icon(
                Icons.phone,
                color: Colors.black,
              ),
            ),
            ListTile(
              title: Text(
                "${userInfo.email!.isEmpty ? "" : userInfo.email}",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              leading: userInfo.email!.isEmpty
                  ? null
                  : Icon(
                      Icons.mail,
                      color: Colors.black,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
