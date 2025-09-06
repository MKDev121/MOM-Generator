import 'package:app/Pages/mom_page.dart';
import 'package:flutter/material.dart';
import "package:app/Pages/mom_gen_page.dart";


class GenerateMomButton extends StatelessWidget{
  const GenerateMomButton({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Container(
      decoration: BoxDecoration(border: Border.fromBorderSide(BorderSide(width: 2)),borderRadius: BorderRadius.circular(20)),
      width: 200,
      child:FloatingActionButton(
        onPressed:(){print("Generate MOM");Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>MomPage()));}, 
        backgroundColor: Color.fromARGB(255, 0, 0, 128),
        child: Text("Generate MOM Button",style: TextStyle(fontSize: 16,fontWeight:FontWeight.bold,color: Colors.white),),
      ),
      
    );
  }
}

class AddMomButton extends StatelessWidget{

   const AddMomButton({super.key});
    @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
    onPressed: (){print("Add MOM");Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MomGenPage()));}, 
    label: Icon(Icons.add_circle_outline,color:Colors.white),
    style:ElevatedButton.styleFrom(
      backgroundColor: Color.fromARGB(255, 0, 0, 128),
      minimumSize: Size(150, 50),
      side:BorderSide(
        color:Colors.black,
        width: 2
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12)
      ),
      iconSize: 30,
    )
    );
  }
}