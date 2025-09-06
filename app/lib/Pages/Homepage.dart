import 'dart:io';

import 'package:app/Widgets/Buttons.dart';
import 'package:flutter/material.dart';
import 'package:app/Widgets/BasicPageWidgets.dart';
import 'package:app/Widgets/OverlayWidgets.dart';
import 'package:app/global_var.dart';
import 'package:app/Functionality/SavingMOM.dart';

class HomePage extends StatelessWidget{
  const HomePage({super.key});


  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: TopBar(pageName: "Homepage"),
      backgroundColor: Color.fromARGB(255, 255, 248, 167), 
      body: FutureBuilder<int>(
        future: getCount(),
        builder: (context, countSnapshot) {
          if (countSnapshot.connectionState != ConnectionState.done) {
            return Center(child: CircularProgressIndicator());
          }
          if (!countSnapshot.hasData || countSnapshot.data == 0) {
            return Center(child: Text('No items found'));
          }
          return FutureBuilder<File>(
            future: getPathOfFile(),
            builder: (context, fileSnapshot) {
              if (fileSnapshot.connectionState != ConnectionState.done) {
                return Center(child: CircularProgressIndicator());
              }
              if (!fileSnapshot.hasData) {
                return Center(child: Text('No file found'));
              }
              final file = fileSnapshot.data!;
              return ListView.separated(
                padding: EdgeInsets.only(top: 50),
                itemBuilder: (BuildContext context, int index) {
                  return FutureBuilder<Map<String, dynamic>>(
                    future: getMOMData(index, file),
                    builder: (context, momDataSnapshot) {
                      if (momDataSnapshot.connectionState != ConnectionState.done) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (!momDataSnapshot.hasData) {
                        return Center(child: Text('No MOM data found'));
                      }
                      final momData = momDataSnapshot.data!;
                      return MOMOverlay(date: "05/08/2025", name: "xyz", index: index + 1);
                    },
                  );
                },
                itemCount: countSnapshot.data!,
                separatorBuilder: (BuildContext context, h) => SizedBox(height: 50),
              );
            },
          );
        },
      ),
    floatingActionButtonLocation:FloatingActionButtonLocation.centerFloat,
    floatingActionButton: AddMomButton(),
    );
  }

}