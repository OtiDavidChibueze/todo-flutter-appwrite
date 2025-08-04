import 'package:get_it/get_it.dart';
import 'package:todo_flutter_appwrite/core/provider/app_write_provider.dart';

final GetIt locator = GetIt.I;

void setUpLocator() {
  locator.registerLazySingleton<AppWriteProvider>(() => AppWriteProvider());
}
