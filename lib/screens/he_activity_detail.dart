import 'package:flutter/material.dart';
import '../db/union_myan_db.dart';
import '../widgets/my_button.dart';
import '../models/he_activity_model.dart';
import '../constants/theme.dart';
import '../utils/datetime_util.dart';

class HEActivityDetail extends StatefulWidget {
  final HEActivity heActivity;

  const HEActivityDetail({
    Key? key,
    required this.heActivity,
  }) : super(key: key);

  @override
  State<HEActivityDetail> createState() => _HEActivityDetailState();
}

class _HEActivityDetailState extends State<HEActivityDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'HE Activity',
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
                      'Date: ${convertDateToLocal(widget.heActivity.date.toString())}',
                      style: const TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    const SizedBox(height: 5.0),
                    Text(
                      'Address: ${widget.heActivity.address}',
                      style: const TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    const SizedBox(height: 5.0),
                    Text(
                      'Volunteer: ${widget.heActivity.volunteer}',
                      style: const TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    const SizedBox(height: 5.0),
                    Text(
                      'HE Attendees: ${widget.heActivity.heAttendeesList}',
                      style: const TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    const SizedBox(height: 5.0),
                    Text(
                      'Male: ${widget.heActivity.male}',
                      style: const TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    const SizedBox(height: 5.0),
                    Text(
                      'Female: ${widget.heActivity.female}',
                      style: const TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    const SizedBox(height: 15.0),
                    MyButton(
                      onPressed: () async {
                        await UMDb.instance.delete(widget.heActivity.id!);
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
