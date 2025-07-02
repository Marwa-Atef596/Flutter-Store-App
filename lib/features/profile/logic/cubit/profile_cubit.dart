import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_app/features/profile/data/repo/profile_repo.dart';
import 'package:flutter_store_app/features/profile/logic/cubit/profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepo _profileRepo;

  ProfileCubit(this._profileRepo) : super(ProfileState.initial());

  Future<void> loadProfile() async {
    final name = await _profileRepo.getUserName();
    final email = await _profileRepo.getUserEmail();
    emit(
      ProfileState(name: name, email: email, isLoggedOut: false),
    );
  }

  Future<void> logout() async {
    await _profileRepo.clearUserData();
    emit(ProfileState.loggedOut());
  }
}
