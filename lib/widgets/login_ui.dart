import 'package:flutter/material.dart';

class LoginUi extends StatelessWidget {
  const LoginUi({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 250),
      child: Center(
        child: Column(
          children: [
            Text(
              'Welcome to DefaultX',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 50),
            SizedBox(
              width: 350,

              child: TextField(
                decoration: InputDecoration(
                  labelText: "Username",
                  hintText: 'Enter your Username',
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 24,
                    horizontal: 16,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.purple, width: 1.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(color: Colors.purple, width: 1.0),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              width: 350,
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Password",
                  hintText: 'Enter your Password',
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 24,
                    horizontal: 16,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.purple, width: 1.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(color: Colors.purple, width: 1.0),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 220, 214, 214),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 140,
                    vertical: 24,
                  ),
                ),
                child: const Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Text('Forgot Password?'),
          ],
        ),
      ),
    );
  }
}
