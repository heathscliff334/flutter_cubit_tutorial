import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cubit_1/application/auth/cubit/auth_cubit.dart';
import 'package:flutter_cubit_1/presentation/home/home_page.dart';

import 'package:widget_circular_animator/widget_circular_animator.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _emailController =
      new TextEditingController(text: "eve.holt@reqres.in");
  final _passwordController = new TextEditingController(text: "cityslicka");
  bool _secureText = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ? Step 1 wrap with BlocProvider
      body: BlocProvider(
        create: (context) => AuthCubit(),
        // ? Step 2 wrap with BlocConsumer (combination of builder and listener)
        child: BlocConsumer<AuthCubit, AuthState>(
            // ? BlocListener
            listener: (context, state) {
          if (state is AuthError) {
            print(state.errorMessage);
          } else if (state is AuthLoading) {
            print("loading...");
          } else if (state is AuthLoginSuccess) {
            print(state.dataLogin);
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => HomePage()));
          }
        },
            // ? BlocBuilder
            builder: (context, state) {
          return Container(
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFF0C4BD3),
                        const Color(0xFFE100FF),
                      ],
                      begin: const FractionalOffset(0.0, 1.0),
                      end: const FractionalOffset(1.0, 0.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp,
                    ),
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.only(top: 40, left: 15, right: 15, bottom: 10),
                  child: ListView(
                    children: <Widget>[
                      WidgetCircularAnimator(
                        // innerAnimation: Curves.bounceIn,
                        // outerAnimation: Curves.linear,
                        reverse: true,
                        innerColor: Colors.black45,
                        outerColor: Colors.white60,
                        child: Container(
                          child: Hero(
                            tag: 'hero',
                            child: CircleAvatar(
                                backgroundColor: Colors.transparent,
                                radius: 80,
                                child: Image.network(
                                    "https://cdn-icons-png.flaticon.com/512/25/25231.png")),
                          ),
                        ),
                      ),
                      SizedBox(height: 40),
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                        decoration: BoxDecoration(
                            color: Colors.white70,
                            borderRadius: BorderRadius.circular(30)),
                        child: Column(
                          children: <Widget>[
                            TextField(
                              controller: _emailController,
                              autofocus: false,
                              style: TextStyle(
                                  color: Colors.black38, fontSize: 18),
                              decoration: InputDecoration(
                                  hintText: 'Email',
                                  fillColor: Colors.white,
                                  contentPadding: EdgeInsets.fromLTRB(
                                      10.0, 15.0, 10.0, 15.0),
                                  prefixIcon: Icon(Icons.email_outlined)),
                            ),
                            SizedBox(height: 5),
                            TextField(
                              controller: _passwordController,
                              autofocus: false,
                              obscureText: _secureText,
                              style: TextStyle(
                                  color: Colors.black38, fontSize: 18),
                              decoration: InputDecoration(
                                hintText: 'Password',
                                contentPadding:
                                    EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
                                prefixIcon: Icon(Icons.lock_open),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _secureText = !_secureText;
                                    });
                                  },
                                  icon: Icon(_secureText
                                      ? Icons.visibility_off
                                      : Icons.visibility),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            Row(
                              children: <Widget>[
                                Expanded(
                                    child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    gradient: LinearGradient(
                                      colors: [
                                        const Color(0xFFE100FF),
                                        const Color(0xFF0C4BD3),
                                      ],
                                      begin: const FractionalOffset(0.0, 1.0),
                                      end: const FractionalOffset(1.0, 0.0),
                                      stops: [0.0, 1.0],
                                      tileMode: TileMode.clamp,
                                    ),
                                  ),
                                  child: (state is AuthLoading)
                                      ? _loadingButton()
                                      : _loginButton(context),
                                )),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            SizedBox(height: 30),
                            Text(
                              'Forgot your password?',
                              style: TextStyle(color: Colors.grey.shade500),
                            ),
                            SizedBox(height: 5),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  MaterialButton _loginButton(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        // Call cubit to sign in
        // ! after v6.1.0, .bloc and .repository are changed to .read and .watch
        context
            .read<AuthCubit>()
            .signInUser(_emailController.text, _passwordController.text);
      },
      color: Colors.black54,
      child: Text(
        'Login',
        style: TextStyle(color: Colors.white70, fontSize: 16.0),
      ),
    );
  }

  MaterialButton _loadingButton() {
    return MaterialButton(
        onPressed: null,
        color: Colors.white,
        child: CircularProgressIndicator(
          color: Colors.white54,
        ));
  }
}
