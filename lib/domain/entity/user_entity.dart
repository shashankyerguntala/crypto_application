import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String email;

  const UserEntity({
    required this.email,
  });

  UserEntity copyWith({
    String? email,
  }) {
    return UserEntity(
      email: email ?? this.email,
    );
  }

  @override
  List<Object?> get props => [email];
}
