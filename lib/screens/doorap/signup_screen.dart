import 'dart:io';
import 'package:first_project/widgets/cm_widgets/cm_name_email_field.dart';
import 'package:first_project/widgets/cm_widgets/cm_number_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _firstNameField = TextEditingController();
  final _lastNameField = TextEditingController();
  final _emailField = TextEditingController();
  final _phnNumberField = TextEditingController();
  final _passField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F4),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF4F4F4),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.close_outlined),
        ),
        title: const Text("Sign-UP"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: CmNameEmailField(
                      controller: _firstNameField,
                      title: "First Name",
                      label: "First name",
                      readOnly: false,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: CmNameEmailField(
                      controller: _lastNameField,
                      title: "Last Name",
                      label: "Last name",
                      readOnly: false,
                    ),
                  ),
                ],
              ),
              CmNameEmailField(
                title: "Email",
                label: "Enter your email",
                controller: _emailField,
                readOnly: false,
              ),
              CmNumberField(
                title: "Phone number",
                label: "Enter your contact no",
                controller: _phnNumberField,
              ),
              // CmPassField(title: "Password", controller: _passField),
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: () => _showPrivacyDialog(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 80),
                  ),
                  child: const Text("Next"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showPrivacyDialog(BuildContext context) async {
    Platform.isAndroid
        ? await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              backgroundColor: Colors.white,
              title: _getDialogTitle(),
              content: _getBottomSheetContent(context),
              actions: [_getDialogButton],
            ),
          )
        : showCupertinoModalPopup(
            context: context,
            barrierColor: Colors.white,
            builder: (BuildContext context) => CupertinoAlertDialog(
              title: _getDialogTitle(),
              content: _getBottomSheetContent(context),
              actions: [_getDialogButton],
            ),
          );
  }

  Widget _getDialogTitle() => const Text(
        "Review Doorap's Terms & Conditions and Privacy & User Notice",
        style: TextStyle(fontWeight: FontWeight.bold),
      );

  Widget _getBottomSheetContent(BuildContext context) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Checkbox(value: true, onChanged: (_) {}),
          const Expanded(
            child: Text(
              "Check the box to confirm you are at least 18 years of age. Also, agree to the Terms & Conditions, Privacy Policy and Dooraps User Policy.",
            ),
          ),
        ],
      );
  Widget get _getDialogButton => Center(
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 80)),
          child: const Text("Submit"),
        ),
      );
}
