import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:untitled/utils_directory/utils.dart';
import 'package:untitled/widgets_directory/round_button.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
 final postController = TextEditingController();
  bool loading=false;
  final databaseRef = FirebaseDatabase.instance.ref('Post');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Posts'),
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
            databaseRef.child(id).set({
              'title':postController.text.toString(),
              'userid':id,
            }).then((value) {
              Utils().toastMessage('post added');
              setState(() {
                loading=false;
              });
            }).onError((error, stackTrace) {
              Utils().toastMessage(error.toString());
              setState(() {
                loading=false;
              });
            });

          })
        ],
      ),
    );
  }

}
