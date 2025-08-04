import 'package:appwrite/appwrite.dart';
import 'package:todo_flutter_appwrite/core/constants/app_write_strings.dart';

class AppWriteProvider {
  Client client = Client();
  Account? account;
  Databases? database;

  AppWriteProvider() {
    client
        .setEndpoint(AppWriteStrings.endpoint)
        .setProject(AppWriteStrings.projectId)
        .setSelfSigned(status: true);

    account = Account(client);
    database = Databases(client);
  }
}
