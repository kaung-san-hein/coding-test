import 'package:flutter/material.dart';
import '../db/union_myan_db.dart';
import '../models/patient_model.dart';
import '../utils/toast.dart';
import '../constants/theme.dart';
import '../widgets/my_button.dart';
import '../widgets/my_input.dart';

enum SignAndSymptom { fever, weightLoss, coughMoreThanTwoWeek }

class PatientForm extends StatefulWidget {
  const PatientForm({Key? key}) : super(key: key);

  @override
  State<PatientForm> createState() => _PatientFormState();
}

class _PatientFormState extends State<PatientForm> {
  final List<String> genders = [
    'Male',
    'Female',
  ];

  String? selectedGender;

  final List<String> townships = [
    'AMP',
    'AMT',
    'CAT',
    'CMT',
    'PTG',
    'PGT',
    'MHA',
  ];

  String? selectedTownship;

  final List<String> referFrom = [
    'Vol-1',
    'Vol-2',
  ];

  String? selectedReferFrom;

  final List<String> referTo = [
    'Union',
    'THD',
    'Other',
  ];

  String? selectedReferTo;

  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  SignAndSymptom signAndSymptom = SignAndSymptom.fever;
  String? referDate;

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  Container _buildDropdown(List<String> dataList, String? selectedData,
      String hintText, void Function(dynamic)? onChanged) {
    List<DropdownMenuItem<String>> items = [];
    for (String data in dataList) {
      DropdownMenuItem<String> item = DropdownMenuItem<String>(
        value: data,
        child: Text(data),
      );
      items.add(item);
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: UMColors.secondary),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15.0),
          topRight: Radius.zero,
          bottomLeft: Radius.circular(15.0),
          bottomRight: Radius.circular(15.0),
        ),
      ),
      child: DropdownButton<String>(
        hint: Text(
          'Please select $hintText',
          style: const TextStyle(
            fontSize: 14.0,
            color: UMColors.secondary,
          ),
        ),
        isExpanded: true,
        value: selectedData,
        items: items,
        onChanged: onChanged,
        icon: const Icon(
          Icons.arrow_drop_down,
          color: UMColors.secondary,
        ),
        iconSize: 42,
        underline: const SizedBox(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'New Patient',
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
                        MyInput(
                          placeholder: 'Name',
                          controller: _nameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 18.0),
                        _buildDropdown(genders, selectedGender, 'Sex', (value) {
                          setState(() {
                            selectedGender = value;
                          });
                        }),
                        const SizedBox(height: 18.0),
                        MyInput(
                          placeholder: 'Age',
                          controller: _ageController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter age';
                            }
                            if (int.parse(value) >= 120) {
                              return 'Age must be under 120';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 18.0),
                        SizedBox(
                          height: 45.0,
                          child: MyButton(
                            onPressed: () async {
                              DateTime? pickDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime(1998),
                                firstDate: DateTime(1998),
                                lastDate: DateTime(2030),
                              );
                              setState(() {
                                referDate =
                                    pickDate.toString().substring(0, 10);
                              });
                            },
                            label: referDate ?? 'Click Refer Date',
                          ),
                        ),
                        const SizedBox(height: 18.0),
                        _buildDropdown(townships, selectedTownship, 'Township',
                            (value) {
                          setState(() {
                            selectedTownship = value;
                          });
                        }),
                        const SizedBox(height: 18.0),
                        MyInput(
                          placeholder: 'Address',
                          controller: _addressController,
                          keyboardType: TextInputType.multiline,
                          minLines: 3,
                          maxLines: 5,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter address';
                            }
                            if (value.trim().length >= 40) {
                              return 'Address length must be less than 40';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 18.0),
                        _buildDropdown(
                            referFrom, selectedReferFrom, 'Refer From',
                            (value) {
                          setState(() {
                            selectedReferFrom = value;
                          });
                        }),
                        const SizedBox(height: 18.0),
                        _buildDropdown(referTo, selectedReferTo, 'Refer To',
                            (value) {
                          setState(() {
                            selectedReferTo = value;
                          });
                        }),
                        const SizedBox(height: 18.0),
                        const Text(
                          'Sign And Symptom',
                          style: TextStyle(
                            color: UMColors.black,
                          ),
                        ),
                        ListTile(
                          title: const Text('Fever'),
                          leading: Radio(
                            value: SignAndSymptom.fever,
                            groupValue: signAndSymptom,
                            onChanged: (SignAndSymptom? value) {
                              setState(() {
                                signAndSymptom = value!;
                              });
                            },
                          ),
                        ),
                        ListTile(
                          title: const Text('Weight Loss'),
                          leading: Radio(
                            value: SignAndSymptom.weightLoss,
                            groupValue: signAndSymptom,
                            onChanged: (SignAndSymptom? value) {
                              setState(() {
                                signAndSymptom = value!;
                              });
                            },
                          ),
                        ),
                        ListTile(
                          title: const Text('Cough More Than Two Week'),
                          leading: Radio(
                            value: SignAndSymptom.coughMoreThanTwoWeek,
                            groupValue: signAndSymptom,
                            onChanged: (SignAndSymptom? value) {
                              setState(() {
                                signAndSymptom = value!;
                              });
                            },
                          ),
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
                  onPressed: () async {
                    FocusManager.instance.primaryFocus?.unfocus();
                    if (_formKey.currentState!.validate()) {
                      String usedSignAndSymptom = '';
                      if (signAndSymptom == SignAndSymptom.fever) {
                        usedSignAndSymptom = 'fever';
                      } else if (signAndSymptom == SignAndSymptom.weightLoss) {
                        usedSignAndSymptom = 'weight loss';
                      } else {
                        usedSignAndSymptom = 'Cough More Than Two Week';
                      }

                      if (selectedGender != null) {
                        if (referDate != null) {
                          if (selectedTownship != null) {
                            if (selectedReferFrom != null) {
                              if (selectedReferTo != null) {
                                Patient patient = Patient(
                                  name: _nameController.text,
                                  sex: selectedGender!,
                                  age: int.parse(_ageController.text),
                                  referDate:
                                      DateTime.parse(referDate.toString()),
                                  township: selectedTownship!,
                                  address: _addressController.text,
                                  referFrom: selectedReferFrom!,
                                  referTo: selectedReferTo!,
                                  signAndSymptom: usedSignAndSymptom,
                                );

                                await UMDb.instance.createPatient(patient);

                                setState(() {
                                  _nameController.clear();
                                  selectedGender = null;
                                  _ageController.clear();
                                  referDate = null;
                                  selectedTownship = null;
                                  _addressController.clear();
                                  selectedReferFrom = null;
                                  selectedReferTo = null;
                                  showToast(context, "Successfully created");
                                });
                              } else {
                                showToast(context, "Please select refer to");
                              }
                            } else {
                              showToast(context, "Please select refer from");
                            }
                          } else {
                            showToast(context, "Please select township");
                          }
                        } else {
                          showToast(context, "Please pick refer date");
                        }
                      } else {
                        showToast(context, "Please select gender");
                      }
                    }
                  },
                  label: 'Create',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
