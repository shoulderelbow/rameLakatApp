import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:rame_lakat_app/presentation/simposiums/symposium_widget.dart';
import '../../bussines_logic/services/firebase/firebaseApi.dart';
import '../../data/models/Disease.dart';
import '../../data/models/Simposium.dart';
import '../common/app_colors.dart';
import '../common/app_strings.dart';
import '../common/common_views.dart';

List<Simposium> simposiums = [];
List<Simposium> filterSimposiums = [];

class AllSimposiumsScreen extends StatefulWidget {
  const AllSimposiumsScreen({Key? key}) : super(key: key);

  @override
  State<AllSimposiumsScreen> createState() => _AllSimposiumsState();
}

class _AllSimposiumsState extends State<AllSimposiumsScreen> {
  Future<void> getSimposiums() async {
    simposiums = await FirebaseApi.getSimposiums();
    filterSimposiums = await FirebaseApi.getSimposiums();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      appBar: PreferredSize(preferredSize: const Size.fromHeight(50), child: appbarWithBack(context)),
      body: FutureBuilder(
          future: getSimposiums(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(
                    child: CircularProgressIndicator(
                  color: Colors.black,
                  value: 50,
                ));
              case ConnectionState.done:
                return SymposiumWidget();
              default:
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return Text('Result: ${snapshot.data}');
                }

            }
          }),
    );
  }
}


