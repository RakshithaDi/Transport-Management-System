import 'package:flutter/material.dart';
import 'package:tma_passenger/screens/addride/pickup.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:async/async.dart';

// Init firestore and geoFlutterFire
final geo = Geoflutterfire();
final _firestore = FirebaseFirestore.instance;


class SelectDestination extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Select Destination',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

 TextEditingController _searchview = TextEditingController();
 bool _firstSearch = true;
 String _query = "";

 List<String> _nebulae;
 List<String> _filterList;

 var _location;

 @override
 void initState()
 {
   super.initState();
    print(_location);

 }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Destination"),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),

      body: Column(
        children: <Widget>[
          TextField(
            controller: _searchview,
             decoration: InputDecoration(
             prefixIcon:Icon(Icons.search),
               hintText: "Search Your Destination",
            ),
          ),
        Expanded(
          child:

          StreamBuilder(


              stream: FirebaseFirestore.instance.collection("cities").snapshots(),
              builder: (context, snapshot) {
                return ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot cities = snapshot.data.docs[index];

                    return Card(
                        child:ListTile(
                         title: Text(cities['location']),
                          subtitle: Text(cities['name']),

                          onTap: (){},
                        ),
                    );

                  },

                );
              }
          ),
        ),
        ],
      ) ,

      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(builder: (context) => SelectPickup()),
      //     );
      //   },
      //   child: Icon(Icons.arrow_forward_ios),
      //   backgroundColor: Colors.black87,
      // ),

    );
  }

}


