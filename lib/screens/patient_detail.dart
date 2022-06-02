import 'package:flutter/material.dart';
import '../constants/theme.dart';
import '../db/union_myan_db.dart';
import '../models/patient_model.dart';
import '../utils/datetime_util.dart';
import '../widgets/my_button.dart';

class PatientDetail extends StatefulWidget {
  final Patient patient;

  const PatientDetail({Key? key, required this.patient,}) : super(key: key);

  @override
  State<PatientDetail> createState() => _PatientDetailState();
}

class _PatientDetailState extends State<PatientDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Patient',
          style: TextStyle(
            color: UMColors.white,
          ),
        ),
        backgroundColor: UMColors.primary,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: UMColors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Card(
              elevation: 1.0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      'Name: ${widget.patient.name}',
                      style: const TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    const SizedBox(height: 15.0),
                    Text(
                      'Sex: ${widget.patient.sex}',
                      style: const TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    const SizedBox(height: 15.0),
                    Text(
                      'Age: ${widget.patient.age}',
                      style: const TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    const SizedBox(height: 15.0),
                    Text(
                      'Refer Date: ${convertDateToLocal(widget.patient.referDate.toString())}',
                      style: const TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    const SizedBox(height: 15.0),
                    Text(
                      'Township: ${widget.patient.township}',
                      style: const TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    const SizedBox(height: 15.0),
                    Text(
                      'Address: ${widget.patient.address}',
                      style: const TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    const SizedBox(height: 15.0),
                    Text(
                      'Refer From: ${widget.patient.referFrom}',
                      style: const TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    const SizedBox(height: 15.0),
                    Text(
                      'Refer To: ${widget.patient.referTo}',
                      style: const TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    const SizedBox(height: 15.0),
                    Text(
                      'Sign And Symptom: ${widget.patient.signAndSymptom}',
                      style: const TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    const SizedBox(height: 15.0),
                    MyButton(
                      onPressed: () async {
                        await UMDb.instance.deletePatient(widget.patient.id!);
                        setState(() {
                          Navigator.pop(context);
                        });
                      },
                      label: 'Delete',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
