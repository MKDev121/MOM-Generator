import "dart:io";
import "dart:convert";
import "package:path_provider/path_provider.dart";

Future<File> getPathOfFile() async {
  final directory = await getApplicationDocumentsDirectory();
  final path = directory.path;
  final file = File("$path/userData.json");

  if (!(await file.exists())) {
    // Create the file with an empty MOMs array
    final Map<String, dynamic> data = {'MOMs': []};
    print("hi");
    await file.writeAsString(json.encode(data));
  }
  print("$path/userData.json");
  return file;
}



void addMOMData(String name,String date,String mom,File file) async{

  Map<String,dynamic> momData={
    "name":name,
    "date":date,
    "mom":mom
  };
  final response= await file.readAsString();
  final jsonData=json.decode(response);
  List<dynamic> momDatas=jsonData['MOMs'];
  momDatas.add(momData);
  jsonData["MOM"]=momDatas;
  String updatedJsonString=jsonEncode(jsonData);
  await file.writeAsString(updatedJsonString);
  print("Print Updated  Json data");

  
}

Future<Map<String,dynamic>>getMOMData(int index,File file) async{
  final response= await file.readAsString();
  final jsonData=json.decode(response);
  List<dynamic> momDatas=jsonData['MOMs'];
  return momDatas[index];
}

Future<int> getCount() async{
  final directory= await getApplicationDocumentsDirectory();
  final path= directory.path;
  File file= File("$path/userData.json");
    final response= await file.readAsString();
  print(response);
  final jsonData=json.decode(response);

  List<dynamic> momDatas=jsonData['MOMs'];
  return momDatas.length;  
}




