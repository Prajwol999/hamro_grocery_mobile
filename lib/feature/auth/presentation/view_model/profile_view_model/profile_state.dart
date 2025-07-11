// feature/auth/presentation/view_model/profile_view_model/profile_state.dart

import 'dart:io'; // Required for File
import 'package:equatable/equatable.dart';
import 'package:hamro_grocery_mobile/feature/auth/domain/entity/auth_entity.dart';

class ProfileState extends Equatable {
  final AuthEntity? authEntity;
  final bool isLoading;
  final bool isEditing;
  final String? errorMessage;
  // Holds the new image selected by the user, before it's uploaded
  final File? newProfileImageFile;

  const ProfileState({
    this.authEntity,
    required this.isLoading,
    required this.isEditing,
    this.errorMessage,
    this.newProfileImageFile,
  });

  factory ProfileState.initial() {
    return const ProfileState(
      authEntity: null,
      isLoading: false,
      isEditing: false,
      errorMessage: null,
      newProfileImageFile: null,
    );
  }

  ProfileState copyWith({
    AuthEntity? authEntity,
    bool? isLoading,
    bool? isEditing,
    String? Function()? errorMessage,
    File? Function()? newProfileImageFile,
  }) {
    return ProfileState(
      authEntity: authEntity ?? this.authEntity,
      isLoading: isLoading ?? this.isLoading,
      isEditing: isEditing ?? this.isEditing,
      errorMessage: errorMessage != null ? errorMessage() : this.errorMessage,
      newProfileImageFile: newProfileImageFile != null
          ? newProfileImageFile()
          : this.newProfileImageFile,
    );
  }

  @override
  List<Object?> get props =>
      [authEntity, isLoading, isEditing, errorMessage, newProfileImageFile];
}