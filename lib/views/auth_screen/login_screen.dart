import 'package:flutter/material.dart';
import 'package:shakti_contact/bottom_bar.dart';
class LoginScreen extends StatefulWidget {
  final VoidCallback onToggleTheme;
  final bool isDarkMode;

  LoginScreen({required this.onToggleTheme, required this.isDarkMode});
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF003f88), // Blue background
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 40),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'v4.0.6_Live',
                  style: TextStyle(color: Colors.greenAccent, fontSize: 12),
                ),
              ),
              Spacer(),
              Column(
                children: [
                  // Logo and title
                  Image.asset('assets/images/Shakti_log.png', height: 80), // Replace with your logo asset
                  SizedBox(height: 10),
                  Text(
                    'SHAKTI',
                    style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'নারীর ক্ষমতায়নে শক্তি',
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                ],
              ),
              SizedBox(height: 40),

              // Username Field
              TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'ই.আই.এন',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                ),
              ),
              SizedBox(height: 15),

              // Password Field
              TextField(
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'পাসওয়ার্ড',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Login Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: ()  {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BottomBar(
                          onToggleTheme: widget.onToggleTheme,
                          isDarkMode: widget.isDarkMode,
                        ),
                      ),
                    );
                  },
                  child: Text('লগ ইন'),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                    foregroundColor: MaterialStateProperty.all<Color>(Color(0xFF003f88)),
                    textStyle: MaterialStateProperty.all<TextStyle>(
                      TextStyle(fontSize: 18),
                    ),
                    padding: MaterialStateProperty.all<EdgeInsets>(
                      EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15),

              // Forgot Password
              GestureDetector(
                onTap: () {},
                child: Text(
                  'পাসওয়ার্ড ভুলে গেছি?',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
              Spacer(),
              Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  'v4.0.6_Live',
                  style: TextStyle(color: Colors.greenAccent, fontSize: 12),
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}