
import '../../domain/entities/user.dart';

class UserModel extends User{
 const UserModel({required super.userId, required super.organizationId, required super.token,});

  
  factory UserModel.fromJson(Map<String,dynamic> json){
    return UserModel(userId: json['user_id'], organizationId: json['organization_id'], token: json['token'],);
  }

  Map<String,dynamic> toJson(){
    return{
      'user_id':userId,
      'organization_id':organizationId,
      'token':token,
    };
  }


}