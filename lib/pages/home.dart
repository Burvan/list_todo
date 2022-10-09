import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late String _userToDo;
  List todo = [];



  @override
  void initState() {


    super.initState();
    todo.addAll(['To get a job', 'To earn money', 'To help my parents']);

  }

  void _menuOpen(){
    Navigator.of(context).push(
      MaterialPageRoute(builder: (BuildContext context){
        return Scaffold(
          backgroundColor: Colors.lime[200],
          appBar: AppBar(
            title: Text('Menu'),
            backgroundColor: Colors.lime,
            centerTitle: true,
          ),
          body: Row(
            children: [
              ElevatedButton(
                  onPressed: (){
                    Navigator.pop(context);
                    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
                  },
                  child: Text('On main page')
              ),
              Padding(padding: EdgeInsets.only(left: 15)),
              Text('Our simple menu'),
            ],
          ),
        );
      })
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lime[200],
      appBar: AppBar(
        backgroundColor: Colors.lime,
        title: Text('Notes'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: _menuOpen,
              icon: Icon(Icons.menu))
        ],
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('items').snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
            if(!snapshot.hasData) return Text('No data');
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (BuildContext context, int index){
                  return Dismissible(
                    key: Key(snapshot.data!.docs[index].id),
                    child: Card(
                      child: ListTile(
                        title: Text(snapshot.data!.docs[index].get('item')),
                        trailing: IconButton(
                          icon: Icon(
                            Icons.delete_forever,
                            color: Colors.lime,
                          ),
                          onPressed: (){
                            FirebaseFirestore.instance.collection('items').doc(snapshot.data!.docs[index].id).delete();
                          },
                        ),
                      ),
                    ),
                    onDismissed: (direction){
                      FirebaseFirestore.instance.collection('items').doc(snapshot.data!.docs[index].id).delete();
                    },
                  );
                }
            );
          }
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lime,
        onPressed: (){
          showDialog(context: context, builder: (BuildContext context){
            return AlertDialog(
              title: Text('Add an element'),
              content: TextField(
                onChanged: (String value){
                  _userToDo = value;

                },
              ),
              actions: [
                ElevatedButton(onPressed: (){
                  FirebaseFirestore.instance.collection('items').add({'item': _userToDo});
                  Navigator.of(context).pop();
                }, child: Text('Add'))
              ],
            );
          });
        },
        child: Icon(
          Icons.add_box,
          color: Colors.white,

        )
      ),

    );
  }
}
