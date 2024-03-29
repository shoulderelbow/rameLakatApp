import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../data/models/parameter.dart';
import '../common/app_colors.dart';
import '../common/app_strings.dart';
import 'medical_institutions.dart';

class MedicalInstitutionsWidget extends StatefulWidget {
  const MedicalInstitutionsWidget({Key? key}) : super(key: key);

  @override
  State<MedicalInstitutionsWidget> createState() => _MedicalInstitutionsWidgetState();
}

class _MedicalInstitutionsWidgetState extends State<MedicalInstitutionsWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _titleHeader(),
          SizedBox(height: 10),
          Card(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            elevation: 5,
            shadowColor: AppColors.primaryColorOp01,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 15),
              child: TextField(
                autofocus: false,
                style: const TextStyle(color: AppColors.commonTextColor, fontSize: 18),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    suffixIcon: Icon(
                      Icons.search_outlined,
                      color: Colors.black.withOpacity(0.3),
                    ),
                    contentPadding: const EdgeInsets.only(left: 5, bottom: 16, top: 16, right: 15),
                    hintStyle: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400, color: Colors.black.withOpacity(0.3)),
                    hintText: AppStrings.searchText),
                onChanged: (String searchedText) {
                  filterInstitutions = [];
                  for (int i = 0; i < institutions.length; i++) {
                    if (institutions[i].name?.toLowerCase().contains(searchedText.toLowerCase()) ?? false) {
                      filterInstitutions.add(institutions[i]);
                    }
                  }
                  setState(() {});
                },
              ),
            ),
          ),
          filterInstitutions.length == 0 ? Text("Nema rezultata pretrage", textAlign: TextAlign.center, style: TextStyle(fontSize: 20, color: Colors.black26)) :
          Container(
              width: 400,
              height: 470,
              child: _allInstitutionsContainer()),
        ],
      ),
    );
  }
}
Widget _titleHeader() => Container(
  margin: EdgeInsets.only(left: 20),
  height: 25.0,
  alignment: Alignment.bottomLeft,
  child: Text(
    "Medical institutions".tr(),
    style: TextStyle(
      fontSize: 25,
      fontWeight: FontWeight.w700,
    ),
  ),
);

Widget _allInstitutionsContainer() => ListView.builder(
  scrollDirection: Axis.horizontal,
  shrinkWrap: true,
  itemCount: filterInstitutions.length,
  itemBuilder: (BuildContext context, int index) {
    return InkWell(
      radius: 0,
      onTap: () {
        final parameter = Parameter(id: institutions[index].uniqueId ?? '');
        // Navigator.of(context).pushNamed(
        //   "/individual_institution",
        //   arguments: parameter,
        // );
      },
      child: Container(
        width: 280,
        height: 280,
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 250,
                height: 280,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black,
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(filterInstitutions[index].pictureLocation ?? ''),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 5, top: 10),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 8.0, left: 8, right: 8),
                      child: Text(
                        filterInstitutions[index].name ?? " ",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 20),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 8.0, left: 8, right: 8),
                      child: Text(
                        filterInstitutions[index].adress ?? ' ',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black.withOpacity(0.4), fontWeight: FontWeight.w300, fontSize: 14),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      filterInstitutions[index].shortDescription ?? " ",
                      style: TextStyle(color: Colors.black.withOpacity(0.4), fontWeight: FontWeight.w300, fontSize: 14),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  },
);