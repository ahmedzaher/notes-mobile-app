import 'package:flutter/material.dart';
import 'package:notes_app/screens/shared/constants.dart';
import 'package:notes_app/screens/shared/loading.dart';
import 'package:notes_app/services/auth.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();

  Function onToggleView;

  SignIn({this.onToggleView});
}

class _SignInState extends State<SignIn> {
  String _email;
  String _password;
  String _error = '';
  bool _loading = false;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return _loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.yellow[100],
            appBar: AppBar(
              title: Text(
                'Sign in to Notes App',
                style: TextStyle(),
              ),
              backgroundColor: Colors.amber[400],
              elevation: 0.0,
              actions: [
                FlatButton(
                  child: Text(
                    'Register',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () => widget.onToggleView(),
                )
              ],
            ),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 50, horizontal: 30),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      onChanged: (val) => _email = val,
                      validator: (val) =>
                          val.isEmpty ? 'Email is required' : null,
                      decoration: inputDecoration.copyWith(
                        hintText: 'Email',
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      onChanged: (val) => _password = val,
                      validator: (val) => val.length < 6
                          ? 'Password must be 6 digits at least'
                          : null,
                      decoration: inputDecoration.copyWith(
                        hintText: 'Password',
                      ),
                      obscureText: true,
                    ),

                    SizedBox(
                      height: 40,
                    ),
                    RaisedButton(
                      child: Text(
                        'Sign in',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          letterSpacing: 1.3,
                        ),
                      ),
                      color: Colors.amber,
                      onPressed: () async => _signIn(),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    FlatButton(
                      child: Text(
                        'Forget your password',
                        style: TextStyle(color: Colors.amber),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Text(
                      _error,
                      style: TextStyle(
                        color: Colors.redAccent,
                        fontSize: 16,
                        letterSpacing: 1.2,
                        fontWeight: FontWeight.bold
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
  }
  _signIn() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        _loading = true;
      });
      dynamic result = await AuthService().signInWithEmailAndPassword(
          _email, _password);
      if (result == null) {
        print('Error when  signing in');
        setState(() {
          _error = 'Invalid email or password';
          _loading = false;
        });
      }
    }
  }
}
