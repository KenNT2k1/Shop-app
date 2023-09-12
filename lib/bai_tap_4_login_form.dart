import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Material App',
      home: LoginScreen(),
    );
  }
}

enum FormType { login, register }

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  FormType _formType = FormType.login;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Material App Bar'),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.purple.withAlpha(220),
                    Colors.orange.withAlpha(150)
                  ]),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Transform.rotate(
                angle: 3.14 / -15,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.red),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                    child: Text(
                      'MyShop',
                      style:
                          TextStyle(fontSize: 40, fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(30),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(width: 0.5, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    const TextField(
                      decoration: InputDecoration(hintText: 'E-Mail'),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const TextField(
                      decoration: InputDecoration(hintText: 'Password'),
                    ),
                    AnimatedSize(
                        duration: const Duration(milliseconds: 200),
                        child: SizedBox(
                          height: _formType == FormType.register ? 0 : null,
                          child: const TextField(
                            decoration:
                                InputDecoration(hintText: 'Re-Password'),
                          ),
                        )),
                    const SizedBox(
                      height: 15,
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: const BorderSide(color: Colors.red))),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                            _formType == FormType.login ? 'Login' : 'Register'),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextButton(
                        onPressed: () {
                          setState(() {
                            if (_formType == FormType.login) {
                              _formType = FormType.register;
                            } else {
                              _formType = FormType.login;
                            }
                          });
                        },
                        child: Text(_formType == FormType.login
                            ? 'Register'
                            : 'Login')),
                  ],
                ),
              ),
              const Spacer(),
            ],
          )
        ],
      ),
    );
  }
}
