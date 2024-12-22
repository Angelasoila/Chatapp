import 'package:flutter/material.dart';
import 'package:flutter_application_4/pages/login.dart';
import 'package:flutter_application_4/pages/register_page.dart';


class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
//initially shown login
  bool showLoginPage = true;

  //toggle between the register and login page
  void togglePage() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage){
      return Login(
        onTap: togglePage,
      );
    } else{
      return RegisterPage(
        onTap: togglePage,
      );
    }
  }
}
