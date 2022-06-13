import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:rame_lakat_app/data/models/Institution.dart';
import 'package:rame_lakat_app/presentation/medical_institutions/medical_institutions.dart';
import '../../bussines_logic/services/firebase/firebaseApi.dart';
import '../../data/models/Doctor.dart';
import '../../data/models/parameter.dart';
import '../common/app_colors.dart';
import '../common/common_views.dart';


late Institution? institution;
List<Doctor> doctors = [];

class IndividualMedicalInstitution extends StatefulWidget {
  const IndividualMedicalInstitution({Key? key, required this.parameter}) : super(key: key);
  final Parameter parameter;


  @override
  State<IndividualMedicalInstitution> createState() => _IndividualMedicalInstitutionState();
}

class _IndividualMedicalInstitutionState extends State<IndividualMedicalInstitution> {


  Future<void> getInstitution(String id) async {
    institution = await FirebaseApi.getInstitution(id);
    doctors = await FirebaseApi.getDoctors(id);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      appBar: PreferredSize(preferredSize: const Size.fromHeight(50), child: appbarWithBack(context)),
      body: FutureBuilder(
        future: getInstitution(widget.parameter.id),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return CircularProgressIndicator();
            case ConnectionState.done:
              return SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            child: Image.network(institution?.pictureLocation ?? ''),
                            height: 150,
                            width: 150,
                            margin:  EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: 150,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    institution?.name ?? '',
                                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.location_on),
                                      Padding(
                                        padding: EdgeInsets.only(left: 2.0, right: 2),
                                        child: Text(
                                          '${institution?.adress}',
                                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.lock_clock),
                                      Padding(
                                        padding: EdgeInsets.only(left: 4.0),
                                        child: Text(
                                          "${institution?.workingTimes}",
                                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.phone),
                                      Padding(
                                        padding: EdgeInsets.only(left: 4.0),
                                        child: Text(
                                          "${institution?.phone}",
                                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Divider(color: AppColors.primaryDark, indent: 15, endIndent: 15, thickness: 1),
                      Column(
                        children: [
                          Container(
                          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                          alignment: Alignment.centerLeft,
                          child: Text("Description of a hospital".tr(), style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),),),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                            alignment: Alignment.centerLeft,
                            child: Text( "${institution?.longDescription}",
                            style: TextStyle(fontSize: 15),),
                          ),
                          Divider(color: AppColors.primaryDark, indent: 15, endIndent: 15, thickness: 1),
                          Container(
                              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                              alignment: Alignment.centerLeft,
                              child: Text("Available doctors".tr(), style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),)),
                          Stack(
                            children: [
                            Align(alignment: Alignment.centerLeft),
                                Container(
                                  height: 300,
                                  child:
                                    _availableDoctorsContainer(),
                                ),
                          ],),
                        ],
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

Widget _availableDoctorsContainer() => ListView.builder(
  scrollDirection: Axis.vertical,
  shrinkWrap: true,
  itemCount: doctors.length,
  itemBuilder: (BuildContext context, int index) {
    return InkWell(
      radius: 0,
      onTap: () {},
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 80,
                height: 82,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(doctors[index].pictureLocation ?? ''),
                  ),
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
                        doctors[index].name ?? ' ',
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w800, fontSize: 16),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        doctors[index].fieldOfExpertise ?? '',
                        style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w800, fontSize: 14),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        doctors[index].phone ?? '',
                        style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w800, fontSize: 14),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  },
);

