import 'package:flutter/material.dart';
import 'package:app/global_var.dart';
import 'package:intl/intl.dart';

class TopBar extends AppBar{
   TopBar({super.key,this.pageName});
   final String? pageName;

   @override 
  Color? get backgroundColor => Color.fromARGB(255, 255, 237, 0);
  
  @override

  bool? get centerTitle => true;
  
  @override
  Widget? get title => Text(pageName!,style: TextStyle(fontWeight: FontWeight.bold));

  @override
  PreferredSizeWidget? get bottom => PreferredSize(preferredSize: Size.fromWidth(double.infinity), 
  child:Container(
      height: 3,
      color: Color.fromARGB(255, 0, 0, 0),
      width: double.infinity,
    )
  );

}


class InputField extends StatelessWidget{
  const InputField({super.key,this.str=""});
  final String str;
  
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
        alignment: Alignment(-.9, 0),
        child:Text(str,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)
        ),
        Align(
        alignment: Alignment(-.7, 0),
        child:Container(
        width: 250,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 248, 167),
          borderRadius: BorderRadius.circular(5)
        ),
        child:TextField(decoration: InputDecoration(hintText: " Enter the meeting $str"),),
        
          )
        )
      ],
    );
    
  }
}

class PickDate extends StatefulWidget{
  
  const PickDate({super.key,this.str=""});
  final String str;

  @override
  State<PickDate> createState()=>PickDateState();

}

class PickDateState extends State<PickDate>{
  DateTime? displayDate;
  @override
  void initState(){
    super.initState();
    displayDate=DateUtils.dateOnly(DateTime.now());
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment(-.9, 0),
          child:Text(widget.str,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)
        ),
        Align(
        alignment: Alignment(-.7, 0),
        child:SizedBox( 
          width: 250,
          child:FloatingActionButton(
          onPressed: () async {
          print("Print enter date");
          MomAppVars.meetingDate=await showDatePicker(context: context, firstDate: DateTime(2000), lastDate: DateTime(3000));
            setState(() { displayDate=MomAppVars.meetingDate;});
          },
          shape: Border(bottom: BorderSide()),

          backgroundColor:Color.fromARGB(255, 255, 248, 167) ,
          child:Text(DateFormat("dd/MM/yyyy").format(displayDate ?? DateTime(2025)))
          
          ) )     
        )
      ],
    );
  }
}


