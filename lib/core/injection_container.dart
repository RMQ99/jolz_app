import 'package:get_it/get_it.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jolz_app/features/webview/data/repositories/webview_repository_impl.dart';
import 'package:jolz_app/features/webview/domain/repositories/webview_repository.dart';
import '../features/authentication/data/repositories/token_repository_impl.dart';
import '../features/authentication/domain/repositories/token_repository.dart';
import '../features/authentication/domain/usecases/get_token.dart';
import '../features/authentication/domain/usecases/save_token.dart';
import '../features/authentication/domain/usecases/delete_token.dart';
import '../features/authentication/presentation/bloc/token_bloc.dart';
import '../features/webview/domain/usecases/load_webview_usecase.dart';
import '../features/webview/presentation/blocs/webview_bloc.dart';

final GetIt sl = GetIt.instance;

void init() {
  // Features - Authentication
  // Blocs
  sl.registerFactory(
        () => TokenBloc(
      getToken: sl(),
      saveToken: sl(),
      deleteToken: sl(),
    ),
  );

  sl.registerFactory(
        () => WebViewBloc(
        loadWebViewUseCase : sl(),
          reloadWebViewUseCase: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetToken(sl()));
  sl.registerLazySingleton(() => SaveToken(sl()));
  sl.registerLazySingleton(() => DeleteToken(sl()));
  sl.registerLazySingleton(() => LoadWebViewUseCase(sl()));
  sl.registerLazySingleton(() => ReloadWebViewUseCase(sl()));
  // Repository
  sl.registerLazySingleton<TokenRepository>(
        () => TokenRepositoryImpl(localDataSource: sl()),
  );
  sl.registerLazySingleton<WebViewRepository>(
      () => WebViewRepositoryImpl(dataSource: sl()),
  );

  // External
  sl.registerLazySingleton(() => const FlutterSecureStorage());

  // Add other dependencies as needed
}