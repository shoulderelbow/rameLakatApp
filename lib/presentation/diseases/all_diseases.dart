import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../bussines_logic/services/firebase/firebaseApi.dart';
import '../../data/models/Disease.dart';
import '../common/app_colors.dart';
import '../common/common_views.dart';

List<Disease> diseases = [];

class AllDiseasesScreen extends StatefulWidget {
  const AllDiseasesScreen({Key? key}) : super(key: key);

  @override
  State<AllDiseasesScreen> createState() => _AllDiseasesScreenState();
}

class _AllDiseasesScreenState extends State<AllDiseasesScreen> {

  void getDiseases() async {
      diseases = await FirebaseApi.getDiseases();
  }

  @override
  void initState()  {
    getDiseases();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: appbarWithBack(context)),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _titleHeader(),
          searchTextField(),
          _allDiseasesContainer(),
        ],
      ),
    );
  }
}

Widget _titleHeader() => Container(
  margin: EdgeInsets.only(left: 20),
      height: 25.0,
      alignment: Alignment.centerLeft,
      child: Text(
        'Diseases'.tr(),
        style: TextStyle(
          fontSize: 20,
        ),
      ),
    );

Widget _allDiseasesContainer() => Expanded(
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 0.5, color: Colors.black),
          ),
        ),
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: diseases.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              radius: 0,
              onTap: () {
                Navigator.of(context).pushNamed("/individual_disease", arguments: {'id': diseases[index].uniqueId},);
              },
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(diseases[index].pictureLocation ?? ""),
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             Text(
                              diseases[index].name ?? "",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                             SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Type of disease",
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.4),
                                  fontWeight: FontWeight.w300,
                                  fontSize: 14),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              "How serious it is/short description",
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.4),
                                  fontWeight: FontWeight.w300,
                                  fontSize: 14),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                             SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );


