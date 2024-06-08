import 'package:get_it/get_it.dart';
import 'package:kanbanboard/application/network/client/api_service.dart';
import 'package:kanbanboard/application/network/client/iApService.dart';
import 'package:kanbanboard/application/network/external_values/ExternalValues.dart';
import 'package:kanbanboard/application/network/external_values/iExternalValue.dart';
import 'package:kanbanboard/application/services/nav_service/i_navigation_service.dart';
import 'package:kanbanboard/application/services/nav_service/navigation_service.dart';
import 'package:kanbanboard/application/services/pref_service/i_pref_service.dart';
import 'package:kanbanboard/application/services/pref_service/pref_service.dart';
import 'package:kanbanboard/data/remote_data_src/board_api.dart';
import 'package:kanbanboard/data/remote_data_src/i_board_api.dart';
import 'package:kanbanboard/data/repo_impl/board_repo_impl.dart';
import 'package:kanbanboard/domain/repo_interfaces/i_board_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

final inject = GetIt.instance;

Future<void> setupLocator() async {
  inject.registerSingletonAsync(() => SharedPreferences.getInstance());
  inject.registerLazySingleton<INavigationService>(() => NavigationService());
  inject.registerLazySingleton<IPrefService>(() => PrefService(inject()));
  inject.registerLazySingleton<IExternalValues>(() => ExternalValues());
  inject.registerLazySingleton<IApiService>(
      () => ApiService.create(externalValues: ExternalValues()));
  inject.registerLazySingleton<IBoardApi>(() => BoardApi(inject()));
  inject.registerLazySingleton<IBoardRepo>(() => BoardRepo(api: inject()));
}
