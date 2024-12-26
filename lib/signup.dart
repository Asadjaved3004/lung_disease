import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> with SingleTickerProviderStateMixin {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _numberController = TextEditingController();

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
    super.dispose();
  }

  void signUp() {
    String name = _nameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;
    String number = _numberController.text;

    if (name.isNotEmpty && email.isNotEmpty && password.isNotEmpty && number.isNotEmpty) {
      Navigator.pop(context);
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text("Please fill in all fields"),
            actions: <Widget>[
              TextButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get the screen width to set 80% of it
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
        backgroundColor:Color.fromRGBO(111, 159, 179, 1.0),
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
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            children: [
              SizedBox(height: 20), // Spacing below the AppBar
              Center(
                child: Image.asset(
                  'assets/images/heart.png', // Path to your image in assets
                  width: 100,
                  height: 100,
                ),
              ),
              SizedBox(height: 20), // Spacing between the image and the container
              Expanded(
                child: Center(
                  child: SizedBox(
                    width: screenWidth * 0.8, // 80% of the screen width
                    child: Container(
                      padding: EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        color: Colors.white, // Keep the box container white
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10.0,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          TextField(
                            controller: _nameController,
                            decoration: InputDecoration(labelText: "Name"),
                          ),
                          SizedBox(height: 20.0),
                          TextField(
                            controller: _emailController,
                            decoration: InputDecoration(labelText: "Email"),
                          ),
                          SizedBox(height: 20.0),
                          TextField(
                            controller: _numberController,
                            decoration: InputDecoration(labelText: "Number"),
                            keyboardType: TextInputType.number,
                          ),
                          SizedBox(height: 20.0),
                          TextField(
                            controller: _passwordController,
                            decoration: InputDecoration(labelText: "Password"),
                            obscureText: true,
                          ),
                          SizedBox(height: 20.0),
                          ElevatedButton(
                            onPressed: signUp,
                            style: ElevatedButton.styleFrom(
                              backgroundColor:Color.fromRGBO(111, 159, 179, 1.0),
                              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(35),
                              ),
                            ),
                            child: Text(
                              "Sign Up",
                              style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.white,
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
      ),
    );
  }


}
