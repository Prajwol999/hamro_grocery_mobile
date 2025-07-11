// feature/auth/presentation/view_model/profile_view_model/profile_view_model.dart

import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hamro_grocery_mobile/feature/auth/domain/usecase/get_user_usecase.dart';
import 'package:hamro_grocery_mobile/feature/auth/domain/usecase/update_user_usecase.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileViewModel extends Bloc<ProfileEvent, ProfileState> {
  final GetUserUsecase _userGetUseCase;
  final UserUpdateUsecase _userUpdateUsecase;

  ProfileViewModel({
    required GetUserUsecase userGetUseCase,
    required UserUpdateUsecase userUpdateUseCase,
  })  : _userUpdateUsecase = userUpdateUseCase,
        _userGetUseCase = userGetUseCase,
        super(ProfileState.initial()) {
    on<LoadProfileEvent>(_onProfileLoad);
    on<UpdateProfileEvent>(_onProfileUpdate);
    on<ToggleEditModeEvent>(_onToggleEditMode);
    on<ClearMessageEvent>(_onClearMessage);
    on<ProfileImagePickedEvent>(_onProfileImagePicked);

    add(LoadProfileEvent());
  }

  void _onProfileImagePicked(
      ProfileImagePickedEvent event,
      Emitter<ProfileState> emit,
      ) {
    emit(state.copyWith(newProfileImageFile: () => event.imageFile));
  }

  Future<void> _onProfileLoad(
      LoadProfileEvent event,
      Emitter<ProfileState> emit,
      ) async {
    emit(state.copyWith(isLoading: true, newProfileImageFile: () => null));
    final result = await _userGetUseCase();
    result.fold(
          (failure) => emit(state.copyWith(
        isLoading: false,
        errorMessage: () => failure.message,
      )),
          (user) => emit(state.copyWith(
        isLoading: false,
        authEntity: user,
        isEditing: false,
      )),
    );
  }

  void _onToggleEditMode(
      ToggleEditModeEvent event,
      Emitter<ProfileState> emit,
      ) {
    // If user cancels editing, clear the temp image
    if (state.isEditing) {
      emit(state.copyWith(
          isEditing: !state.isEditing, newProfileImageFile: () => null));
    } else {
      emit(state.copyWith(isEditing: !state.isEditing));
    }
  }

  Future<void> _onProfileUpdate(
      UpdateProfileEvent event,
      Emitter<ProfileState> emit,
      ) async {
    emit(state.copyWith(isLoading: true));
    // Note: Your use case must be updated to accept the image file
    final result = await _userUpdateUsecase(
      event.authEntity,
      // imageFile: event.newProfileImage,
    );
    result.fold(
          (failure) => emit(state.copyWith(
        isLoading: false,
        errorMessage: () => failure.message,
      )),
          (updatedUser) => emit(state.copyWith(
        isLoading: false,
        authEntity: updatedUser,
        isEditing: false,
        errorMessage: () => 'Profile updated successfully!',
        newProfileImageFile: () => null, // Clear temp image on success
      )),
    );
  }

  void _onClearMessage(ClearMessageEvent event, Emitter<ProfileState> emit) {
    emit(state.copyWith(errorMessage: () => null));
  }
}