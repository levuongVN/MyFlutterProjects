import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  Login({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Login',
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
        backgroundColor: const Color.fromRGBO(42, 123, 155, 1),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromRGBO(42, 123, 155, 1), // #2A7B9B
              Color.fromRGBO(87, 199, 133, 1), // #57C785
            ],
          ),
        ),
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: Container(
            width: 400,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                spacing: 20,
                children: [
                  // Email
                  TextFormField(
                    decoration: const InputDecoration(
                      label: Text('Enter email'),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your Email!';
                      }
                      return null;
                    },
                  ),
                  // Password
                  TextFormField(
                    obscureText: true,
                    decoration: const InputDecoration(
                      label: Text('Enter Password'),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password!';
                      }
                      return null;
                    },
                  ),
                  // Login button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                        }
                      },
                      child: const Text('Enter'),
                    ),
                  ),

                  // Divider with "OR"
                  Row(
                    children: const [
                      Expanded(child: Divider(thickness: 1)),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Text("OR"),
                      ),
                      Expanded(child: Divider(thickness: 1)),
                    ],
                  ),

                  // Login with Apple
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      icon: const Icon(Icons.apple, color: Colors.black),
                      label: const Text("Login with Apple"),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
