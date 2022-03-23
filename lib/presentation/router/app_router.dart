import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rame_lakat_app/presentation/dashboard/dashboard_screen.dart';
import 'package:rame_lakat_app/presentation/diseases/all_diseases.dart';
import 'package:rame_lakat_app/presentation/login/login_bloc.dart';
import 'package:rame_lakat_app/presentation/login/login_screen.dart';
import 'package:rame_lakat_app/presentation/medical_institutions/medical_institutions.dart';

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
      default:
        return null;
    }
  }
}
