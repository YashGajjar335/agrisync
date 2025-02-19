import 'package:agrisync/admin/screen/add_product_form_page.dart';
import 'package:agrisync/admin/screen/admin_login_screen.dart';
import 'package:agrisync/admin/screen/view_users_list.dart';
import 'package:agrisync/admin/service/admin_login_service.dart';
import 'package:flutter/material.dart';

class AdminMainScreen extends StatefulWidget {
  const AdminMainScreen({super.key});

  @override
  State<AdminMainScreen> createState() => _AdminMainScreenState();
}

class _AdminMainScreenState extends State<AdminMainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // logoutButton
          Center(
            child: TextButton(
              onPressed: () async {
                await AdminLoginService.instance.logOut();
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const AdminLoginScreen()));
              },
              child: const Text("LogOut"),
            ),
          ),
          // userScreen
          Center(
            child: TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const ViewUsersList()));
              },
              child: const Text("viewUser"),
            ),
          ),

          // add ProductButton
          Center(
            child: TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const AddProductFormPage()));
              },
              child: const Text("viewUser"),
            ),
          ),
        ],
      ),
    );
  }
}
