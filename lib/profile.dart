import 'dart:ffi';

class Profile {
  late String name;
  late Long phoneNumber;
  late String email;
  Map<String, Int> skills = <String, Int>{};
  static Profile of() {
    return Profile();
  }

  Profile({name, phoneNumber, email});

  String getName() {
    return name;
  }

  Long getPhoneNumber() {
    return phoneNumber;
  }

  String getEmail() {
    return email;
  }
}
