import 'package:enjoy_food/components/my_button.dart';
import 'package:enjoy_food/components/my_textfield.dart';
import 'package:enjoy_food/services/auth/auth_service.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;

  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  // registre method
  void register() async {
    // get auth service
    final _authService = AuthService();
    // check if password match -> create user
    if (passwordController.text == confirmPasswordController.text) {
      try {
        await _authService.signIUpWithEmailPassword(
            emailController.text, passwordController.text);
      }

      // display any errors
      catch (e) {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text(e.toString()),
                ));
      }
    }
    // if password don't match -> show error
    else {
      showDialog(
          context: context,
          builder: (context) => const AlertDialog(
                title: Text("Passwords don't match !"),
              ));
    }
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
                  "Let's create an account for you",
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
                MyTextField(
                    controller: confirmPasswordController,
                    hintText: "Confirm Password",
                    obscureText: true),
                const SizedBox(
                  height: 10,
                ),
                // sign up button
                MyButton(
                  text: "Sign Up",
                  onTap: () {
                    register();
                  },
                ),
                const SizedBox(
                  height: 25,
                ),
                // already have an account login here
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "already have an account login here ?",
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
                        "Login here",
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
