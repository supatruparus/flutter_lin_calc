import 'dart:io';

import 'package:path_provider/path_provider.dart';

class MyLocalStorage {
  Future<String> readStringFromFile(String fileName) async {
    final Directory dir = await getApplicationSupportDirectory();

    void createFile() async {
      final String filePath = '${dir.path}/$fileName';
      File recipeFile = File(filePath);
      recipeFile.create();
    }

    final filePath = '${dir.path}/$fileName';
    final file = File(filePath);

    bool fileExist = await file.exists();
    String stringFile = '';
    if (fileExist) {
      stringFile = await file.readAsString();
      return stringFile;
    } else {
      createFile();
      return '';
    }
  }

  Future writeStringToFile(String fileName, String string) async {
    Directory fileDirectory = await getApplicationSupportDirectory();
    final String filePath = '${fileDirectory.path}/$fileName';
    File recipeFile = File(filePath);
    bool isFileExist = await recipeFile.exists();
    isFileExist
        ? recipeFile.writeAsString(string).then((value) => recipeFile = value)
        : recipeFile.create().then((value) =>
            value.writeAsString(string).then((value) => recipeFile = value));
  }
}
