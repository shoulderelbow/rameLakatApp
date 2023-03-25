import 'package:flutter/material.dart';
import 'package:rame_lakat_app/data/models/parameter.dart';
import 'package:rame_lakat_app/presentation/dashboard/dashboard_screen.dart';
import 'package:rame_lakat_app/presentation/dashboard/individual_news.dart';
import 'package:rame_lakat_app/presentation/diseases/all_diseases.dart';
import 'package:rame_lakat_app/presentation/diseases/individual_disease.dart';
import 'package:rame_lakat_app/presentation/login/login_screen.dart';
import 'package:rame_lakat_app/presentation/medical_institutions/individual_medical_institution.dart';
import 'package:rame_lakat_app/presentation/medical_institutions/medical_institutions.dart';
import 'package:rame_lakat_app/presentation/questionnaire/questionnaire_screen.dart';
import 'package:rame_lakat_app/presentation/registration/registration_screen.dart';
import 'package:rame_lakat_app/presentation/simposiums/all_simposiums.dart';
import 'package:rame_lakat_app/presentation/survey/individual_surveys.dart';
import 'package:rame_lakat_app/presentation/survey/survey_results.dart';
import '../dashboard/my_profile.dart';
import '../podcasts_and_materials/all_podcasts_and_mateirals.dart';
import '../simposiums/individual_symposiums.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case '/dashboard':
        return MaterialPageRoute(builder: (_) => DashboardScreen());
      case '/diseases':
        return MaterialPageRoute(builder: (_) => AllDiseasesScreen());
      case '/institutions':
        return MaterialPageRoute(builder: (_) => MedicalInstitutions());
      case '/individual_disease':
        {
          if (routeSettings.arguments is Parameter) {
            Parameter par = routeSettings.arguments as Parameter;
            return MaterialPageRoute(
              builder: (_) => IndividualDiseaseScreen(
                parameter: par,
              ),
            );
          }
          else{
            return MaterialPageRoute(
              builder: (_) => IndividualDiseaseScreen(
                parameter: Parameter(id: ''),
              ),
            );
          }
        }
      case '/individual_symposiums':
        {
          if (routeSettings.arguments is Parameter) {
            Parameter par = routeSettings.arguments as Parameter;
            return MaterialPageRoute(
              builder: (_) => IndividualSymposiumsScreen(
                parameter: par,
              ),
            );
          }
          else{
            return MaterialPageRoute(
              builder: (_) => IndividualSymposiumsScreen(
                parameter: Parameter(id: ''),
              ),
            );
          }
        }
      case '/individual_institution':
        {
          if (routeSettings.arguments is Parameter) {
            Parameter par = routeSettings.arguments as Parameter;
            return MaterialPageRoute(builder: (_) =>
                IndividualMedicalInstitution(
                  parameter: par,
                ),
            );
          } else {
            return MaterialPageRoute(
              builder: (_) => IndividualMedicalInstitution(
                parameter: Parameter(id: ''),
              ),
            );
          }
          }
      case '/questionnaire':
        return MaterialPageRoute(builder: (_) => QuestionnaireScreen());
      case '/registration':
        return MaterialPageRoute(builder: (_) => RegistrationScreen());
      case '/my_profile':
        {
          if (routeSettings.arguments is Parameter) {
            Parameter par = routeSettings.arguments as Parameter;
            return MaterialPageRoute(builder: (_) =>
                MyProfile(
                  parameter: par,
                ),
            );
          } else {
            return MaterialPageRoute(
              builder: (_) => MyProfile(
                parameter: Parameter(id: ''),
              ),
            );
          }
        }
      case '/simposiums':
        return MaterialPageRoute(builder: (_) => AllSimposiumsScreen());
      case '/individual_surveys':
        {
          if (routeSettings.arguments is Parameter) {
            Parameter par = routeSettings.arguments as Parameter;
            return MaterialPageRoute(builder: (_) =>
                IndividualSurvey(
                  parameter: par,
                ),
            );
          } else {
            return MaterialPageRoute(
              builder: (_) => IndividualSurvey(
                parameter: Parameter(id: ''),
              ),
            );
          }
        }
      case '/podcasts_and_materials':
        return MaterialPageRoute(builder: (_) => AllPodcastsScreen());
      case '/survey_results':
        return MaterialPageRoute(builder: (_) => SurveyResults());
      case '/individual_news':
        {
          if (routeSettings.arguments is Parameter) {
            Parameter par = routeSettings.arguments as Parameter;
            return MaterialPageRoute(builder: (_) =>
                IndividualNews(
                  parameter: par,
                ),
            );
          } else {
            return MaterialPageRoute(
              builder: (_) => IndividualNews(
                parameter: Parameter(id: ''),
              ),
            );
          }
        }
      default:
        return null;
    }
  }
}
