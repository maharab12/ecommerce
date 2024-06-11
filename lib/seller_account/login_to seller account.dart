import 'package:flutter/material.dart';

class Login_toseller extends StatefulWidget {
  const Login_toseller({super.key});

  @override
  State<Login_toseller> createState() => _Login_tosellerState();
}

class _Login_tosellerState extends State<Login_toseller> {
  String valu = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextFormField(
                  onChanged: (value) {
                    setState(() {
                      valu = value;
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Username',
                  ),
                ),
              ),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                  obscureText: true,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  print(valu);
                },
                child: Text("Login/Password"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
