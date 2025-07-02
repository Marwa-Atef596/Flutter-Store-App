class ProfileState {
  final String name;
  final String email;
  final bool isLoggedOut;

  ProfileState({
    required this.name,
    required this.email,
    required this.isLoggedOut,
  });

  factory ProfileState.initial() =>
      ProfileState(name: '', email: '', isLoggedOut: false);

  factory ProfileState.loggedOut() =>
      ProfileState(name: '', email: '', isLoggedOut: true);
}