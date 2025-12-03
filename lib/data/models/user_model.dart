import 'package:final_l3/domain/entity/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({required super.email});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(email: json["email"] ?? "");
  }

  Map<String, dynamic> toJson() {
    return {"email": email};
  }
}
