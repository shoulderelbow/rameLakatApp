import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:rame_lakat_app/bussines_logic/services/firebase/firebaseApi.dart';
import '../../data/models/Disease.dart';
import '../common/app_colors.dart';
import '../common/common_views.dart';

class IndividualDiseaseScreen extends StatefulWidget {
  const IndividualDiseaseScreen({Key? key}) : super(key: key);

  @override
  State<IndividualDiseaseScreen> createState() => _IndividualDiseaseScreenState();
}

class _IndividualDiseaseScreenState extends State<IndividualDiseaseScreen> {
  late Disease disease;

  Future<void> getDisease(String id) async {
    disease = await FirebaseApi.getDisease(id);
  }

  @override
  void initState() {
    getDisease('66QGVEWNcRhuynla4uGI');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      appBar: PreferredSize(preferredSize: Size.fromHeight(50), child: appbarWithBack(context)),
      body: FutureBuilder(
        future: getDisease('66QGVEWNcRhuynla4uGI'),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Container(
                height: MediaQuery.of(context).size.height,
                child: Center(
                  child: Container(
                    width: 100,
                    height: 100,
                    color: Colors.blueAccent,
                  ),
                ),
              );
            case ConnectionState.done:
              return SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            child: Image.network("https://static.toiimg.com/photo/msid-75449076/75449076.jpg?203156"),
                            height: 150,
                            width: 150,
                            margin: EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 5,
                            ),
                          ),
                          Flexible(child: Text(disease.name ?? '', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
                        ],
                      ),
                      Divider(color: AppColors.primaryDark, indent: 15, endIndent: 15, thickness: 1),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Description of the disease - Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "How to treat it".tr(),
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        alignment: Alignment.centerLeft,
                        child: Text(
                            "Description of how to treat it - Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."),
                      ),
                    ],
                  ),
                ),
              );
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
