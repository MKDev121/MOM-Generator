import 'dart:io';
import 'dart:ui';

import 'package:app/Functionality/FilePicking.dart';
import 'package:app/Functionality/SavingMOM.dart';
import 'package:app/Pages/Homepage.dart';
import 'package:app/Pages/mom_gen_page.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'BasicPageWidgets.dart';
import 'package:app/global_var.dart';
import 'package:file_picker/file_picker.dart';
class MOMOverlay extends StatelessWidget{
  const MOMOverlay({super.key,this.name="",this.date="",this.index=0});
  final String name;
  final String date;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 120,
      margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 237, 0),
        border: Border.all( width: 2),
        borderRadius: BorderRadius.circular(20),
      ),
      child:Row(
        children: [
          Padding(padding: EdgeInsets.fromLTRB(10, 0,0, 0)),
          MOMOverlayInfo(name:name,date:date,index:index),
          Expanded(child: Container()),
          Align(
            alignment: Alignment(0,.8),
            child:IconButton(
              icon:Icon(Icons.description,size:35,color:Colors.black),
              onPressed: (){print("Open MOM");},
              )
          ),
          Padding(padding: EdgeInsets.only(right: 10))
        ],
      )
    );
  }
}

class MOMOverlayInfo extends StatelessWidget{
  const MOMOverlayInfo({super.key,this.index=1,this.name="",this.date=""});
  final int index;
  final String name;
  final String date;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
    
      children: [
        Text("MOM_$index",style: TextStyle(fontSize:20,fontWeight: FontWeight.bold)),
        Text("Name: $name",style: TextStyle(fontSize:20,fontWeight: FontWeight.bold)),
        Text("Date: ",style: TextStyle(fontSize:20,fontWeight: FontWeight.bold)),
        
        
      ],
    );
  }
}


class MomGenOverlay extends StatefulWidget{
  const MomGenOverlay({super.key});

  @override
  State<MomGenOverlay> createState()=> _MomGenOverlayState();
}
class _MomGenOverlayState extends State<MomGenOverlay>{
  @override
  Widget build(BuildContext context){
    return 
    Align(
      alignment: Alignment(0, -.5),
      child: Container(
        width: 350,
        height: 600,
        decoration: BoxDecoration(
          border: Border.all(width: 3),
          color: Color.fromARGB(255, 255, 237, 0),
          borderRadius: BorderRadius.circular(20), 
        ),
        child: Column(
          spacing: 10,
          children: [
            Padding(padding: EdgeInsets.only(top:10)),
            Text("MOM 1",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 32)),
            Container(color: Colors.black,width: double.infinity,height: 3,),
            InputField(str:"Name"),
            Padding(padding: EdgeInsets.only(top:30)),
            PickDate(str:"Date"),
            Padding(padding: EdgeInsets.only(top:130)),
            SizedBox(
              width: 300,
              height: 100,
              child: OutlinedButton(
                onPressed: ()async{print("Video Upload");MomAppVars.audioPath=await getAudio();}, 
                style:OutlinedButton.styleFrom(
                  side:BorderSide(),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  backgroundColor: Color.fromARGB(255, 255, 248, 167)
                ),
                child: Center(child: Text("Upload Video",style:TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold)),)
                ),
            ),
          ],
          
        ),
      )
    );
  }
}

class MOMTextBox extends StatefulWidget{
  const MOMTextBox({super.key});

  @override
  State<MOMTextBox> createState()=> _MOMTextBoxState();
}
class _MOMTextBoxState extends State<MOMTextBox>{
  Future<String?> ?mom;

  @override
  void initState(){
    super.initState();
      mom=generateTranscription(MomAppVars.audioPath,"http://10.183.97.53:5000/generate");
        print(MomAppVars.audioPath);
  }
  @override
  Widget build(BuildContext context){
    return Column(
    children: [
        Container(
            margin: EdgeInsets.fromLTRB(40,50,40,0),
            width: 500,
            height: 600,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 255, 237, 0),
              border:Border.all(width: 2)
            ),
            child: Container(
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(color: Color.fromARGB(255,255, 253,229 )),
              child:Container(margin: EdgeInsets.symmetric(horizontal: 8),child:ListView (

                children:[
                  
                  FutureBuilder<String?>(
                    future: mom,
                    builder: (context, AsyncSnapshot<String?> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Padding(padding: EdgeInsets.only(top:250),child:Center(child: CircularProgressIndicator()));
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (snapshot.hasData) {
                        MomAppVars.mom=snapshot.data;
                        return Text(snapshot.data ?? '', style: TextStyle(fontSize: 18));
                      } else {
                        return Center(child: Text('No data'));
                      }
                    },
                  )
                ]))
            ),
        ),
        Row(
          children: [
            Padding(padding: EdgeInsets.only(left:35)),
            IconButton.filled(
              onPressed: ()async {
                print("Save"); 
                File file=await getPathOfFile();
                addMOMData("Mom ",
                DateFormat("dd/MM/yyyy").format(DateUtils.dateOnly(MomAppVars.meetingDate??DateTime(2025))),
                MomAppVars.mom.toString()
                ,file);
                
              }, 
              icon: Icon(Icons.save,color:Colors.white),
              style: IconButton.styleFrom(
                shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
                side: BorderSide()
              ),
            ),
            Padding(padding: EdgeInsets.only(left:10)),
            IconButton.filled(
              onPressed: ()async {print("Copy");await FlutterClipboard.copy(MomAppVars.mom.toString());}, 
              icon: Icon(Icons.content_copy,color:Colors.white),
              style: IconButton.styleFrom(
                shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
                side: BorderSide()
              ),
            ),
            Expanded(child: SizedBox()),
            IconButton.filled(
              onPressed: (){print("GoToHome");Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));}, 
              icon: Icon(Icons.home_outlined,color:Colors.white),
              style: IconButton.styleFrom(
                shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
                side: BorderSide()
              ),
            ),
            Padding(padding: EdgeInsets.only(right: 35)),
          ],
        )
        
      ]
    );
  }

}