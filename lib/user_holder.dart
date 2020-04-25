import 'models/user.dart';

class UserHolder {
  Map<String, User> users = {};

  User registerUser(String name, String phone, String email) {
    User user = User(name: name, phone: phone, email: email);
    if (users.containsKey(user.login)) throw Exception('A user already exists');
    users[user.login] = user;
    return users[user.login];
  }

  User registerUserByEmail(String name, String email) {
    if (email == null || email.isEmpty) throw Exception("Enter don't empty email");
    if (users.containsKey(email)) throw Exception('A user with this email already exists');
    return registerUser(name, null, email);
  }

  User registerUserByPhone(String name, String phone) {
    if (phone == null || phone.isEmpty) throw Exception("Enter don't empty phone number");
    if (users.containsKey(phone)) throw Exception('A user with this phone already exists');
    return registerUser(name, phone, null);
  }

  User getUserByLogin(String login) {
    if (users.containsKey(login)) return users[login];
    return null;
  }

  User findUserInFriends(String login, User friend) {
     if (!users.containsKey(login)) throw Exception('A user is not exists');
     int i = users[login].friends.indexOf(friend);
     if (i==-1) throw Exception('${friend.login} is not a friend of the login');
     return users[login].friends[i];
  }

  void setFriends(String login, List<User> friends) {
    if (!users.containsKey(login)) throw Exception('A user is not exists');
    users[login].friends = friends;
  }

  List<User> importUsers(List<String> strings) {
    List<User> result = [];
    if (strings!=null) {
      strings.forEach((s) {
        List<String> slist = s.split(";");
        User user = registerUser(slist[0].trim(), slist[2].trim(), slist[1].trim());
        result.add(user);
      });
    }
    return result;
  }
}