import 'dart:io';

import 'package:flutter/material.dart';
import 'package:genescor/data/models/post.dart';
import 'package:image_picker/image_picker.dart';

import 'package:genescor/logic/declarations/constant.dart';

import 'package:genescor/data/models/api_response.dart';
import 'package:genescor/logic/services/user_service.dart';
import 'package:genescor/logic/services/post_service.dart';

//import 'package:genescor/screens/pages/home.dart';
import 'package:genescor/presentation/screens/auth/login.dart';

class PostForm extends StatefulWidget {
  final Post? post;
  final String? title;

  PostForm({
    this.post,
    this.title,
  });

  @override
  _PostFormState createState() => _PostFormState();
}

class _PostFormState extends State<PostForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController txtContent = TextEditingController();
  TextEditingController txtTopic = TextEditingController();
  bool loading = false;
  File? _imageFile;
  final _picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  void _createNewPost() async {
    print(postsURL);
    String? image = (_imageFile == null) ? null : getStringImage(_imageFile);

    ApiResponse response = await createPost(txtContent.text, image, 1);
    if (response.error == null) {
      Navigator.of(context).pop();
      //.push(MaterialPageRoute(builder: (context) => Home()));
    } else if ((response.error == 'Unauthenticated.') ||
        (response.error == 'unauthorized')) {
      logout().then((value) => {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => Login()),
                (route) => false)
          });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
      setState(() {
        loading = false;
      });
    }
  }

  void _editPost(int postId) async {
    //String? image = (_imageFile == null) ? null : getStringImage(_imageFile);

    ApiResponse response = await updatePost(postId, txtContent.text, 1);
    if (response.error == null) {
      Navigator.of(context).pop();
      //.push(MaterialPageRoute(builder: (context) => Home()));
    } else if ((response.error == 'Unauthenticated.') ||
        (response.error == 'unauthorized')) {
      logout().then((value) => {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => Login()),
                (route) => false)
          });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
      setState(() {
        loading = false;
      });
    }
  }

  @override
  void initState() {
    if (widget.post != null) {
      txtContent.text = widget.post!.content ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.title}'),
      ),
      body: loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView(children: [
              widget.post != null
                  ? SizedBox(height: 5)
                  : Container(
                      width: MediaQuery.of(context).size.width,
                      height: 200,
                      decoration: BoxDecoration(
                        image: _imageFile == null
                            ? null
                            : DecorationImage(
                                image: FileImage(_imageFile ?? File('')),
                                fit: BoxFit.cover),
                      ),
                      child: Center(
                        child: IconButton(
                            icon: Icon(Icons.image,
                                size: 50, color: Colors.black38),
                            onPressed: () {
                              getImage();
                            }),
                      ),
                    ),
              Form(
                key: _formKey,
                child: Padding(
                    padding: EdgeInsets.all(8),
                    child: TextFormField(
                      keyboardType: TextInputType.multiline,
                      controller: txtContent,
                      maxLines: 9,
                      validator: (val) =>
                          val!.isEmpty ? 'Content required...' : null,
                      decoration: InputDecoration(
                        hintText: "Content Here",
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: Colors.black38)),
                      ),
                    )),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: kTextButton('Post', () {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      loading = true;
                    });
                    if (widget.post == null) {
                      _createNewPost();
                    } else {
                      _editPost(widget.post!.id ?? 0);
                    }
                  }
                }, null),
              ),
              SizedBox(
                height: 10,
              )
            ]),
    );
  }
}
