import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../data/models/parameter.dart';
import '../common/app_colors.dart';
import '../common/app_strings.dart';
import 'all_diseases.dart';

class DiseasesWidget extends StatefulWidget {
  const DiseasesWidget({Key? key}) : super(key: key);

  @override
  State<DiseasesWidget> createState() => _DiseasesWidgetState();
}

class _DiseasesWidgetState extends State<DiseasesWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
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
                filterDiseases = [];
                for (int i = 0; i < diseases.length; i++) {
                  if (diseases[i].name?.contains(searchedText) ?? false) {
                    filterDiseases.add(diseases[i]);
                  }
                }
                setState(() {});
              },
            ),
          ),
        ),
        _allDiseasesContainer(),
      ],
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
      fontSize: 25,
      fontWeight: FontWeight.w700,
    ),
  ),
);

Widget _allDiseasesContainer() => Expanded(
  child: ListView.builder(
    scrollDirection: Axis.vertical,
    shrinkWrap: true,
    itemCount: filterDiseases.length,
    itemBuilder: (BuildContext context, int index) {
      return InkWell(
        radius: 0,
        onTap: () {
          final parameter = Parameter(id: diseases[index].uniqueId ?? '');
          Navigator.of(context).pushNamed(
            "/individual_disease",
            arguments: parameter,
          );
        },
        child: Container(
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(filterDiseases[index].pictureLocation ?? ""),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Padding(
                      padding: EdgeInsets.only(left: 5, top: 5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            filterDiseases[index].name ?? "",
                            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 20),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Type of disease",
                            style: TextStyle(color: Colors.black.withOpacity(0.4), fontWeight: FontWeight.w300, fontSize: 14),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            "How serious it is/short description",
                            style: TextStyle(color: Colors.black.withOpacity(0.4), fontWeight: FontWeight.w300, fontSize: 14),
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
                ),
              ],
            ),
          ),
        ),
      );
    },
  ),
);

