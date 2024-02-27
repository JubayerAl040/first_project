import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProfileSettingsScreen extends StatelessWidget {
  const ProfileSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F4),
      body: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Image.asset("assets/images/door_logo.png", width: 20),
              const SizedBox(width: 5),
              const Text("Jb Jason"),
            ],
          ),
        ),
        drawer: const SettingsDrawer(),
        body: const SafeArea(child: ProfileSettingsBody()),
      ),
    );
  }
}

class ProfileSettingsBody extends StatefulWidget {
  const ProfileSettingsBody({super.key});

  @override
  State<ProfileSettingsBody> createState() => _ProfileSettingsBodyState();
}

class _ProfileSettingsBodyState extends State<ProfileSettingsBody> {
  final _phnNumberField = TextEditingController();
  final _emailField = TextEditingController();
  final _passField = TextEditingController();
  final _dateField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(15),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const SizedBox(width: 15),
                Container(
                  height: size.height * .12,
                  width: size.width * .2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    image: const DecorationImage(
                        image: AssetImage("assets/images/user.jpg"),
                        fit: BoxFit.cover),
                  ),
                ),
                const SizedBox(width: 15),
                const Text("Jb Jason"),
              ],
            ),
            const SizedBox(height: 30),
            CmNameEmailField(
              title: "Phone number",
              label: "Type your contact no",
              controller: _phnNumberField,
            ),
            CmNameEmailField(
              title: "Email",
              label: "Type your email address",
              controller: _emailField,
            ),
            CmPassField(
              title: "Password",
              controller: _passField,
            ),
            CmDateField(
              title: "Date of birth",
              label: "DD/MM/YYYY",
              controller: _dateField,
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text("Delete Account"),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8F90A6),
                    foregroundColor: Colors.white,
                  ),
                  child: const Text("Update Details"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _dateField.dispose();
    _emailField.dispose();
    _passField.dispose();
    _phnNumberField.dispose();
    super.dispose();
  }
}

class CmNumberField extends StatelessWidget {
  const CmNumberField(
      {super.key,
      required this.title,
      required this.controller,
      required this.label,
      this.readOnly});
  final String title;
  final TextEditingController controller;
  final String label;
  final bool? readOnly;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        TextFormField(
          controller: controller,
          textInputAction: TextInputAction.done,
          style: const TextStyle(fontSize: 16, color: Colors.white),
          decoration: InputDecoration(
            hintText: label,
            hintStyle: const TextStyle(fontSize: 12, color: Colors.grey),
            isDense: true,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            filled: true,
            fillColor: const Color(0xFFD9D9D9),
            enabledBorder: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            focusedBorder: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.grey),
            ),
          ),
          readOnly: readOnly ?? false,
          validator: (val) {
            if (val!.isEmpty) {
              return 'Plz insert any number!';
            } else {
              final intValue = int.tryParse(val);
              if (intValue == null) return "Plz provide valid value";
              return null;
            }
          },
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}

class CmNameEmailField extends StatelessWidget {
  const CmNameEmailField(
      {super.key,
      required this.title,
      required this.label,
      required this.controller});
  final String title;
  final String label;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        TextFormField(
          style: const TextStyle(fontSize: 14, color: Colors.black),
          decoration: InputDecoration(
            hintText: label,
            hintStyle: const TextStyle(fontSize: 12, color: Colors.grey),
            isDense: true,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            filled: true,
            fillColor: const Color(0xFFD9D9D9),
            enabledBorder: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            focusedBorder: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.grey),
            ),
          ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}

