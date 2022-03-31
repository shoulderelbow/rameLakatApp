import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rame_lakat_app/presentation/dashboard/dashboard_screen.dart';
import 'package:rame_lakat_app/presentation/diseases/all_diseases.dart';
import 'package:rame_lakat_app/presentation/diseases/individual_disease.dart';
import 'package:rame_lakat_app/presentation/doctors/doctor_listings.dart';
import 'package:rame_lakat_app/presentation/login/login_bloc.dart';
import 'package:rame_lakat_app/presentation/login/login_screen.dart';
import 'package:rame_lakat_app/presentation/medical_institutions/individual_medical_institution.dart';
import 'package:rame_lakat_app/presentation/medical_institutions/medical_institutions.dart';
import 'package:rame_lakat_app/presentation/questionnaire/questionnaire_screen.dart';
import 'package:rame_lakat_app/presentation/registration/registration_screen.dart';

class AppRouter {
  final LoginBloc loginBloc = LoginBloc();

  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                value: loginBloc, child: const LoginScreen()));
      case '/dashboard':
        return MaterialPageRoute(builder: (_)=> const DashboardScreen());
      case '/diseases':
        return MaterialPageRoute(builder: (_)=> const AllDiseasesScreen());
      case '/institutions':
        return MaterialPageRoute(builder: (_)=> const MedicalInstitutions());
      case '/individual_disease':
        return MaterialPageRoute(builder: (_)=> const IndividualDiseaseScreen());
      case '/individual_institution':
        return MaterialPageRoute(builder: (_)=> const IndividualMedicalInstitution());
      case '/questionnaire':
        return MaterialPageRoute(builder: (_)=> const QuestionnaireScreen());
      case '/doctors':
        return MaterialPageRoute(builder: (_)=> const DoctorListingScreen());
      case '/registration':
        return MaterialPageRoute(builder: (_)=> RegistrationScreen());
      default:
        return null;
    }
  }
}
