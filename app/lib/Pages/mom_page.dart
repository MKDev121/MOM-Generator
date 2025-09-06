import 'package:app/Widgets/OverlayWidgets.dart';
import "package:flutter/material.dart";
import 'package:app/Widgets/BasicPageWidgets.dart';
import 'package:app/Widgets/buttons.dart';


class MomPage extends StatelessWidget{
  const MomPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(pageName: "MOM"),
      backgroundColor: Color.fromARGB(255, 255, 248, 167),
      body: MOMTextBox(),
    );
  }

}