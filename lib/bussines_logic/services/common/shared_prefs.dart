import 'package:get_it/get_it.dart';
import 'package:rame_lakat_app/data/models/User.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  SharedPrefs._private();

  SharedPreferences? _instance;

  factory SharedPrefs() {
    if (!GetIt.instance.isRegistered<SharedPrefs>()) {
      GetIt.instance.registerSingleton(SharedPrefs._private());
    }
    return GetIt.instance<SharedPrefs>();
  }

  void init() async {
    _instance = await SharedPreferences.getInstance();
  }

  void setUser(User user) async {
    await _instance?.setString('firstName', user.firstName);
    await _instance?.setString('lastName', user.lastName);
    await _instance?.setString('email', user.email);
  }

  User getUser() {
    String firstname = _instance?.getString('firstName') ?? '';
    String lastName = _instance?.getString('lastName') ?? '';
    String email = _instance?.getString('email') ?? '';
    return User(firstName: firstname, lastName: lastName, email: email);
  }
}