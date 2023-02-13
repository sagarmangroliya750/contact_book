// ignore_for_file: prefer_const_constructors, camel_case_types, use_key_in_widget_constructors, unnecessary_string_interpolations, must_be_immutable, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, unnecessary_brace_in_string_interps
import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_icon_button.dart';
import 'package:getwidget/shape/gf_icon_button_shape.dart';
import 'package:sqflite/sqflite.dart';
import 'Model.dart';

class contview extends StatefulWidget {
  Map map;

  contview(this.map);

  @override
  State<contview> createState() => _contviewState();
}

class _contviewState extends State<contview> {
  List<Color> clr = [
    Colors.teal,
    Colors.greenAccent,
    Colors.orangeAccent,
    Colors.pinkAccent,
    Colors.lime,
    Colors.deepPurpleAccent,
    Colors.yellow,
    Colors.brown,
    Colors.deepOrange,
    Colors.indigoAccent,
    Colors.lightGreenAccent,
    Colors.tealAccent,
    Colors.deepPurpleAccent,
    Colors.tealAccent,
    Colors.teal,
    Colors.teal,
    Colors.teal,
    Colors.teal,
    Colors.teal,
    Colors.teal,
    Colors.teal,
    Colors.teal,
    Colors.teal,
    Colors.teal,
    Colors.teal,
    Colors.teal,
    Colors.teal,
    Colors.teal,
    Colors.teal,
    Colors.teal,
    Colors.teal,
  ];
  Database? db;
  TextEditingController tname = TextEditingController();
  TextEditingController tcontact = TextEditingController();

  TextEditingController tdate = TextEditingController();
  TextEditingController tsec = TextEditingController();
  TextEditingController tinout = TextEditingController();

  TextEditingController tdate2 = TextEditingController();
  TextEditingController tsec2 = TextEditingController();
  TextEditingController tinout2 = TextEditingController();

  String datetime = "";
  String sec = "";

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        actions: [
          Icon(Icons.star_border, color: Colors.green, size: 22),
          PopupMenuButton(
            color: Color(0xff404040),
            icon: Icon(Icons.more_vert, color: Colors.green),
            constraints: BoxConstraints(maxWidth: 150),
            position: PopupMenuPosition.under,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            itemBuilder: (context) => [
              PopupMenuItem(
                height: 40,
                child: Text("Edit",
                    style: TextStyle(fontSize: 14, color: Colors.white)),
              ),
              PopupMenuItem(
                  height: 40,
                  child: Text("Share Contact",
                      style: TextStyle(fontSize: 14, color: Colors.white))),
              PopupMenuItem(
                  height: 40,
                  child: Text("Add to Vip Contact",
                      style: TextStyle(fontSize: 14, color: Colors.white))),
              PopupMenuItem(
                  height: 40,
                  child: Text("Add to Blacklist",
                      style: TextStyle(fontSize: 14, color: Colors.white))),
              PopupMenuItem(
                  height: 40,
                  child: Text("Delete",
                      style: TextStyle(fontSize: 14, color: Colors.white))),
            ],
          )
        ],
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: ListView(
        children: [
          CircleAvatar(
            maxRadius: 40,
            foregroundColor: Colors.white,
            child: Text(tname.text.substring(0, 1).trim().toUpperCase(),
                style: TextStyle(fontSize: 38)),
          ),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: 20),
            child: Text(tname.text,
                style: TextStyle(fontSize: 22, color: Colors.white)),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                margin: EdgeInsets.only(left: 0, top: 25),
                child: GFIconButton(
                  onPressed: () {},
                  color: Colors.white30,
                  shape: GFIconButtonShape.circle,
                  icon: Icon(Icons.call_outlined, size: 22),
                  size: 40,
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 0, top: 25),
                child: GFIconButton(
                    onPressed: () {},
                    color: Colors.white30,
                    shape: GFIconButtonShape.circle,
                    icon: Icon(Icons.message_sharp, size: 22),
                    size: 40),
              ),
              Container(
                margin: EdgeInsets.only(left: 0, top: 25),
                child: GFIconButton(
                  onPressed: () {},
                  color: Colors.white30,
                  shape: GFIconButtonShape.circle,
                  icon: Icon(Icons.video_call, size: 24),
                  size: 40,
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                margin: EdgeInsets.only(left: 25, right: 20, top: 10),
                child: Text("Call",
                    style: TextStyle(fontSize: 13, color: Colors.white60)),
              ),
              Container(
                margin: EdgeInsets.only(left: 9, right: 20, top: 10),
                child: Text("Massage",
                    style: TextStyle(fontSize: 13, color: Colors.white60)),
              ),
              Container(
                margin: EdgeInsets.only(right: 20, top: 10),
                child: Text("Video",
                    style: TextStyle(fontSize: 13, color: Colors.white60)),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(top: 50, left: 30),
                child: Icon(
                  Icons.call_outlined,
                  color: Colors.white,
                  size: 22,
                ),
              ),
              Container(
                  margin: EdgeInsets.only(top: 50, left: 12),
                  child: Column(
                    children: [
                      Text("+91 ${tcontact.text}",
                          style: TextStyle(color: Colors.white, fontSize: 16)),
                      Container(
                          margin: EdgeInsets.only(right: 45),
                          child: Text("   Mobile | India",
                              style: TextStyle(  fontSize: 12, color: Colors.white54)))
                    ],
                  )),
              Container(
                margin: EdgeInsets.only(top: 38, left: 110),
                child: GFIconButton(
                    onPressed: () {},
                    color: Colors.white30,
                    shape: GFIconButtonShape.circle,
                    icon: Icon(Icons.message_sharp, size: 19),
                    size: 35),
              ),
            ],
          ),
          Container(
              margin: EdgeInsets.only(top: 20, left: 30),
              child: Row(
                children: [
                  Icon(Icons.whatsapp, color: Colors.green, size: 18),
                  Text("  WhatsApp",
                      style: TextStyle(color: Colors.white, fontSize: 12.5)),
                ],
              )),

          Container(
              margin: EdgeInsets.only(top: 25, left: 40),
              child: Row(
                children: [
                  Text("Message +91 ${tcontact.text}",
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                ],
              )),
          Container(
              margin: EdgeInsets.only(top: 25, left: 40),
              child: Row(
                children: [
                  Text("Voice call +91 ${tcontact.text}",
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                ],
              )),
          Container(
              margin: EdgeInsets.only(top: 25, left: 40),
              child: Row(
                children: [
                  Text("Video call +91 ${tcontact.text}",
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                  ],
              )),
            ],
         ),
      );
   }
}
