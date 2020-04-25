
//import 'package:flutter/material.dart';

enum LoginType { email, phone }

class User with UserUtils{
  String email;
  String phone;

  String _lastName;
  String _firstName;
  LoginType _type;

  List<User> friends = <User>[];

  User._({String firstName, String lastName, String phone, String email})
  : _firstName = firstName
  , _lastName = lastName
  , this.phone = phone
  , this.email = email {
    _type = email != null ? LoginType.email : LoginType.phone;
  }

  factory User({String name, String phone, String email}) {
    if (name == null || name.isEmpty) throw Exception('User name is empty');
    if ( (phone == null || phone.isEmpty) && (email == null || email.isEmpty) ) throw Exception('User phone and email is empty');

    String firstName = name.split(" ")[0];
    String lastName = name.split(" ")[1];
    String checkPhone = phone;
    if (phone != null) {
      String pattern = r"^(?:[+0])?[0-9]{11}";
      checkPhone = phone.replaceAll(RegExp("[^+\\d]"), "");
      if (!RegExp(pattern).hasMatch(checkPhone)) throw Exception('Enter a valid phone number starting with a + and containing 11 digits');
    }
    String checkEmail = email;
    if (email != null) {
      if (!email.contains('@')) throw Exception('User email is invalid');
    }

    return User._(
      firstName: firstName,
      lastName: lastName,
      phone: checkPhone,
      email: checkEmail );
  }

  String get login {
    if (_type == LoginType.phone) return phone;
    return email;
  }

  String get name => "${capitalize(_firstName)} ${capitalize(_lastName)}";

  @override
  bool operator ==(Object object) {
    if (object != null && object is User) {
      return _firstName == object._firstName &&
        _lastName == object._lastName &&
        login == object.login;
    }
    return false;
  }

  @override
  String toString() {
    return """
    name: $name
    email: $email
    phone: $phone
    login: $login
    friends: ${friends.toList()}
    """;
  }
}

mixin UserUtils {
  String capitalize(String s) {
    if ( s != null && s.isNotEmpty)
    {
      String result = s[0].toUpperCase();
      if (s.length>1) result += s.substring(1).toLowerCase();
      return result;
    }
    return s;
  }
}