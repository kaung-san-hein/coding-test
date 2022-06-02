import 'package:flutter/material.dart';
import '../screens/he_activity_detail.dart';
import '../utils/datetime_util.dart';
import '../db/union_myan_db.dart';
import '../models/he_activity_model.dart';
import '../screens/he_activity_form.dart';
import '../constants/theme.dart';
import '../widgets/my_button.dart';

class HEActivities extends StatefulWidget {
  const HEActivities({Key? key}) : super(key: key);

  @override
  State<HEActivities> createState() => _HEActivitiesState();
}

class _HEActivitiesState extends State<HEActivities> {
  List<HEActivity> heActivities = [];
  bool isLoading = false;

  @override
  void initState() {
    refreshHEActivity();
    super.initState();
  }

  Future refreshHEActivity() async {
    setState(() => isLoading = true);

    heActivities = await UMDb.instance.readAllHEActivities();

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'HE Activities',
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
                    onPressed: refreshHEActivity,
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
                          builder: (context) => const HEActivityForm(),
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
                itemCount: heActivities.length,
                itemBuilder: (BuildContext context, index) {
                  final HEActivity heActivity = heActivities[index];

                  return GestureDetector(
                    onTap: () async {
                      HEActivity result =
                          await UMDb.instance.readHEActivity(heActivity.id!);
                      setState(() {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                HEActivityDetail(heActivity: result),
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
                              'Date: ${convertDateToLocal(heActivity.date.toString())}',
                              style: const TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                            const SizedBox(height: 3.0),
                            Text(
                              'Volunteer: ${heActivity.volunteer}',
                              style: const TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                            const SizedBox(height: 3.0),
                            Text(
                              'Male: ${heActivity.male}',
                              style: const TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                            const SizedBox(height: 3.0),
                            Text(
                              'Female: ${heActivity.female}',
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
