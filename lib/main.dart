import 'package:flutter/material.dart';
import 'package:booktracker/Screens/mainpage.dart';
import 'package:booktracker/Screens/finishedbks.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:booktracker/Screens/functions.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(home:MyApp(),title: "Book Tracker",));
}
class MyApp extends StatefulWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
 int _selectedIndex=0;
 CollectionReference books=FirebaseFirestore.instance.collection('Books');
 TextEditingController _namecontroller=TextEditingController();
 TextEditingController _pagecontroller=TextEditingController();
  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              title: Text("Book Tracker",
              style: TextStyle(color: Colors.black,fontSize: 30)),
              backgroundColor: Color.fromARGB(255, 253, 208, 1),
              actions: [
                IconButton(
                  onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context){
                    return AlertDialog(
                      title: Text("Add a Book"),
                      content:Column(children:[
                        TextField(
                          autofocus: true,
                          controller: _namecontroller,
                          decoration: InputDecoration(
                            hintText:"Enter the book's name",
                            contentPadding: EdgeInsets.all(16.0)
                          ),
                        ),
                        TextField(
                          autofocus: true,
                          keyboardType: TextInputType.number,
                          controller: _pagecontroller,
                          decoration: InputDecoration(
                            hintText:"Enter the book's page",
                            contentPadding: EdgeInsets.all(16.0)
                          ),
                        )
                      ],),
                      actions: [
                        FlatButton(
                          onPressed: () => Navigator.of(context).pop(),
                         child: Text("Cancel")
                         ),
                         FlatButton(
                           onPressed: (){
                             books.add(
                               {
                                 'name':_namecontroller.text,
                                 'page':_pagecontroller.value,
                               }
                             ).then((value) => print("book added")).catchError((error)=> print("Failes to add book:$error"));
                             Navigator.of(context).pop();
                             _namecontroller.clear();
                             _pagecontroller.clear();
                           },
                          child: Text("Add a Book"))
                      ] ,
                    );
                  }
                  );
                  },
                   icon: Icon(Icons.add,color: Colors.black,size: 30,),
                   tooltip: "Add a Book",
                  )
              ],
            ),
            body: TabBarView(
              children: [
                MainPage(),
                Finishedbks(),
              ],
              ),
              bottomNavigationBar: BottomNavigationBar(
                items:const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(Icons.book),
                    label: "Home"
                  ),
                  BottomNavigationBarItem(
                    icon:Icon(Icons.done),
                    label: "Finished"
                  )
                ],
                currentIndex: _selectedIndex,
                selectedItemColor: Colors.black,
                onTap: _onItemTapped,
              ),
          ),
        ) ,
    );
        
    
  }
  _onItemTapped(int index){
    setState(() {
      _selectedIndex=index;
    });
  }
}
