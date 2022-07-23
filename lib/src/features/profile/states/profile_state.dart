class ProfileState {
  final bool isLoading;

  ProfileState({
    this.isLoading = false,
  });

  ProfileState update({bool? isLoading}) {
    return ProfileState(
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
