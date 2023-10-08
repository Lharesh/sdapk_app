import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sdapk_app/authentication/services/auth_service.dart';

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key});

  @override
  ConsumerState<AuthScreen> createState() => _LoginState();
}

class _LoginState extends ConsumerState<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  var _enteredEmail = '';
  var _enteredPassword = '';
  var _enteredUsername = '';
  bool isLogin = true;
  var _isAuthenticating = false;
  void buildSnackbar(FirebaseAuthException error) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(error.message ?? 'Authentication Failed.'),
      ),
    );
  }

  void _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    try {
      setState(() {
        _isAuthenticating = true;
      });
      if (isLogin) {
        //log users in
        await ref.read(authProvider).signIn(_enteredEmail, _enteredPassword);
      } else {
        final uid = await ref
            .read(authProvider)
            .signUp(_enteredEmail, _enteredPassword);
        await FirebaseFirestore.instance.collection('users').doc(uid).set({
          'username': _enteredUsername,
          'email': _enteredEmail,
          'role': 'user',
        });
      }
    } on FirebaseAuthException catch (error) {
      buildSnackbar(error);
      setState(() {
        _isAuthenticating = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 200,
                child: Image.asset('assets/images/apk_logo_01.png'),
              ),
              Card(
                margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            decoration: const InputDecoration(
                                icon: Icon(Icons.email_outlined),
                                labelText: 'Email Address'),
                            keyboardType: TextInputType.emailAddress,
                            autocorrect: false,
                            textCapitalization: TextCapitalization.none,
                            validator: (value) {
                              if (value == null ||
                                  value.trim().isEmpty ||
                                  !value.contains('@')) {
                                return 'Please enter a valid email address';
                              }
                              return null;
                            },
                            onSaved: (newValue) {
                              _enteredEmail = newValue!;
                            },
                          ),
                          if (!isLogin)
                            TextFormField(
                              decoration: const InputDecoration(
                                  icon: Icon(Icons.person_2_outlined),
                                  labelText: 'User Name'),
                              enableSuggestions: false,
                              validator: (value) {
                                if (value == null ||
                                    value.trim().isEmpty ||
                                    value.trim().length < 4) {
                                  return 'Please enter atleast 4 characters.';
                                }
                                return null;
                              },
                              onSaved: (newValue) {
                                _enteredUsername = newValue!;
                              },
                            ),
                          TextFormField(
                            decoration: const InputDecoration(
                                icon: Icon(Icons.password_outlined),
                                labelText: 'Password'),
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.trim().length < 6) {
                                return 'Password must be atleast 6 characters long.';
                              }
                              return null;
                            },
                            onSaved: (newValue) {
                              _enteredPassword = newValue!;
                            },
                          ),
                          const SizedBox(height: 12),
                          if (_isAuthenticating)
                            const CircularProgressIndicator(),
                          if (!_isAuthenticating)
                            ElevatedButton(
                              onPressed: _submit,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(context)
                                    .colorScheme
                                    .primaryContainer,
                              ),
                              child: Text(isLogin ? 'Sign in' : 'Sign up'),
                            ),
                          if (!_isAuthenticating)
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  isLogin = !isLogin;
                                });
                              },
                              child: Text(isLogin
                                  ? 'Create an account'
                                  : 'I already have an account.'),
                            ),
                        ],
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
