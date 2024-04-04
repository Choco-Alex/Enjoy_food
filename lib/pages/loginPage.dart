import 'package:enjoy_food/components/my_button.dart';
import 'package:enjoy_food/components/my_textfield.dart';
import 'package:enjoy_food/pages/homePage.dart';
import 'package:enjoy_food/services/auth/auth_service.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;

  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  // login method
  void login() async {
    // get instance of auth service
    final _authService = AuthService();

    // try sign in
    try{
      await _authService.signInWithEmailPassword(emailController.text, passwordController.text);
    }

    // display any errors
    catch(e){
        showDialog(
        context: context,
        builder: (context) => AlertDialog(
             
              title: Text(e.toString()),
            ));
    }
  }

  // forgot password
  void forgotPw(){
     
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // logo
                Icon(
                  Icons.lock_open_rounded,
                  size: 100,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
          
                const SizedBox(
                  height: 25,
                ),
          
                //message app slogan
                Text(
                  "Food Delivery App",
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                // email textfield
          
                MyTextField(
                    controller: emailController,
                    hintText: "Email",
                    obscureText: false),
                const SizedBox(
                  height: 10,
                ),
                MyTextField(
                    controller: passwordController,
                    hintText: "Password",
                    obscureText: true),
                const SizedBox(
                  height: 10,
                ),
                // sign in button
                MyButton(
                  text: "Sign In",
                  onTap: () {
                    login();
                  },
                ),
                const SizedBox(
                  height: 25,
                ),
                // not a member ? register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Not a member ?",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        "Register now ?",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
