class AddForumState {
  final bool isLoading;

  AddForumState({
    this.isLoading = false,
  });

  AddForumState update({bool? isLoading}) {
    return AddForumState(
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
