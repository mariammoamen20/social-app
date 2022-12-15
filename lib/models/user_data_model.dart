class UserDataModel {
  String? name;
  String? email;
  String? phone;
  String? uId;
  bool? isEmailVerified ;

  UserDataModel(this.name, this.email, this.phone, this.uId,this.isEmailVerified);

  UserDataModel.fromJson(Map<String, dynamic>? json) {
    name = json?['name'];
    email = json?['email'];
    phone = json?['phone'];
    uId = json?['uId'];
    isEmailVerified = json?['isEmailVerified'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'uId': uId,
      'isEmailVerified': isEmailVerified,
    };
  }
}
