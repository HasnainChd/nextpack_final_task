import 'package:flutter/material.dart';
import 'package:next_final_task/Components/text_component.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple.shade400,
        actions: [
          TextComponent(
              text: 'User Profile', fontSize: 20, color: Colors.white),
          SizedBox(width: 100),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.logout,
                color: Colors.white,
              ))
        ],
      ),
      body: Column(
        spacing: 20,
        children: [
          InkWell(
            onTap: () {},
            child: CircleAvatar(
                radius: 70,
                backgroundColor: Colors.deepPurple.shade200,
                child: Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                )),
          ),
          Column(
            children: [
              Card(
                color: Colors.deepPurple.shade200,
                child: ListTile(
                  title: TextComponent(
                      text: 'Name', fontSize: 25, color: Colors.black),
                  trailing:
                      IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
                ),
              ),
              Card(
                color: Colors.deepPurple.shade200,
                child: ListTile(
                    title: TextComponent(
                        text: 'Email', fontSize: 20, color: Colors.black)),
              )
            ],
          )
        ],
      ),
    );
  }
}
