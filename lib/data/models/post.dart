import 'user.dart';
import 'category.dart';

class Post {
  int? id;
  String? topic;
  String? image;
  int? likesCount;
  int? commentCount;
  String? content;
  User? author;
  Category? category;
  int? status;
  User? approver;
  String? publishedDate;
  bool? selfLiked;

  Post({
    this.id,
    this.topic,
    this.image,
    this.likesCount,
    this.commentCount,
    this.content,
    this.author,
    this.category,
    this.status,
    this.approver,
    this.publishedDate,
    this.selfLiked,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
        id: json['id'],
        topic: json['topic'],
        image: json['image'],
        likesCount: json['likes_count'],
        content: json['content'],
        /*author: User(
          id: json['author']['id'],
          firstName: json['author']['first_name'],
          lastName: json['author']['last_name'],
          image: json['author']['image'],
        ),*/
        category: Category(
          id: json['id'],
          name: json['name'],
        ),
        status: json['status'],
        /*approver: User(
        id: json['approver']['id'],
        firstName: json['approver']['first_name'],
        lastName: json['approver']['last_name'],
        image: json['approver']['image'],
      ),*/
        //  publishedDate: json['created_at'],
        selfLiked: json['likes'].length > 0,
        commentCount: json['comment_count']);
  }
}
