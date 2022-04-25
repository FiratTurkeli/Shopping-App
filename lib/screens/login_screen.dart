import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/constants/color.dart';
import 'package:shop_app/utils/snack_message.dart';
import 'package:shop_app/widgets/tapButton.dart';

import '../database/db_provider.dart';
import '../providers/auth_providers.dart';


enum AuthMode { Signup, Login }

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController passAgainController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  AuthMode _authMode = AuthMode.Login;
  final maskFormatter = MaskTextInputFormatter(mask:  '+# (###) ###-##-##');
  RegExp pass_valid = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");
  bool isChecked = false;

  bool validatePassword(String pass){
    String _password = pass.trim();
    if (pass_valid.hasMatch(_password)) {
      return true;
    }else{
      return false;
    }
  }

  @override
  void dispose() {
    emailController.clear();
    passController.clear();
    phoneController.clear();
    super.dispose();
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        emailController.clear();
        passController.clear();
        phoneController.clear();
        _authMode = AuthMode.Signup;
      });
    } else {
      setState(() {
        emailController.clear();
        passController.clear();
        phoneController.clear();
        _authMode = AuthMode.Login;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(_authMode == AuthMode.Login ? "Login" : "Register"),
      ),
      body:  Center(
        child:  SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: _key,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(""),
                  const SizedBox(height: 20,),
                  if (_authMode == AuthMode.Signup)
                    TextFormField(
                    controller: nameController,
                    validator: (value){
                      if(value!.isEmpty) {
                      return 'Please Enter Name';}
                      return null;
                      },
                    decoration: const InputDecoration(
                        hintText: "Enter your Full Name",
                        labelText: "Full Name" ,
                        border: const OutlineInputBorder(),
                        suffixIcon: const Icon(Icons.person)
                    ),
                  ),

                  const SizedBox(height: 20,),

                  TextFormField(
                    controller: emailController,
                    validator: (value){
                      if(value!.isEmpty) {
                        return 'Please a Enter';
                      }
                      String pattern =
                          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                      if(!RegExp(pattern).hasMatch(value)){
                        return 'Please a valid Email';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        labelText: "Email" ,
                      hintText: "Email",
                        border: const OutlineInputBorder(),
                        suffixIcon: const Icon(Icons.mail)
                    ),
                  ),
                  const SizedBox(height: 20,),
                  TextFormField(
                    obscureText: true,
                    controller: passController,
                    decoration: const InputDecoration(
                        labelText: "Password" ,
                        hintText: "Password",
                        border: const OutlineInputBorder(),
                        suffixIcon: const Icon(Icons.password_outlined)
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter password";
                      }  else {
                        bool result = validatePassword(value);
                        if (result) {
                          return null;
                        }  else {
                          return "Password should contain capital, small letter & number & special";
                        }
                      }
                    },
                  ),
                  if (_authMode == AuthMode.Signup)
                    const SizedBox(height: 20,),
                    TextFormField(
                      obscureText: true,
                      controller: passAgainController,
                      decoration: const InputDecoration(
                          labelText: "Password Again" ,
                          hintText: "Password Again",
                          border: const OutlineInputBorder(),
                          suffixIcon: const Icon(Icons.password_outlined)
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter re-password again";
                        } if (passController.text != passAgainController.text) {
                          return "Password do not match";
                        }

                        return null;
                        
                      },
                    ),
                  const SizedBox(height: 20,),

                  if (_authMode == AuthMode.Signup)
                    TextFormField(
                      controller: phoneController,
                      inputFormatters: [maskFormatter],
                      keyboardType: TextInputType.number ,
                      decoration: const InputDecoration(
                        hintText: "Phone",
                          labelText: "Phone" ,
                          border: const OutlineInputBorder(),
                          suffixIcon: const Icon(Icons.phone)
                      ),
                    ),

                  const SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Remember me",),
                          Checkbox(
                          value: isChecked,
                              onChanged: (value) async {
                               setState(() {
                                  isChecked=value!;
                                 print(value);
                              },

                               );
                              }
                          ),
                        ],
                      ),

                    Consumer<AuthenticationProvider>(
                      builder: (context, auth, child) {
                        WidgetsBinding.instance!.addPostFrameCallback((_) {
                          if (auth.resMessage != '') {
                            showMessage(
                              message: auth.resMessage, context: context,
                            );
                            auth.clear();
                          }
                        });
                        return tapButton(
                          text: _authMode == AuthMode.Login ? "Login" : "Register" ,
                          tap: () async {
                            await _key.currentState!.validate();
                            print("Login remember ${isChecked}");
                            if (emailController.text.isEmpty && passController.text.isEmpty) {
                              showMessage(
                                message: "All fields are required",
                                context: context,
                              );
                            } else if (_authMode == AuthMode.Login) {
                              if(_key.currentState!.validate())
                              auth.loginUser(email: emailController.text.trim(), password: passController.text.trim(),rememberMe: isChecked, context: context);
                            } else if (_authMode == AuthMode.Signup) {
                              if(_key.currentState!.validate())
                              auth.registerUser(name: nameController.text.trim(),email: emailController.text.trim(), password: passController.text.trim(), id:phoneController.text,rememberMe: isChecked, context: context);
                            }
                          },
                          context: context,
                          status: auth.isLoading
                        );
                      },
                    ),
                  TextButton(
                    child: Text(
                        '${_authMode == AuthMode.Login ? 'SIGNUP' : 'LOGIN'} '),
                    onPressed: _switchAuthMode,
                  ),

                ],
              ),
            ),
          ),
        ),
      ),

    );
  }

}

