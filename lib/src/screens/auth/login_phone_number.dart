import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sobarbabe/src/widgets/SvgIcon.dart';
import 'package:sobarbabe/src/widgets/custom_outlined_button.dart';
import 'package:sobarbabe/src/widgets/index.dart';

class LoginWithPhoneNumber extends StatefulWidget {
  const LoginWithPhoneNumber({super.key});

  @override
  State<LoginWithPhoneNumber> createState() => _LoginWithPhoneNumberState();
}

class _LoginWithPhoneNumberState extends State<LoginWithPhoneNumber> {
    final _numberController = TextEditingController();
    final String _initialSelection = 'US';
    String? _phoneCode = '+1'; 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Phone Number"),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              CircleAvatar(
                radius: 50,
                backgroundColor: Theme.of(context).primaryColor,
                child: const SvgIcon("assets/icons/call_icon.svg",
                    width: 60, height: 60, color: Colors.white),
              ),
              const SizedBox(height: 10),
              const Text("sign_in_with_phone_number",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20)),
              const SizedBox(height: 25),
              const Text("please_enter_your_phone_number_and_we_will_send_you_a_sms",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, color: Colors.grey)),
              const SizedBox(height: 22),

              /// Form
              Form(
              
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      controller: _numberController,
                      decoration: InputDecoration(
                          labelText: 'Phone number',
                          hintText: 'Enter Phone number',
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: CountryCodePicker(
                                alignLeft: false,
                                initialSelection: _initialSelection,
                                onChanged: (country) {
                                  /// Get country code
                                  _phoneCode = country.dialCode!;
                                }),
                          )),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp("[0-9]"))
                      ],
                      validator: (number) {
                        // Basic validation
                       
                      },
                    ),
                    const SizedBox(height: 20),
                    CustomElevatedButton(text: 'CONTINUE', onPressed: () => {})
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
