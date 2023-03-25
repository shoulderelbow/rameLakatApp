import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:rame_lakat_app/bussines_logic/services/firebase/firebaseApi.dart';
import 'package:rame_lakat_app/presentation/medical_institutions/medical_institutions_widget.dart';
import '../../data/models/Doctor.dart';
import '../../data/models/parameter.dart';
import '../common/app_colors.dart';
import '../common/app_strings.dart';
import '../common/common_views.dart';
import 'package:rame_lakat_app/data/models/Institution.dart';

import '../diseases/all_diseases.dart';

List<Institution> institutions = [];
List<Institution> filterInstitutions = [];

class MedicalInstitutions extends StatefulWidget {
  const MedicalInstitutions({Key? key}) : super(key: key);

  @override
  State<MedicalInstitutions> createState() => _MedicalInstitutionsState();
}

class _MedicalInstitutionsState extends State<MedicalInstitutions> {
  Future<void> getInstitutions() async {
    institutions = await FirebaseApi.getInstitutions();
    filterInstitutions = await FirebaseApi.getInstitutions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      appBar: PreferredSize(preferredSize: Size.fromHeight(50), child: appbarWithBack(context)),
      body: FutureBuilder(
        future: getInstitutions(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(
                  child: CircularProgressIndicator(
                color: Colors.black,
                value: 50,
              ));
            case ConnectionState.done:
              return MedicalInstitutionsWidget();
            default:
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return Text('Result: ${snapshot.data}');
              }
          }
        },
      ),
    );
  }
}


