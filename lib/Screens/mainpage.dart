import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class MainPage extends StatefulWidget {
  const MainPage({ Key? key }) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  CollectionReference books=FirebaseFirestore.instance.collection('Books');
  TextEditingController _namecontroller=TextEditingController();
  TextEditingController _pagecontroller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(child:Text("Books:",style: TextStyle(fontSize: 20))),
            Container(child:Text("Pages:",style: TextStyle(fontSize: 20))),
          ],
        ),
        Expanded(
          child: StreamBuilder(
            stream: books.snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if(!snapshot.hasData){
                return Center(child: Text("Loading..."),);
              }
              final data= snapshot.requireData;
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder:(context,index){
                    return Padding(
                      padding:const EdgeInsets.all(8.0),
                      child: Card(
                        child: ListTile(
                          title:Text("${data.docs[index]["name"]}"),
                          trailing:Text("${data.docs[index]["page"]}") ,
                          onTap: editScreen,
                        ),
                      ), 
                    );
                  } 
                );
              
            },
          )
          )
      ],
    );
  }
  editScreen(){

  }

  
}

