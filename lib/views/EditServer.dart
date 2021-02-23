// import 'package:activator/items/ServerDBItem.dart';
// import 'package:flutter/material.dart';
// import 'package:activator/helper/DBHelper.dart';
// import 'package:activator/helper/FirestoreHelper.dart';
// import 'package:activator/items/ServerDBItem.dart';
// import 'package:activator/models/ServerModel.dart';
// import 'package:activator/database/DB.dart';
//
// class EditServer extends StatefulWidget {
//   final DBHelper helper;
//   ServerDBItem item;
//
//   final FirestoreHelper fhelper;
//
//   EditServer({this.helper, this.item, this.fhelper});
//
//   @override
//   _EditServerState createState() => _EditServerState();
// }
//
// class _EditServerState extends State<EditServer> {
//
//   String title, url, token;
//
//   final _title = TextEditingController();
//   final _url = TextEditingController();
//   final _token = TextEditingController();
//
//   // checkTextFieldEmptyOrNot() {
//   //   title = _title.text;
//   //   url = _url.text;
//   //   token = _token.text;
//   //   if(title == '' || url == '' || token == '') {
//   //     print("All fields are required");
//   //   }
//   // }
//
//   @override
//   void initState() {
//     super.initState();
//
//     _title.addListener(() {
//       setState(() { });
//     });
//
//     _url.addListener(() {
//       setState(() { });
//     });
//
//     _token.addListener(() {
//       setState(() { });
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//       appBar: new AppBar(
//         title: new Text("Add New Server"),
//         actions: <Widget>[
//           new IconButton(
//               icon: const Icon(Icons.save),
//               onPressed: () {
//                   Navigator.pop(context);
//                   widget.item = ServerDBItem(title: title, url: url, token: token);
//                   DataBase.insert(ServerDBItem.table, widget.item);
//                   FirestoreHelper.addNewServer(title, url, token);
//                   // widget.helper.saveServer(ServerItem.table, widget.item);
//                   setState(() => title = '');
//                   setState(() => url = '');
//                   setState(() => token = '');
//               })
//         ],
//       ),
//       body: new Column(
//         children: <Widget>[
//           new ListTile(
//             title: new TextFormField(
//               controller: _title,
//               decoration: new InputDecoration(
//                 border: OutlineInputBorder(),
//                 labelText: 'Server Title',
//                 suffixIcon: _title.text.isNotEmpty
//                   ? IconButton(
//                   onPressed: () => _title.clear(),
//                   icon: Icon(Icons.clear),
//                 ): null,
//               ),
//               onChanged: (value) {
//                 title = value;
//               },
//               keyboardType: TextInputType.text,
//             ),
//           ),
//           new ListTile(
//             title: new TextFormField(
//               controller: _url,
//               decoration: new InputDecoration(
//                 border: OutlineInputBorder(),
//                 labelText: 'Server URL',
//                   suffixIcon: _url.text.isNotEmpty
//                       ? IconButton(
//                     onPressed: () => _url.clear(),
//                     icon: Icon(Icons.clear),
//                   ): null,
//               ),
//               onChanged: (value) {
//                 url = value;
//               },
//               keyboardType: TextInputType.url,
//             ),
//           ),
//           new ListTile(
//             title: new TextFormField(
//               controller: _token,
//               decoration: new InputDecoration(
//                 border: OutlineInputBorder(),
//                 labelText: 'Authorization Token',
//                   suffixIcon: _token.text.isNotEmpty
//                       ? IconButton(
//                     onPressed: () => _token.clear(),
//                     icon: Icon(Icons.clear),
//                   ): null,
//               ),
//               onChanged: (value) {
//                 token = value;
//               },
//               keyboardType: TextInputType.text,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