class CmPassField extends StatelessWidget {
  const CmPassField({super.key, required this.title, required this.controller});
  final String title;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    final isObsecure = ValueNotifier<bool>(true);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        ValueListenableBuilder(
          valueListenable: isObsecure,
          builder: (context, val, _) => TextFormField(
            controller: controller,
            textInputAction: TextInputAction.done,
            obscureText: val,
            decoration: InputDecoration(
              hintText: "m#P52s@ap\$V",
              hintStyle: const TextStyle(fontSize: 12, color: Colors.grey),
              isDense: true,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              filled: true,
              fillColor: const Color(0xFFD9D9D9),
              enabledBorder: UnderlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              focusedBorder: UnderlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              suffix: InkWell(
                onTap: () => isObsecure.value = !val,
                child: Icon(val ? Icons.visibility : Icons.visibility_off),
              ),
            ),
            validator: (val) {
              bool hasSpecialCharacter = containsSpecialCharacter(val!);
              bool hasNumber = containsNumber(val);
              bool hasCapitalLetter = containsCapitalLetter(val);
              bool hasSmallLetter = containsSmallLetter(val);
              if (val.isEmpty || val.length < 4) {
                return 'Plz insert a Password of 4 characters atleast';
              } else if (!hasSpecialCharacter) {
                return 'Plz add a Special character [!@#\$%^&*(),.?":{}|<>]';
              } else if (!hasNumber) {
                return 'Plz add a NUMBER ( 0-9 )';
              } else if (!hasCapitalLetter) {
                return 'Plz add a capital letter ( A-Z )';
              } else if (!hasSmallLetter) {
                return 'Plz add a small letter ( a-z )';
              } else {
                return null;
              }
            },
          ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }

  bool containsSpecialCharacter(String str) {
    RegExp specialCharacterRegex = RegExp(r'[!@#$%^&*(),.?":{}|<>]');
    return specialCharacterRegex.hasMatch(str);
  }

  bool containsNumber(String str) {
    RegExp numberRegex = RegExp(r'[0-9]');
    return numberRegex.hasMatch(str);
  }

  bool containsCapitalLetter(String str) {
    RegExp capitalLetterRegex = RegExp(r'[A-Z]');
    return capitalLetterRegex.hasMatch(str);
  }

  bool containsSmallLetter(String str) {
    RegExp smallLetterRegex = RegExp(r'[a-z]');
    return smallLetterRegex.hasMatch(str);
  }
}

class CmDateField extends StatelessWidget {
  const CmDateField(
      {super.key,
      required this.title,
      required this.label,
      required this.controller,
      this.firstDate,
      this.lastDate});
  final String title;
  final String label;
  final TextEditingController controller;
  final DateTime? firstDate;
  final DateTime? lastDate;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        TextFormField(
          controller: controller,
          readOnly: true,
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(
            hintText: label,
            hintStyle: const TextStyle(fontSize: 12, color: Colors.grey),
            isDense: true,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            filled: true,
            fillColor: const Color(0xFFD9D9D9),
            enabledBorder: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            focusedBorder: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            suffixIcon: const Icon(Icons.calendar_month_outlined),
          ),
          onTap: () async {
            DateTime? date = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: firstDate ??
                  DateTime.now().subtract(const Duration(days: 70 * 365)),
              lastDate:
                  lastDate ?? DateTime.now().add(const Duration(days: 30)),
            );
            if (date == null) return;
            controller.text = DateFormat('dd-MM-yyyy').format(date);
          },
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}

class SettingsDrawer extends StatelessWidget {
  const SettingsDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * .97,
      elevation: 10,
      child: Container(
        color: const Color(0xFFF4F4F4),
        padding: const EdgeInsets.all(15),
        child: ListView(
          children: [
            Row(
              children: [
                const SizedBox(width: 15),
                Image.asset("assets/images/door_logo.png", width: 20),
                const SizedBox(width: 5),
                const Expanded(child: Text("Jb Jason")),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close_outlined),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _getDrawerItem(
                Icons.local_activity_outlined, "Activity", Colors.white),
            const SizedBox(height: 10),
            _getDrawerItem(
                Icons.notifications_on_outlined, "Notifications", Colors.white),
            const SizedBox(height: 10),
            _getDrawerItem(
                Icons.military_tech_rounded, "Rewards", Colors.white),
            const SizedBox(height: 10),
            _getDrawerItem(Icons.settings, "Settings", Colors.white),
            const SizedBox(height: 20),
            const Divider(color: Colors.grey, thickness: .4),
            const SizedBox(height: 20),
            _getDrawerItem(Icons.chat_bubble, "Chat with support",
                const Color(0xFFE9E9E9)),
            const SizedBox(height: 10),
            _getDrawerItem(
                Icons.help_center, "Help center", const Color(0xFFE9E9E9)),
            const SizedBox(height: 10),
            _getDrawerItem(
                Icons.edit_document, "Legal", const Color(0xFFE9E9E9)),
            const SizedBox(height: 10),
            _getDrawerItem(Icons.design_services, "Become a Service Provider",
                const Color(0xFFE9E9E9)),
            const SizedBox(height: 10),
            _getDrawerItem(
                Icons.logout_rounded, "Log out", const Color(0xFFE9E9E9)),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _getDrawerItem(IconData icon, String title, Color color) {
    return OutlinedButton(
      onPressed: () {},
      style: OutlinedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        side: BorderSide.none,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 13),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.black),
          const SizedBox(width: 7),
          Text(title, style: const TextStyle(color: Colors.black)),
        ],
      ),
    );
  }
}
