// ignore_for_file: prefer_const_constructors, camel_case_types, use_key_in_widget_constructors, null_argument_to_non_null_type, avoid_print, must_be_immutable

import 'package:contact_book/viewpage.dart';
import 'package:flutter/material.dart';import 'package:fluttertoast/fluttertoast.dart';
import 'package:sqflite/sqflite.dart';

import 'Model.dart';


class updatepage extends StatefulWidget {

  Map map;
  updatepage(this.map);

  @override
  State<updatepage> createState() => _updatepageState();
}

class _updatepageState extends State<updatepage> {

  TextEditingController tname = TextEditingController();
  TextEditingController tcontact = TextEditingController();

  Database? db;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    tname.text = widget.map['name'];
    tcontact.text = widget.map['contact'];

    Model().createDatabase().then((value) {
      db = value;
    });
  }

  Future<bool> goback() {
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
        onWillPop: goback,
        child: Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              backgroundColor: Colors.black,
              title: Text("Create Contact"),
              leading: IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) {
                        return viewpage();
                      },
                    ));
                  },
                  icon: Icon(Icons.arrow_back)),
            ),
            body: ListView(
              children: [
                SizedBox(
                  height: 70,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white30,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none),
                        prefixIcon: Icon(
                          Icons.person,
                          color: Colors.blue,
                        ),
                        suffixIcon: IconButton(
                            onPressed: () => tname.text = "",
                            icon:
                            Icon(Icons.clear, color: Colors.red, size: 19)),
                        hintText: "Enter name",
                        hintStyle: TextStyle(color: Colors.white38),
                      ),
                      controller: tname,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(
                  height: 70,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white30,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none),
                        prefixIcon: Icon(
                          Icons.call,
                          color: Colors.green,
                        ),
                        suffixIcon: IconButton(
                            onPressed: () => tcontact.text = "",
                            icon:
                            Icon(Icons.clear, color: Colors.red, size: 19)),
                        hintText: "Enter contact",
                        hintStyle: TextStyle(color: Colors.white38),
                      ),
                      controller: tcontact,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    String newname = tname.text;
                    String newcontact = tcontact.text;

                    int id = widget.map['id'];

                    String qry =
                        "update contactbook set name='$newname',contact='$newcontact' where id='$id'";
                    db!.rawUpdate(qry).then((value) {
                      print(value);

                      Fluttertoast.showToast(
                          msg: "Update successfully",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Color(0xff404040),
                          textColor: Colors.green,
                          fontSize: 16.0
                      );
                      Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) {
                          return viewpage();
                        },
                      ));
                    });
                  },
                  child: Container(
                      height:45,margin:EdgeInsets.fromLTRB(120,20,120,0),
                      decoration:BoxDecoration(color: Colors.green.shade400,borderRadius:BorderRadius.circular(10)),
                      alignment:Alignment.center,
                      child:Text("Update Contact",style:TextStyle(fontSize:16,fontFamily:"wlc",fontWeight:FontWeight.bold))
                  ),
                )
              ],
            )
        )
    );
  }
}
