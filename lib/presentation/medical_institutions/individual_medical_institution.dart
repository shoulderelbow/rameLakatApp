import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:rame_lakat_app/data/models/Institution.dart';
import '../../bussines_logic/services/firebase/firebaseApi.dart';
import '../common/app_colors.dart';
import '../common/common_views.dart';


class IndividualMedicalInstitution extends StatefulWidget {
  const IndividualMedicalInstitution({Key? key}) : super(key: key);

  @override
  State<IndividualMedicalInstitution> createState() => _IndividualMedicalInstitutionState();
}

class _IndividualMedicalInstitutionState extends State<IndividualMedicalInstitution> {
  late Institution? institution;

  Future<void> getInstitution(String id) async {
    institution = await FirebaseApi.getInstitution(id);
  }

  @override
  void initState() {
    getInstitution('tSgU5NPmUKSZq3C1KXds');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      appBar: PreferredSize(preferredSize: const Size.fromHeight(50), child: appbarWithBack(context)),
      body: FutureBuilder(
        future: getInstitution('tSgU5NPmUKSZq3C1KXds'),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Container(
                height: MediaQuery.of(context).size.height,
                child: Center(
                  child: Container(
                    width: 100,
                    height: 100,
                    color: Colors.red,
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
                            child: Image.network(
                                "https://www.dignityhealth.org/content/dignity-health/en/socal/locations/northridgehospital/_jcr_content/root/responsivegrid-body-layout/responsivegrid/cshhero_copy_copy/heroimage/desktop.coreimg.png/1635982797290/socal-nhmc-hospital-image-2.png"),
                            height: 150,
                            width: 150,
                            margin: const EdgeInsets.symmetric(
                              horizontal: 15,
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
                                    institution?.name ?? ' ',
                                    style: TextStyle(fontSize: 25,fontFamily: 'ChakraPetch', fontWeight: FontWeight.bold),
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.location_on),
                                      Text(
                                        "Hospital location".tr(),
                                        style: TextStyle(fontSize: 15, fontFamily: 'ChakraPetch', fontWeight: FontWeight.w700, fontStyle: FontStyle.italic ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.lock_clock),
                                      Text(
                                        "Working time of a hospital".tr(),
                                        style: TextStyle(fontSize: 15,fontFamily: 'ChakraPetch', fontWeight: FontWeight.w700, fontStyle: FontStyle.italic ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.phone),
                                      Text(
                                        "Contact".tr(),
                                        style: TextStyle(fontSize: 15, fontFamily: 'ChakraPetch', fontWeight: FontWeight.w700, fontStyle: FontStyle.italic ),
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
                            child: Text(
                              "Description of the hospital - Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                            style: TextStyle(fontSize: 15),),
                          ),
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
