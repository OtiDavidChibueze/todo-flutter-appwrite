import 'package:appwrite/appwrite.dart';
import '../constants/app_write_strings.dart';

class AppWriteService {
  Client client = Client();
  Account? account;
  Databases? database;

  AppWriteService() {
    client
        .setEndpoint(AppWriteStrings.endpoint)
        .setProject(AppWriteStrings.projectId)
        .setSelfSigned(status: true);

    account = Account(client);
    database = Databases(client);
  }
}
