import 'package:rafiq/features/profile/domain/entities/profile_entity.dart';

sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class ProfileLoading extends ProfileState {}

final class ProfileSuccess extends ProfileState {
  final ProfileEntity user;
  ProfileSuccess(this.user);
}

final class ProfileError extends ProfileState {
  final String message;
  ProfileError(this.message);
}

final class UpdateProfileLoading extends ProfileState {}
final class UpdateProfileSuccess extends ProfileState {}
final class UpdateProfileError extends ProfileState {
  final String message;
  UpdateProfileError(this.message);
}