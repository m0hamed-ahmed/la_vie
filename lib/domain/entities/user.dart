import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String message;
  final String userId;
  final String firstName;
  final String lastName;
  final String email;
  final String imageUrl;
  final String? address;
  final String accessToken;

  const User({
    required this.message,
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.imageUrl,
    this.address,
    required this.accessToken,
  });

  @override
  List<Object?> get props => [
    message,
    userId,
    firstName,
    lastName,
    email,
    imageUrl,
    address,
    accessToken,
  ];
}