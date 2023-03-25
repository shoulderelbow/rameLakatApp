import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../data/models/parameter.dart';
import '../common/app_colors.dart';
import '../common/app_strings.dart';
import '../common/common_views.dart';
import 'dashboard_screen.dart';
import 'drawer.dart';

class Dashboard_screen_widget extends StatefulWidget {
  const Dashboard_screen_widget({Key? key}) : super(key: key);

  @override
  State<Dashboard_screen_widget> createState() => _Dashboard_screen_widgetState();
}

class _Dashboard_screen_widgetState extends State<Dashboard_screen_widget> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          toolbarView(AppStrings.newsLabel.tr()),
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
                  filterNews = [];
                  for (int i = 0; i < news.length; i++) {
                    if ((news[i].name?.toLowerCase().contains(searchedText.toLowerCase())) ?? false || (news[i].type?.toLowerCase().contains(searchedText.toLowerCase())  ?? false )) {
                      filterNews.add(news[i]);
                    }
                  }
                  setState(() {});
                },
              ),
            ),
          ),
          _allNewsContainer(),
        ],
      ),
    );
  }
}

Widget _allNewsContainer() => Expanded(
      child: Container(
        child: ListView.builder(
          itemCount: filterNews.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.only(top: 7, left: 7, right: 7, bottom: 0),
              child: Column(
                children: [
                  Container(
                    height: 255,
                    decoration: BoxDecoration(
                      image: DecorationImage(alignment: Alignment.topCenter, image: NetworkImage(filterNews[index].pictureLocation ?? ''), fit: BoxFit.fitWidth),
                    ),
                    child: InkWell(
                      onTap: () {
                        final parameter = Parameter(id: filterNews[index].uniqueId ?? '');
                        Navigator.of(context).pushNamed('/individual_news', arguments: parameter);
                      },
                    ),
                  ),
                  Container(
                    height: 120,
                    decoration: BoxDecoration(color: Colors.white),
                    child: Padding(
                      padding: EdgeInsets.only(top: 12.0, left: 8, right: 8),
                      child: Column(
                        children: [
                          Text(
                            filterNews[index].name?.tr() ?? '',
                            style: TextStyle(color: Color(0xFF0B223D), fontSize: 17, fontWeight: FontWeight.w500), textAlign: TextAlign.left, maxLines: 3, overflow: TextOverflow.ellipsis,
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 30.0),
                            child: Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "${filterNews[index].date?.day.toString()}.${filterNews[index].date?.month.toString()}.${filterNews[index].date?.year.toString()}",
                                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.black),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
