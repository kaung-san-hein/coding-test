import 'package:flutter/material.dart';
import '../screens/patient_detail.dart';
import '../utils/datetime_util.dart';
import '../db/union_myan_db.dart';
import '../models/patient_model.dart';
import '../screens/patient_form.dart';
import '../widgets/my_button.dart';
import '../constants/theme.dart';

class Patients extends StatefulWidget {
  const Patients({Key? key}) : super(key: key);

  @override
  State<Patients> createState() => _PatientsState();
}

class _PatientsState extends State<Patients> {
  List<Patient> patients = [];
  bool isLoading = false;

  @override
  void initState() {
    refreshPatient();
    super.initState();
  }

  Future refreshPatient() async {
    setState(() => isLoading = true);

    patients = await UMDb.instance.readAllPatients();

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Patients',
          style: TextStyle(
            color: UMColors.white,
          ),
        ),
        backgroundColor: UMColors.primary,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: UMColors.white),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                child: SizedBox(
                  width: 130.0,
                  height: 40.0,
                  child: MyButton(
                    onPressed: refreshPatient,
                    label: 'Refresh',
                    icon: Icons.refresh,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0, top: 8.0),
                child: SizedBox(
                  width: 100.0,
                  height: 40.0,
                  child: MyButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PatientForm(),
                        ),
                      );
                    },
                    label: 'New',
                    icon: Icons.add,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: patients.length,
                itemBuilder: (BuildContext context, index) {
                  final Patient patient = patients[index];

                  return GestureDetector(
                    onTap: () async {
                      Patient result =
                      await UMDb.instance.readPatient(patient.id!);
                      setState(() {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                PatientDetail(patient: result),
                          ),
                        );
                      });
                    },
                    child: Card(
                      elevation: 1.0,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              'Name: ${patient.name}',
                              style: const TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                            const SizedBox(height: 3.0),
                            Text(
                              'Sex: ${patient.sex}',
                              style: const TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                            const SizedBox(height: 3.0),
                            Text(
                              'Age: ${patient.age}',
                              style: const TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                            const SizedBox(height: 3.0),
                            Text(
                              'Refer Date: ${convertDateToLocal(patient.referDate.toString())}',
                              style: const TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
