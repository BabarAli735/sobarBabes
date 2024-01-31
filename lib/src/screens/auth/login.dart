import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sobarbabe/src/constants/them.dart';
import 'package:sobarbabe/src/helpers/responsive_functions.dart';
import 'package:sobarbabe/src/routes/routes_names.dart';
import 'package:sobarbabe/src/widgets/bold_text.dart';
import 'package:sobarbabe/src/widgets/custom_elevated_button.dart';
import 'package:sobarbabe/src/widgets/custom_outlined_button.dart';
import 'package:sobarbabe/src/widgets/custom_text_field.dart';
import 'package:sobarbabe/src/widgets/medium_text.dart';
import 'package:sobarbabe/src/widgets/vertical_space.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passController = TextEditingController();

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(AppImages.background),
                      fit: BoxFit.cover)),
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: widthPercentageToDP(2, context)),
                  child: Column(children: [
                    VerticalSpace(height: 10),
                    Container(
                        width: double.infinity,
                        padding:
                            EdgeInsets.all(widthPercentageToDP(2, context)),
                        child: BoldText(text: 'Sign In')),
                    const VerticalSpace(),
                    CustomTextField(
                      hintText: 'Enter Email',
                      controller: emailController,
                    ),
                    const VerticalSpace(),
                    CustomTextField(
                      hintText: 'Enter Password',
                      controller: passController,
                      showIcon: true,
                      obsecure: true,
                    ),
                    const VerticalSpace(),
                    Container(
                      width: double.infinity,
                      child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, RoutesName.ForgotPassword);
                          },
                          child: MediumText(text: 'Forget Password')),
                    ),
                    const VerticalSpace(),
                    CustomElevatedButton(text: 'Login', onPressed: () {}),
                    const VerticalSpace(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 1,
                          width: widthPercentageToDP(40, context),
                          decoration:
                              const BoxDecoration(color: AppColors.grey),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          child: const Text(
                            'Or',
                            style: TextStyle(
                                color: AppColors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        Container(
                          height: 1,
                          width: widthPercentageToDP(40, context),
                          decoration:
                              const BoxDecoration(color: AppColors.grey),
                        ),
                      ],
                    ),
                    const VerticalSpace(),
                    CustomOutLineButton(
                      text: 'Sign In with Google',
                      isImage: true,
                      onPressed: () {},
                    ),
                    const VerticalSpace(),
                    CustomOutLineButton(
                      text: 'Sign in with Number',
                      icon: Icons.phone,
                      onPressed: () {
                        Navigator.pushNamed(
                            context, RoutesName.PhonerRegistration);
                      },
                    ),
                    const VerticalSpace(),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, RoutesName.signUp);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          MediumText(text: 'Don’t have an account? '),
                          MediumText(
                            text: 'Sign Up',
                            color: AppColors.golden,
                          )
                        ],
                      ),
                    )
                  ]),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
