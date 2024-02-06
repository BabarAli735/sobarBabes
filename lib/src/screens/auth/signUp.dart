import 'package:flutter/gestures.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sobarbabe/src/helpers/responsive_functions.dart';
import 'package:sobarbabe/src/provider/auth_provider.dart';
import 'package:sobarbabe/src/routes/routes_names.dart';
import 'package:sobarbabe/src/widgets/index.dart';

import '../../models/user.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passcontroller = TextEditingController();
  bool isChecked = false;
  bool isPasswordVisible = false;

  final _fromkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthenticationProvider>(context);

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background_image.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/logonew.png',
                    width: 200.0,
                    height: 200.0,
                  ),
                  // const SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      gradient:
                          LinearGradient(begin: Alignment.bottomRight, colors: [
                        Theme.of(context).primaryColor,
                        Colors.black.withOpacity(.4),
                      ]),
                      color: Colors.transparent,
                    ),
                    child: Form(
                      key: _fromkey,
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextFormField(
                            controller: namecontroller,
                            decoration: InputDecoration(
                              labelText: 'Username',
                              labelStyle: const TextStyle(color: Colors.white),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(
                                    color: Color(0xFFAB47BC), width: 2),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(
                                    color: Color(0xFFAB47BC), width: 1.5),
                              ),
                              focusedBorder: OutlineInputBorder(
                                gapPadding: 0.0,
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(
                                    color: Color(0xFFAB47BC), width: 1.5),
                              ),
                              fillColor:
                                  const Color.fromARGB(101, 158, 158, 158),
                              filled: true,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            decoration: const BoxDecoration(),
                            child: TextFormField(
                              controller: emailcontroller,
                              decoration: InputDecoration(
                                labelText: 'Email',
                                labelStyle:
                                    const TextStyle(color: Colors.white),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: const BorderSide(
                                      color: Color(0xFFAB47BC), width: 2),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: const BorderSide(
                                      color: Color(0xFFAB47BC), width: 1.5),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  gapPadding: 0.0,
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: const BorderSide(
                                      color: Color(0xFFAB47BC), width: 1.5),
                                ),
                                fillColor:
                                    const Color.fromARGB(101, 158, 158, 158),
                                filled: true,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Transform.translate(
                            offset: Offset(0, 0),
                            child: Container(
                              decoration: const BoxDecoration(),
                              child: TextFormField(
                                controller: passcontroller,
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                  labelStyle:
                                      const TextStyle(color: Colors.white),
                                  prefixIconColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(
                                        color: Color(0xFFAB47BC), width: 2),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(
                                        color: Color(0xFFAB47BC), width: 2),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    gapPadding: 0.0,
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(
                                        color: Color(0xFFAB47BC), width: 2),
                                  ),
                                  fillColor:
                                      const Color.fromARGB(101, 158, 158, 158),
                                  filled: true,
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      isPasswordVisible
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        isPasswordVisible = !isPasswordVisible;
                                      });
                                    },
                                  ),
                                ),
                                obscureText: !isPasswordVisible,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Theme(
                                data: Theme.of(context).copyWith(
                                  unselectedWidgetColor: Colors
                                      .pinkAccent, // Customize checkbox color when unchecked
                                  checkboxTheme: CheckboxThemeData(
                                    checkColor: MaterialStateProperty
                                        .resolveWith<Color>(
                                      (Set<MaterialState> states) {
                                        if (states
                                            .contains(MaterialState.selected)) {
                                          return Colors
                                              .white; // Customize checkbox color when checked
                                        } else
                                          return Colors.white; // Default color
                                      },
                                    ),
                                    fillColor: MaterialStateProperty
                                        .resolveWith<Color>(
                                      (Set<MaterialState> states) {
                                        if (states
                                            .contains(MaterialState.selected)) {
                                          return Color.fromARGB(255, 201, 36,
                                              235); // Customize checkbox fill color when checked
                                        }
                                        return Colors.white; // Default color
                                      },
                                    ),
                                    overlayColor: MaterialStateProperty
                                        .all<Color>(Colors.white.withOpacity(
                                            0.1)), // Customize checkbox overlay color when pressed
                                  ),
                                ),
                                child: Checkbox(
                                  value: isChecked,
                                  onChanged: (value) {
                                    setState(() {
                                      isChecked = value!;
                                    });
                                  },
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  // Handle Privacy Policy link tap
                                },
                                child: const Text(
                                  'I agree to the ',
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  // Handle Privacy Policy link tap
                                },
                                child: const Text(
                                  'Privacy Policy',
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                              const Text(
                                ' and ',
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: Colors.white,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  // Handle Terms of Use link tap
                                },
                                child: const Text(
                                  'Terms of Use',
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Column(
                              children: [
                                CustomElevatedButton(
                                    text: 'Register',
                                    onPressed: () {
                                      authProvider.signUpWithEmailAndPassword(
                                          emailcontroller.text,
                                          passcontroller.text,
                                          namecontroller.text,
                                          context);
                                    })
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                top: heightPercentageToDP(2, context)),
                            child: SizedBox(
                              child: GestureDetector(
                                onTap: () {
                                  // Navigate to the signup screen
                                  Navigator.pushNamed(
                                      context, RoutesName.LoginWithEmail);
                                },
                                child: RichText(
                                  text: const TextSpan(
                                    text: 'Already  have an account?',
                                    style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                    children: [
                                      TextSpan(
                                        text: ' Login',
                                        style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            color: Colors.blue,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
