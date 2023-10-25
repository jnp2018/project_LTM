import 'package:flutter/material.dart';
import 'package:frontend/screen/admin/add_music.dart';
import 'package:frontend/screen/admin/delete_music.dart';

class AdminScreen extends StatefulWidget {
  static String id = "admin_screen";
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("admin"),
        centerTitle: true,
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return DeleteMusic();
                    });
              },
              child: Container(
                child: const Center(child: Text('Xóa Music')),
                height: 50,
                width: 150,
                color: Colors.red,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AddMusic();
                    });
              },
              child: Container(
                child: Center(child: Text('Thêm Music')),
                height: 50,
                width: 150,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
