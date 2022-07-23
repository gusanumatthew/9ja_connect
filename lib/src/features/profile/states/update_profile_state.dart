class UpdateProfileState {
  final bool isLoading;

  UpdateProfileState({
    this.isLoading = false,
  });

  UpdateProfileState update({bool? isLoading}) {
    return UpdateProfileState(
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
