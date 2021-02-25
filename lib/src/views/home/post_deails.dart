import 'package:cached_network_image/cached_network_image.dart';
import 'package:fabiantorresm/src/models/models.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class PostDetails extends StatelessWidget {
  final Post post;

  const PostDetails({Key key, @required Post this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Hero(
            tag: post.id,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                image: DecorationImage(
                  image: CachedNetworkImageProvider(post.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
              ),
              child: Center(
                child: Text(
                  post.title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            child: AppBar(
              title: Text("INPRODI"),
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
          )
        ],
      ),
    );
  }
}
