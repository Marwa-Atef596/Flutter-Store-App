import 'package:dio/dio.dart';
import 'package:flutter_store_app/core/networking/api_services.dart';
import 'package:flutter_store_app/core/networking/dio_factory.dart';
import 'package:flutter_store_app/features/login/data/repo/login_repo.dart';
import 'package:flutter_store_app/features/login/logic/cubit/login_cubit.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;
Future<void> setupGetit() async {
  Dio dio = DioFactory.getDio();
  getIt.registerLazySingleton<ApiServices>(() => ApiServices(dio));

  getIt.registerLazySingleton<LoginRepo>(() => LoginRepo(getIt()));
  getIt.registerFactory<LoginCubit>(() => LoginCubit(getIt()));
}
