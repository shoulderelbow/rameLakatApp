import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:rame_lakat_app/data/models/parameter.dart';
import 'package:rame_lakat_app/presentation/diseases/diseases_widget.dart';
import '../../bussines_logic/services/firebase/firebaseApi.dart';
import '../../data/models/Disease.dart';
import '../common/app_colors.dart';
import '../common/app_strings.dart';
import '../common/common_views.dart';


List<Disease> diseases = [];
List<Disease> filterDiseases = [];

class AllDiseasesScreen extends StatefulWidget {
  const AllDiseasesScreen({Key? key}) : super(key: key);

  @override
  State<AllDiseasesScreen> createState() => _AllDiseasesScreenState();
}

class _AllDiseasesScreenState extends State<AllDiseasesScreen> {
  Future<void> getDiseases() async {
    diseases = await FirebaseApi.getDiseases();
    filterDiseases = await FirebaseApi.getDiseases();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      appBar: PreferredSize(preferredSize: const Size.fromHeight(50), child: appbarWithBack(context)),
      body: FutureBuilder(
        future: getDiseases(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator(color: Colors.black, value: 50, ));
            case ConnectionState.done:
              return DiseasesWidget();
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
