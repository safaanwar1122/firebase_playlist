import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import '../../utils_directory/utils.dart';
import '../authentication_directory/login_screen.dart';
import '../posts_directory/add_posts.dart';
import 'add_firestore_data.dart';

class FireStoreScreen extends StatefulWidget {
  const FireStoreScreen({Key? key}) : super(key: key);

  @override
  State<FireStoreScreen> createState() => _FireStoreScreenState();
}

class _FireStoreScreenState extends State<FireStoreScreen> {
  final auth = FirebaseAuth.instance;
 // final ref = FirebaseDatabase.instance.ref('Post');
  //final searchFiler = TextEditingController();
  final editControoler = TextEditingController();
  final fireStore=FirebaseFirestore.instance.collection('user').snapshots();
  CollectionReference ref=FirebaseFirestore.instance.collection('user');
  //final ref1=FirebaseFirestore.instance.collection('users');

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text('Firestore '),
        actions: [
          IconButton(
            onPressed: () {
              auth.signOut().then((value) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              }).onError((error, stackTrace) {
                Utils().toastMessage(error.toString());
              });
            },
            icon: Icon(Icons.logout_outlined),
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          StreamBuilder<QuerySnapshot>
            (stream: fireStore,
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
              if(snapshot.connectionState==ConnectionState.waiting)
                return CircularProgressIndicator();
              if(snapshot.hasError)
                return Text('Some error');

              return  Expanded(
                  child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index){
                        return ListTile(
                          onTap: (){
                            // ref.doc(snapshot.data!.docs[index]['id'].toString()).update({
                            //   'title': 'safa anwar'
                            // }).then((value) {
                            //   Utils().toastMessage('updated');
                            // }).onError((error, stackTrace) {
                            //   Utils().toastMessage(error.toString());
                            // });
                            ref.doc(snapshot.data!.docs[index]['id'].toString()).delete();

                          },
                          title: Text(snapshot.data!.docs[index]['title'].toString()),
                          subtitle: Text(snapshot.data!.docs[index]['id'].toString()),

                        );
                      }),
              );
              }),

        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddFirestoreDataScreen()));
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> showMyDialog(String title, String id) async {
    editControoler.text = title;
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Update'),
            content: Container(
              child: TextField(
                controller: editControoler,
                decoration: InputDecoration(
                  hintText: 'edit here ',
                ),
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel')),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);

                  },
                  child: Text('Update')),
            ],
          );
        });
  }
}
