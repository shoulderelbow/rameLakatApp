import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../bussines_logic/services/firebase/firebaseApi.dart';
import '../../data/models/Disease.dart';
import '../../data/models/Simposium.dart';
import '../common/app_colors.dart';
import '../common/common_views.dart';

List<Simposium> simposiums = [];

class AllSimposiumsScreen extends StatefulWidget {
  const AllSimposiumsScreen({Key? key}) : super(key: key);

  @override
  State<AllSimposiumsScreen> createState() => _AllSimposiumsState();
}

class _AllSimposiumsState extends State<AllSimposiumsScreen> {

  void getSimposiums() async {
    simposiums = await FirebaseApi.getSimposiums();
  }

  @override
  void initState()  {
    getSimposiums();
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
          _allSimposiumsContainer(),
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
    'Symposiums'.tr(),
    style: TextStyle(
      fontSize: 20,
    ),
  ),
);

Widget _allSimposiumsContainer() => Expanded(
  child: Container(
    decoration: BoxDecoration(
      border: Border(
        bottom: BorderSide(width: 0.5, color: Colors.black),
      ),
    ),
    child: ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: simposiums.length,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          radius: 0,
          onTap: () {
            //Navigator.of(context).pushNamed("/individual_disease", arguments: {'id': diseases[index].uniqueId},);
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
                      image: NetworkImage(simposiums[index].pictureLocation ?? ""),
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
                          simposiums[index].name ?? "",
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
                          simposiums[index].subject ?? '',
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.4),
                              fontWeight: FontWeight.w300,
                              fontSize: 14),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          simposiums[index].date ?? '',
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