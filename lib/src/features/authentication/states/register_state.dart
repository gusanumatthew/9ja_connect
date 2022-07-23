class RegisterState {
  final bool isLoading;
  final bool obscureText;
  RegisterState({
    this.obscureText = true,
    this.isLoading = false,
  });

  RegisterState update({bool? isLoading, bool? obscureText}) {
    return RegisterState(
      isLoading: isLoading ?? this.isLoading,
      obscureText: obscureText ?? this.obscureText,
    );
  }
}
