import 'package:first_project/widgets/cm_widgets/cm_add_button.dart';
import 'package:first_project/widgets/cm_widgets/cm_date_field.dart';
import 'package:first_project/widgets/cm_widgets/cm_dropdown_field.dart';
import 'package:first_project/widgets/cm_widgets/cm_name_email_field.dart';
import 'package:first_project/widgets/cm_widgets/cm_number_field.dart';
import 'package:first_project/widgets/cm_widgets/cm_repo.dart';
import 'package:flutter/material.dart';

class BookPetTravelScreen extends StatefulWidget {
  const BookPetTravelScreen({super.key});
  @override
  State<BookPetTravelScreen> createState() => _BookPetTravelScreenState();
}

class _BookPetTravelScreenState extends State<BookPetTravelScreen> {
  final _dateField = TextEditingController();
  final _dayField = TextEditingController();
  final _nameField = TextEditingController();
  final _addressField = TextEditingController();
  final _travelDetailsField = TextEditingController();
  final _selectedCountry = ValueNotifier<String>("");
  final _selectedAgency = ValueNotifier<String>("");
  final _additionalField = TextEditingController();
  final _seasonTypeList = [
    "Portrait Sessions",
    "Lifestyle Sessions",
    "Action Sessions",
    "Studio Sessions",
    "Family Sessions",
    "Event Sessions",
    "Pet-and-OwnerPortraits",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0E1116),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0E1116),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
        ),
        title: const Text(
          "Pet Travel",
          style: TextStyle(color: Colors.white, fontSize: 17),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CmRepo().titleText("Select Your Pets"),
              const SizedBox(height: 5),
              const CmAddButton(title: "Add Your Pet"),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: CmDateField(
                        title: "Date",
                        label: "Select Date",
                        controller: _dateField),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: CmNumberField(
                      title: "Day",
                      controller: _dayField,
                      label: "Type Day",
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              CmNameEmailField(
                title: "Your Name",
                controller: _nameField,
                label: "Write your name",
                readOnly: false,
              ),
              const SizedBox(height: 20),
              CmNameEmailField(
                title: "Address",
                controller: _nameField,
                label: "Write your address",
                readOnly: false,
              ),
              const SizedBox(height: 20),
              CmNameEmailField(
                title: "Travel Details",
                controller: _travelDetailsField,
                label: "Write your travel details...",
                maxLines: 3,
                readOnly: false,
              ),
              const SizedBox(height: 20),
              CmDropDownField(
                title: "Country",
                dropList: _seasonTypeList,
                selectedVal: _selectedCountry,
                label: "Select your country",
              ),
              const SizedBox(height: 20),
              CmDropDownField(
                title: "Agency",
                dropList: _seasonTypeList,
                selectedVal: _selectedAgency,
                label: "Select travel agency",
              ),
              const SizedBox(height: 20),
              CmNameEmailField(
                title: "Additional Info",
                controller: _additionalField,
                label: "Write here.....",
                readOnly: false,
                maxLines: 3,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: const BorderSide(color: Colors.grey),
                    ),
                  ),
                  backgroundColor:
                      MaterialStateProperty.all(const Color(0xFF9D67EF)),
                ),
                child: const Center(
                    child: Text(
                  "Book Now",
                  style: TextStyle(color: Colors.white),
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _dayField.dispose();
    _nameField.dispose();
    _addressField.dispose();
    _travelDetailsField.dispose();
    _additionalField.dispose();
    super.dispose();
  }
}
