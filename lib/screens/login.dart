import 'package:flutter/material.dart';
import '../utils/toast.dart';
import '../constants/route.dart';
import '../constants/theme.dart';
import '../widgets/my_button.dart';
import '../widgets/my_input.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool isObscureText = true;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Login Page',
          style: TextStyle(
            color: UMColors.white,
          ),
        ),
        backgroundColor: UMColors.primary,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: UMColors.white),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 1.0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20.0, horizontal: 8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'User Name',
                          style: TextStyle(
                            color: UMColors.secondary,
                          ),
                        ),
                        const SizedBox(height: 5.0),
                        MyInput(
                          prefixIcon: const Icon(
                            Icons.person,
                            color: UMColors.primary,
                          ),
                          placeholder: 'User Name',
                          controller: _usernameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter username';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 18.0),
                        const Text(
                          'Password',
                          style: TextStyle(
                            color: UMColors.secondary,
                          ),
                        ),
                        const SizedBox(height: 5.0),
                        MyInput(
                          prefixIcon: const Icon(
                            Icons.security_rounded,
                            color: UMColors.primary,
                          ),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                isObscureText = !isObscureText;
                              });
                            },
                            child: isObscureText
                                ? const Icon(
                                    Icons.visibility,
                                    color: UMColors.secondary,
                                  )
                                : const Icon(
                                    Icons.visibility_off,
                                    color: UMColors.secondary,
                                  ),
                          ),
                          placeholder: 'Password',
                          controller: _passwordController,
                          obscureText: isObscureText,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter password';
                            }
                            if (value.trim().length < 8) {
                              return 'Please enter minimum 8 characters';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 13.0),
              SizedBox(
                width: 180.0,
                height: 50.0,
                child: MyButton(
                  onPressed: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    if (_formKey.currentState!.validate()){
                      if(_usernameController.text == 'admin' && _passwordController.text == '12345678'){
                        Navigator.pushReplacementNamed(context, Routes.home);
                      }else{
                        showToast(context, "Invalid Credential!");
                      }
                    }
                  },
                  label: 'Login',
                  icon: Icons.login,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
