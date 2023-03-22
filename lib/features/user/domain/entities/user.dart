import 'package:equatable/equatable.dart';

class User extends Equatable{
  final String userId;
  final String organizationId;
  final String token;

  const User({required this.userId, required this.organizationId, required this.token});


  @override
  List<Object?> get props => [userId, organizationId, token];

}