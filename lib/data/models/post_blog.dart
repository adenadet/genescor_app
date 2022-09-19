import 'package:genescor/data/models/post_category.dart';
import 'package:genescor/data/models/post_author.dart';

class Blog {
  int? id;
  String? topic;
  String? image;
  String? content;
  int? userId;
  int? categoryId;
  int? status;
  String? approvedBy;
  String? publishedDate;
  String? createdAt;
  String? updatedAt;
  String? deletedBy;
  String? deletedAt;
  int? commentsCount;
  int? likesCount;
  Author? author;
  Category? category;
  String? approved;

  Blog(
      {this.id,
      this.topic,
      this.image,
      this.content,
      this.userId,
      this.categoryId,
      this.status,
      this.approvedBy,
      this.publishedDate,
      this.createdAt,
      this.updatedAt,
      this.deletedBy,
      this.deletedAt,
      this.commentsCount,
      this.likesCount,
      this.author,
      this.category,
      this.approved});

  Blog.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    topic = json['topic'];
    image = json['image'];
    content = json['content'];
    userId = json['user_id'];
    categoryId = json['category_id'];
    status = json['status'];
    approvedBy = json['approved_by'];
    publishedDate = json['published_date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedBy = json['deleted_by'];
    deletedAt = json['deleted_at'];
    commentsCount = json['comments_count'];
    likesCount = json['likes_count'];
    author = new Author.fromJson(json['author']);
    category = Category.fromJson(json['category']);
    approved = json['approved'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['topic'] = this.topic;
    data['image'] = this.image;
    data['content'] = this.content;
    data['user_id'] = this.userId;
    data['category_id'] = this.categoryId;
    data['status'] = this.status;
    data['approved_by'] = this.approvedBy;
    data['published_date'] = this.publishedDate;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_by'] = this.deletedBy;
    data['deleted_at'] = this.deletedAt;
    data['comments_count'] = this.commentsCount;
    data['likes_count'] = this.likesCount;
    if (this.author != null) {
      data['author'] = this.author!.toJson();
    }
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    data['approved'] = this.approved;
    return data;
  }
}
