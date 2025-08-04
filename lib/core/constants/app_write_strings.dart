import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppWriteStrings {
  static final String endpoint = dotenv.env['APPWRITE_ENDPOINT'] ?? '';
  static final String projectId = dotenv.env['APPWRITE_PROJECT_ID'] ?? '';
  static final String databaseId = dotenv.env['APPWRITE_DATABASE_ID'] ?? '';
  static final String userCollectionId =
      dotenv.env['APPWRITE_USER_COLLECTION_ID'] ?? '';
  static final String todoCollectionId =
      dotenv.env['APPWRITE_TODO_COLLECTION_ID'] ?? '';
}
