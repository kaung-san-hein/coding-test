import 'package:flutter/material.dart';
import '../utils/toast.dart';
import '../db/union_myan_db.dart';
import '../models/he_activity_model.dart';
import '../constants/theme.dart';
import '../widgets/my_button.dart';
import '../widgets/my_input.dart';

class HEActivityForm extends StatefulWidget {
  const HEActivityForm({Key? key}) : super(key: key);

  @override
  State<HEActivityForm> createState() => _HEActivityFormState();
}

class _HEActivityFormState extends State<HEActivityForm> {
  final List<String> volunteers = [
    'Vol-1',
    'Vol-2',
  ];

  String? selectedVolunteer;

  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _heAttendeesController = TextEditingController();
  final TextEditingController _maleController = TextEditingController();
  final TextEditingController _femaleController = TextEditingController();
  String? date;

  @override
  void dispose() {
    _addressController.dispose();
    _heAttendeesController.dispose();
    _maleController.dispose();
    _femaleController.dispose();
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
          'New HE Activity',
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
                        SizedBox(
                          height: 45.0,
                          child: MyButton(
                            onPressed: () async {
                              DateTime? pickDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1998),
                                lastDate: DateTime(2030),
                              );
                              setState(() {
                                date = pickDate.toString().substring(0, 10);
                              });
                            },
                            label: date ?? 'Click Date',
                          ),
                        ),
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
                            volunteers, selectedVolunteer, 'Volunteer',
                            (value) {
                          setState(() {
                            selectedVolunteer = value;
                          });
                        }),
                        const SizedBox(height: 18.0),
                        MyInput(
                          placeholder: 'HE Attendees List',
                          controller: _heAttendeesController,
                          keyboardType: TextInputType.multiline,
                          minLines: 3,
                          maxLines: 5,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter HE Attendees List';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 18.0),
                        MyInput(
                          placeholder: 'Male',
                          controller: _maleController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter male';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 18.0),
                        MyInput(
                          placeholder: 'Female',
                          controller: _femaleController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter female';
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
                  onPressed: () async {
                    FocusManager.instance.primaryFocus?.unfocus();
                    if (_formKey.currentState!.validate()) {
                      if (date != null) {
                        if (selectedVolunteer != null) {
                          HEActivity heActivity = HEActivity(
                            date: DateTime.parse(date!),
                            address: _addressController.text,
                            volunteer: selectedVolunteer!,
                            heAttendeesList: _heAttendeesController.text,
                            male: int.parse(_maleController.text),
                            female: int.parse(_femaleController.text),
                          );

                          await UMDb.instance.create(heActivity);

                          setState(() {
                            date = null;
                            selectedVolunteer = null;
                            _addressController.clear();
                            _heAttendeesController.clear();
                            _maleController.clear();
                            _femaleController.clear();
                            showToast(context, "Successfully created");
                          });
                        } else {
                          showToast(context, "Please select volunteer");
                        }
                      } else {
                        showToast(context, "Please pick date");
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
