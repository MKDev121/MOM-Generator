import 'dart:io';

import 'package:app/Pages/mom_gen_page.dart';
import 'package:app/Pages/mom_page.dart';
import 'package:flutter/material.dart';
import 'Functionality/SavingMOM.dart';
import "Pages/Homepage.dart";




void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await getPathOfFile();
  runApp(const MainApp()); 
  
}


class MainApp extends StatefulWidget{
    const MainApp({ super.key });

    @override
    State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp>{
  int pageIndex=0;
  List<Widget> pages=[HomePage(),MomGenPage(),MomPage()];

  void changePage(int index){
    setState((){pageIndex=index;});

  }
  @override
  Widget build(BuildContext context){

    return MaterialApp(
      home:pages[pageIndex]
    );
  }
}

// class MainApp extends StatelessWidget {
 
//   const MainApp({super.key});
//   @override
//   Widget build(BuildContext context) {
//      String? filePath="";
//      String? audioPath="";
//     return  MaterialApp(
//       home: Scaffold(
//         body: Center(
//           child: Column(
//             children: [
//               ElevatedButton(child:const Text("PickFile"),onPressed:() async {filePath= await pickFile();}),
//               ElevatedButton(onPressed: ()async {audioPath= await getAudio(filePath.toString());}, child: const Text("GetAudio")),
//               ElevatedButton(onPressed:()async{await generateTranscription(audioPath);} , child:const Text("Generate"))
//             ],
//           )
//           ,
//         ),
//       ),
//     );
//   }
// }
