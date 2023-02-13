// ignore_for_file: camel_case_types, prefer_const_constructors, prefer_is_empty, unnecessary_brace_in_string_interps, avoid_print, prefer_const_literals_to_create_immutables, unrelated_type_equality_checks, unnecessary_null_comparison

import 'package:contact_book/updatepage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/shape/gf_button_shape.dart';
import 'package:sqflite/sqflite.dart';
import 'Model.dart';
import 'cont_view.dart';
import 'insertpage.dart';

class viewpage extends StatefulWidget {
  const viewpage({Key? key}) : super(key: key);

  @override
  State<viewpage> createState() => _viewpageState();
}

class _viewpageState extends State<viewpage> {
  Database? db;
  List<Map> l = [];
  var index = 0;

  List<Color> c = [
    Colors.teal,Colors.greenAccent,Colors.orangeAccent,Colors.pinkAccent,Colors.lime,Colors.deepPurpleAccent,Colors.yellow,Colors.brown,
    Colors.deepOrange,Colors.indigoAccent,
    Colors.lightGreenAccent,Colors.tealAccent,Colors.deepPurpleAccent,Colors.tealAccent,Colors.teal,Colors.teal,Colors.teal,Colors.teal,Colors.teal,Colors.teal,
    Colors.teal,Colors.teal,Colors.teal,Colors.teal,Colors.teal,Colors.teal,Colors.teal,Colors.teal,Colors.teal,Colors.teal,Colors.teal,
  ];

  bool cler = false;
  bool status = false;

  TextEditingController t1 = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // READ  :SELECT
    Model().createDatabase().then((value) {
      db = value;
      String qry = "select * from contactbook";
      db!.rawQuery(qry).then((value1) {
        l = value1;
        print(l);

        setState(() {
          status = true;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Contact", style: TextStyle(color: Colors.green)),
        centerTitle: true,
        leading: Container(
            alignment: Alignment.center,
            child: Text("Edit",style: TextStyle(fontSize: 17, color: Colors.green),
            )),
        actions: [
          PopupMenuButton(
            color: Color(0xff404040),
            icon: Icon(Icons.more_vert, color: Colors.green),
            constraints: BoxConstraints(maxWidth: 147),
            position: PopupMenuPosition.under,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            itemBuilder: (context) => [
              PopupMenuItem(
                  height: 40,
                  child: Text("Scan Card",
                      style: TextStyle(fontSize: 14, color: Colors.white))),
              PopupMenuItem(
                  height: 40,
                  child: Text("Name Card Folder",
                      style: TextStyle(fontSize: 14, color: Colors.white))),
              PopupMenuItem(
                  height: 40,
                  child: Text("My Groups",
                      style: TextStyle(fontSize: 14, color: Colors.white))),
              PopupMenuItem(
                  height: 40,
                  child: Text("Setting",
                      style: TextStyle(fontSize: 14, color: Colors.white))),
            ],
          )
        ],
      ),
      body: status
          ? (l.length > 0
          ? Column(
        children: [
          SizedBox(
            height: 52, width: 330,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: t1,
                cursorColor: Colors.green.withOpacity(0.7),
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(5),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.2),
                    prefixIcon: Icon(
                      Icons.search_rounded, size: 20, color: Colors.white30,
                    ),
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            t1.text = "";
                          });
                        },
                        icon: Icon(
                          Icons.clear_rounded,color: Colors.red.withOpacity(0.4), size: 18,
                        )),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none),
                    hintText: "Search contacts . . .",
                    hintStyle: TextStyle(color: Colors.white30)),
              ),
            ),
          ),
          Expanded(
              child: ListView.builder(
                itemCount:l.length,
                itemBuilder: (context, index) {
                  Map map = l[index];
                  String name = map['name'];
                  String contact = map['contact'];
                  int id = map['id'];

                  return ListTile(
                    leading: CircleAvatar(
                      maxRadius: 22,
                      backgroundColor:c[index],
                      foregroundColor: Colors.white,
                      child: Text(name.substring(0, 1),style: TextStyle(fontSize: 18)),
                    ),
                    title: Text(name, style: TextStyle(color: Colors.white)),onTap:() {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return contview(map);
                    },));
                  },
                    subtitle: Text(contact, style: TextStyle(color: Colors.white70),
                    ),
                    onLongPress: () {
                      showDialog(
                        barrierDismissible:false,
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(10)),
                            backgroundColor:Color(0xff404040),
                            title: Row(
                              mainAxisAlignment:MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Select",style: TextStyle(color: Colors.blueAccent)),
                                IconButton(onPressed: () {
                                  Navigator.pop(context);
                                }, icon:Icon(Icons.disabled_by_default_outlined,color:Colors.red.shade300,size:20
                                ))
                              ],
                            ),
                            content: Text("You want Delete or Update this Contact..!?",style:TextStyle(color:Colors.white),),
                            actions: [
                              GFButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return updatepage(map);
                                        },
                                      ));
                                },
                                text: "Update",textStyle: TextStyle(fontSize: 14),
                                shape: GFButtonShape.pills,
                                color: Colors.green.shade400,
                              ),
                              GFButton(
                                onPressed: () {

                                  Navigator.pop(context);

                                  Fluttertoast.showToast(
                                      msg: "Delete successfully",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Color(0xff404040),
                                      textColor: Colors.green,
                                      fontSize: 16.0
                                  );

                                  String qry = "delete from contactbook where id='$id'";
                                  db!.rawDelete(qry).then((value) {
                                    Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) {
                                      return viewpage();
                                    },));
                                  });
                                },
                                text: "Delete",
                                textStyle: TextStyle(fontSize: 14),
                                shape: GFButtonShape.pills,
                                color: Colors.red.shade400,
                              ),
                            ],
                          );
                        },
                      );
                    },
                  );
                },
              )),
        ],
      )
          : Center(child:Column(children: [
        Container(
          margin:EdgeInsets.fromLTRB(20,250,20,0),
          child:Icon(Icons.cleaning_services_rounded,color:Colors.white38,size:50),
        ),
        Container(
            margin:EdgeInsets.fromLTRB(20,10,20,0),
            child:Text("No Data Found...",style:TextStyle(color:Colors.white54,fontSize:14),)
        ),
      ],)))
          : Center(child: CircularProgressIndicator()),
      floatingActionButton: Container(
        margin: EdgeInsets.only(bottom: 10),
        child: FloatingActionButton(
            backgroundColor: Colors.green,
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) {
                  return insertpage();
                },
              ));
            },
            child: Icon(Icons.add)),
      ),
    );
  }
}
