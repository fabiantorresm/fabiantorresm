import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Post extends Equatable {
  int id;
  String title;
  String imageUrl;

  Post({this.id, this.title, this.imageUrl});

  Post.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['image_url'] = this.imageUrl;
    return data;
  }

  @override
  List<Object> get props => [id, title, imageUrl];

  @override
  String toString() => 'Post { id: $id }';
}
