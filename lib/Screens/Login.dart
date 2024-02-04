import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:machine_test/Screens/register.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart';


class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}
class _LoginState extends State<Login> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  Future<void> loginUser(String username, String password) async {
    setState(() {
      isLoading = true;
    });

    await Future.delayed(Duration(seconds: 5));

    setState(() {
      isLoading = false;
    });

    final response = await post(
      Uri.parse('https://flutter-amr.noviindus.in/api/Login'),
      body: {'username': username, 'password': password},
    );

    print(response.statusCode);

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final String token = responseData['token'];

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', token);
      print(token);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login successful!'),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          return Register();
        }),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login failed!'),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red,
        ),
      );

      throw Exception('Failed to log in');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/bg.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: SizedBox(
                  width: 100,
                  height: 100,
                  child: Image.asset('assets/Splash.png'),
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(26.0),
                      child: Text(
                        'Login Or Register To Book Your Appointments',
                        style: GoogleFonts.poppins(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 26,
                            right: 26,
                            bottom: 15,
                            top: 15,
                          ),
                          child: Text(
                            'Email',
                            style: GoogleFonts.poppins(fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 24, right: 26),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 243, 241, 241),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Color.fromARGB(255, 227, 226, 226),
                          ),
                        ),
                        child: TextFormField(
                          controller: usernameController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 26,
                            right: 26,
                            bottom: 15,
                            top: 15,
                          ),
                          child: Text(
                            'Password',
                            style: GoogleFonts.poppins(fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 24, right: 26),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 243, 241, 241),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Color.fromARGB(255, 227, 226, 226),
                          ),
                        ),
                        child: TextFormField(
                          controller: passwordController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(26.0),
                  child: InkWell(
                    onTap: () {
                      print('object');
                      loginUser(
                        usernameController.text,
                        passwordController.text,
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color.fromARGB(255, 21, 128, 24),
                      ),
                      height: 50,
                      width: double.infinity,
                      child: Center(
                        child: Text(
                          isLoading ? "Logging In..." : "Login",
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(26.0),
                  child: Text(
                    'By creating or logging into an account you are agreeing with our Terms and Conditions and Privacy Policy.',
                    style: GoogleFonts.poppins(fontSize: 12),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
