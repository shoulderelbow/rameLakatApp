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
    await _instance?.setString('userName', user.userName);
    await _instance?.setString('uniqueId', user.uniqueId);
    await _instance?.setString('city', user.city);
    await _instance?.setString('profileImage', user.profileImage);
  }

  void updateProfileImage(String newImageUrl) async {
    await _instance?.setString('profileImage', newImageUrl);
  }

  User getUser() {
    String firstname = _instance?.getString('firstName') ?? '';
    String lastName = _instance?.getString('lastName') ?? '';
    String email = _instance?.getString('email') ?? '';
    String userName = _instance?.getString('userName') ?? '';
    String uniqueId = _instance?.getString('uniqueId') ?? '';
    String city = _instance?.getString('city') ?? '';
    String profileImage = _instance?.getString('profileImage') ?? '';
    return User(firstName: firstname, lastName: lastName, email: email, userName: userName, uniqueId: uniqueId, city: city, profileImage: profileImage);
  }

  Future pickImage(String profileImage) async {
    await _instance?.setString('profileImage', profileImage);
  }

  void removeUser() async {
    await _instance?.setString('firstName', "");
    await _instance?.setString('lastName', "");
    await _instance?.setString('email', "");
  }
}