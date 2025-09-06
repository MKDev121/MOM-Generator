import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:easy_video_editor/easy_video_editor.dart';
import 'dart:io';
import 'package:http_parser/http_parser.dart';

Future<String?> pickFile() async {

  final FilePickerResult?  result=await FilePicker.platform.pickFiles(type: FileType.media);
    if(result!=null){
      return result.paths.single;
    }else{
      return null;
    }
}

Future<String?> getAudio() async{
  String?videoPath=await pickFile();
  if (videoPath == null) {
    print("No video file selected.");
    return null;
  }
  final editor = VideoEditorBuilder(videoPath: videoPath.toString());

  final Directory appDocDir = await getApplicationDocumentsDirectory();
  final outputPath = '${appDocDir.path}/output_audio.mp3';
  final audioPath=await editor.extractAudio(outputPath: outputPath);
  return audioPath;

}

Future<String?> generateTranscription(String? audioPath,String backendURL)async{
  
  try{
    var request =http.MultipartRequest('POST',Uri.parse(backendURL));

    request.files.add(await http.MultipartFile.fromPath(
      'audio',
      audioPath.toString(),
      filename: audioPath.toString().split('/').last,
      contentType: MediaType('audio', 'mp3')
    ));

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    if (response.statusCode == 200) {
      print('Audio file uploaded successfully!');
      
      final data=jsonDecode(response.body);
      return data['mom'];

    } else {
      print('Audio file upload failed with status: ${response.statusCode}');
      var errorBody = await response.body;
      print('Error details: $errorBody');
      return "";
    }
  }catch (e){
    print("Error during audio file upload: $e");
    return "";
  }
  // DeepgramListenResult res = await deepgram.listen.path(audioPath.toString(), queryParams: {
  //   'model': 'nova-2-general',
  //   'detect_language': true,
  //   'filler_words': false,
  //   'punctuation': true,
  //   // options here : https://developers.deepgram.com/reference/listen-file
  // });
  // print(res.transcript);
}

