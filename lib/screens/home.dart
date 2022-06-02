import 'package:flutter/material.dart';
import '../constants/route.dart';
import '../db/union_myan_db.dart';
import '../widgets/my_button.dart';
import '../constants/theme.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void dispose() {
    UMDb.instance.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home Page',
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
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            SizedBox(
              height: 50.0,
              child: MyButton(
                onPressed: (){
                  Navigator.pushNamed(context, Routes.patients);
                },
                label: 'Patient Referral (List & Form )',
                icon: Icons.list,
              ),
            ),
            const SizedBox(height: 10.0),
            SizedBox(
              height: 50.0,
              child: MyButton(
                onPressed: (){
                  Navigator.pushNamed(context, Routes.heActivities);
                },
                label: 'HE Activity (List & Form)',
                icon: Icons.list,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
