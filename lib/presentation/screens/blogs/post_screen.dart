import 'package:flutter/material.dart';

import 'package:genescor/logic/declarations/constant.dart';
import 'package:genescor/data/models/api_response.dart';
import 'package:genescor/data/models/post.dart';
import 'package:genescor/presentation/screens/blogs/post_form.dart';

import 'package:genescor/logic/services/post_service.dart';
import 'package:genescor/logic/services/user_service.dart';

import 'package:genescor/presentation/screens/auth/login.dart';

class PostScreen extends StatefulWidget {
  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  List<Post> _postList = [];
  int userId = 0;
  bool _loading = true;

  void handleDeletePost(int id) async {
    ApiResponse response = await deletePost(id);

    if (response.error == null) {
      retrievePosts();
    } else if ((response.error == 'Unauthorized') ||
        (response.error == 'Unauthenticated.')) {
      logout().then((value) => {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => Login()),
                (route) => false)
          });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
    }
  }

  void handlePostLike(int? id) async {
    ApiResponse response = await likeUnlikePost(id);

    if (response.error == null) {
      retrievePosts();
    } else if ((response.error == 'Unauthorized') ||
        (response.error == 'Unauthenticated.')) {
      logout().then((value) => {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => Login()),
                (route) => false)
          });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
    }
  }

  Future<void> retrievePosts() async {
    userId = await getUserId();
    ApiResponse response = await getPosts();

    if (response.error == null) {
      setState(() {
        _postList = response.data as List<Post>;
        _loading = false;
      });
    } else if (response.error == 'unauthorized') {
      logout().then((value) => {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => Login()),
                (route) => false)
          });
    } else {
      _loading = false;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
    }
  }

  @override
  void initState() {
    retrievePosts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? Center(child: Text("Loading"))
        : Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => PostForm(
                          title: 'New Post',
                        )));
              },
              child: Icon(Icons.add),
            ),
            body: RefreshIndicator(
                onRefresh: () {
                  return retrievePosts();
                },
                child: ListView.builder(
                    itemCount: _postList.length,
                    itemBuilder: (BuildContext context, int index) {
                      Post post = _postList[index];
                      return Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 4, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 6),
                                    child: Row(children: [
                                      Container(
                                        width: 38,
                                        height: 38,
                                        decoration: BoxDecoration(
                                            image: post.author!.image != null
                                                ? DecorationImage(
                                                    image: NetworkImage(
                                                        '$profileImageURL/${post.author!.image}'))
                                                : DecorationImage(
                                                    image: NetworkImage(
                                                        '$profileImageURL/default.png')),
                                            borderRadius:
                                                BorderRadius.circular(25),
                                            color: Colors.grey),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        '${post.author!.firstName} ${post.author!.lastName}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 17,
                                        ),
                                      )
                                    ]),
                                  ),
                                  post.author!.id == userId
                                      ? PopupMenuButton(
                                          child: Padding(
                                              padding:
                                                  EdgeInsets.only(right: 10),
                                              child: Icon(
                                                Icons.more_vert,
                                                color: Colors.black,
                                              )),
                                          itemBuilder: (context) => [
                                            PopupMenuItem(
                                                child: Text('Edit'),
                                                value: 'edit'),
                                            PopupMenuItem(
                                                child: Text('Delete'),
                                                value: 'delete'),
                                          ],
                                          onSelected: (val) {
                                            if (val == 'edit') {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          PostForm(
                                                              title:
                                                                  'Edit Post',
                                                              post: post)));
                                            } else if (val == 'delete') {
                                              handleDeletePost(post.id ?? 0);
                                            }
                                          },
                                        )
                                      : SizedBox(),
                                ]),
                            SizedBox(
                              height: 10,
                            ),
                            Text('${post.topic}',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                )),
                            post.image != null
                                ? Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 180,
                                    margin: EdgeInsets.only(top: 5),
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                      image: NetworkImage(
                                          '$uploadedImageURL/${post.image}'),
                                      fit: BoxFit.cover,
                                    )))
                                : Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 150,
                                    margin: EdgeInsets.only(top: 5),
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                      image: NetworkImage(
                                          '$baseDirectURL/assets/images/gallery/05.png'),
                                      fit: BoxFit.cover,
                                    ))),
                            Text(post.content!.length > 30
                                ? '${post.content!.substring(0, 30)}...'
                                : '${post.content}'),
                            Row(children: [
                              kLikeAndComment(
                                  post.likesCount ?? 0,
                                  post.selfLiked == true
                                      ? Icons.favorite
                                      : Icons.favorite_outline,
                                  post.selfLiked == true
                                      ? Colors.red
                                      : Colors.black54, () {
                                handlePostLike(post.id);
                              }),
                              kLikeAndComment(post.commentCount ?? 0,
                                  Icons.comment, Colors.black54, () {}),
                            ]),
                          ],
                        ),
                      );
                    })));
  }
}
