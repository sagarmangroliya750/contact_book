
// ignore_for_file: camel_case_types, sort_child_properties_last, prefer_const_constructors, null_argument_to_non_null_type, avoid_print, prefer_const_literals_to_create_immutables

import 'package:contact_book/viewpage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sqflite/sqflite.dart';

import 'Model.dart';

class insertpage extends StatefulWidget {
  const insertpage({Key? key}) : super(key: key);

  @override
  State<insertpage> createState() => _insertpageState();
}

class _insertpageState extends State<insertpage> {

  TextEditingController tname = TextEditingController();
  TextEditingController tcontact = TextEditingController();

  Database? db;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Model().createDatabase().then((value) {
      db = value;
    });
  }

  Future<bool> goback()
  {
    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) {
        return viewpage();
      },
    ));
    return Future.value();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          backgroundColor:Colors.black,
          appBar: AppBar(
            centerTitle:true,
            backgroundColor:Colors.black,
            title: Text("Create Contact",style:TextStyle(color:Colors.green),),
            leading: IconButton(onPressed: () {
              if(tname.text.isNotEmpty || tcontact.text.isNotEmpty)
              {
                Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) {
                    return viewpage();
                  },
                ));
              }
              else
              {
                Fluttertoast.showToast(
                    msg: "Pls Fills Details First...!!",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Color(0xff404040),
                    textColor: Colors.redAccent,
                    fontSize: 16.0
                );
              }
            }, icon: Icon(Icons.arrow_back,color:Colors.green)),
          ),
          body:Column(
            children: [
              SizedBox(
                height:70,
                child:Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration:InputDecoration(
                      filled:true,fillColor:Colors.white30,
                      border:OutlineInputBorder(borderRadius:BorderRadius.circular(10),borderSide:BorderSide.none),
                      prefixIcon:Icon(Icons.person,color:Colors.blue,),
                      suffixIcon:IconButton(onPressed: () =>tname.text ="" , icon:Icon(Icons.clear,color:Colors.red,size:19)),
                      hintText:"Enter name",hintStyle:TextStyle(color:Colors.white38),
                    ),
                    controller: tname,style:TextStyle(color:Colors.white),
                  ),
                ),
              ),
              SizedBox(
                height:88,
                child:Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    keyboardType:TextInputType.number,
                    maxLength:10,
                    decoration:InputDecoration(
                      filled:true,fillColor:Colors.white30,
                      border:OutlineInputBorder(borderRadius:BorderRadius.circular(10),borderSide:BorderSide.none),
                      prefixIcon:Icon(Icons.call,color:Colors.green,),
                      suffixIcon:IconButton(onPressed: () =>tcontact.text ="" , icon:Icon(Icons.clear,color:Colors.red,size:19)),
                      hintText:"Enter contact",hintStyle:TextStyle(color:Colors.white38),
                    ),
                    controller:tcontact,style:TextStyle(color:Colors.white),
                  ),
                ),
              ),
              InkWell(
                onTap:() {
                  String name = tname.text;
                  String contact = tcontact.text;

                  String qry =
                      "insert into contactbook (name,contact) values ('$name','$contact')";
                  db!.rawInsert(qry).then((value) {
                    print(value);
                    if(tname.text != "" || tcontact.text!="")
                    {
                      Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) {
                          return viewpage();
                        },
                      ));
                    }
                    else
                    {
                      Fluttertoast.showToast(
                          msg: "Pls Fills Details First...!!",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Color(0xff404040),
                          textColor: Colors.redAccent,
                          fontSize: 16.0
                      );
                    }
                  });
                },
                child: Container(
                  height:40,width:110,alignment:Alignment.center,
                  child:Text("Save Contact",style:TextStyle(fontSize:16),),
                  decoration:BoxDecoration(color:Colors.blue,borderRadius:BorderRadius.circular(7),
                  ),
                ),
              )
            ],
          ),
        ), onWillPop: goback);
  }
}
