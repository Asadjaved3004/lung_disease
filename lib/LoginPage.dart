import 'package:flutter/material.dart';
import 'signup.dart';
import 'afterloginscreen.dart';
import 'main.dart'; // Importing the main.dart for HomePage reference.

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_fadeController);
    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void signIn() {
    String email = _emailController.text;
    String password = _passwordController.text;

    // Authentication logic here
    // After successful login, navigate back to HomePage
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => AfterLoginScreen()),
      ModalRoute.withName('/'), // This removes all previous routes and ensures only AfterLoginScreen is on top.
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        backgroundColor: Color.fromRGBO(111, 159, 179, 1.0),
        titleTextStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 30,
          color: Colors.white,
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueGrey, Colors.grey],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 20),
            Center(
              child: Image.asset(
                'assets/images/heart.png',
                width: 100,
                height: 100,
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.85,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 8,
                          spreadRadius: 2,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Welcome Back!",
                          style: TextStyle(
                            color: Color.fromRGBO(74, 79, 66, 1),
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Color.fromRGBO(62,176,222,1)),
                          ),
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(color: Color.fromRGBO(62,176,222,1)),
                                  ),
                                ),
                                child: TextField(
                                  controller: _emailController,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintStyle: TextStyle(color: Colors.grey),
                                    hintText: "Email",
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                child: TextField(
                                  controller: _passwordController,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintStyle: TextStyle(color: Colors.grey),
                                    hintText: "Password",
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 30),
                        Center(
                          child: ElevatedButton(
                            onPressed: signIn,
                            style: ElevatedButton.styleFrom(
                              backgroundColor:Color.fromRGBO(111, 159, 179, 1.0),
                              padding: EdgeInsets.symmetric(vertical: 14, horizontal: 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(35),
                              ),
                            ),
                            child: Text(
                              "Login",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Center(
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Signup()),
                              );
                            },
                            child: Text(
                              "Don't have an account? Sign up",
                              style: TextStyle(
                                color: Color.fromRGBO(74, 79, 66, 1),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
