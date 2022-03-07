class MyUser {
  late final String uid;

  MyUser({required this.uid});
}

class UserData {
  late final String uid;
  late final String name;
  late final String choice;
  late final int sugars;
  late final int strength;

  UserData({required this.uid, required this.name, required this.choice, required this.sugars, required this.strength});
}
