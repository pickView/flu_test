class UserModel {
  String token;
  UserModel(this.token);

  UserModel.fromJson(Map<String, dynamic> json) {
    token = json['access_token'];
  }

  Map<String, dynamic> toJson() => <String, dynamic>{'token': token};
}

class UserManager {
  static UserManager _instance;
  static UserManager get instance {
    if (_instance == null) {
      _instance = UserManager();
    }
    return _instance;
  }

  UserModel user;
  static UserModel get currentUser {
    return UserManager.instance.user;
  }
}
