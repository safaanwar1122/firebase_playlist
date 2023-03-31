import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:untitled/utils_directory/utils.dart';
import 'package:untitled/widgets_directory/round_button.dart';

class AddFirestoreDataScreen extends StatefulWidget {
  const AddFirestoreDataScreen({Key? key}) : super(key: key);

  @override
  State<AddFirestoreDataScreen> createState() => _AddFirestoreDataScreenState();
}

class _AddFirestoreDataScreenState extends State<AddFirestoreDataScreen> {
  final postController = TextEditingController();
  bool loading=false;
  //final databaseRef = FirebaseDatabase.instance.ref('Post');
final fireStore=FirebaseFirestore.instance.collection('user');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add firestore data '),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          TextFormField(
            maxLines: 4,
            controller: postController,
            decoration: InputDecoration(
              hintText: 'What is in your mnind?',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          RoundButton(title: 'Add',
              loading: loading,
              onTap: (){
                setState(() {
                  loading=true;
                });
                String id=DateTime.now().millisecondsSinceEpoch.toString();
               fireStore.doc(id).set({
                 'title': postController.text.toString(),
                 'id': id,
               }).then((value) {
                 setState(() {
                   loading=false;
                 });
                 Utils().toastMessage('post added');
               }).onError((error, stackTrace) {
                 setState(() {
                   loading=false;
                 });
                 Utils().toastMessage(error.toString());
               });
              })
        ],
      ),
    );
  }

}
