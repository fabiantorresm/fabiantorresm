import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

import 'package:fabiantorresm/src/providers/providers.dart';
import 'package:fabiantorresm/src/models/models.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final http.Client httpClient;
  Session user;

  PostBloc({@required this.httpClient}) : super(PostInitial());

  @override
  Stream<PostState> mapEventToState(
    PostEvent event,
  ) async* {
    final currentState = state;
    try {
      if (currentState is PostInitial) {
        final posts = await _fetchPosts();
        yield PostSuccess(posts: posts);
        return;
      }
      if (currentState is PostSuccess) {
        final posts = await _fetchPosts();
        yield PostSuccess(posts: posts);
        return;
      }
    } catch (_) {
      yield PostFailure();
    }
    // }
  }

  Future<List<Post>> _fetchPosts() async {
    final Session user = await AuthProvider.instance.getSession();
    Map<String, String> headers;
    headers = {
      'access-token': user.token,
      'client': user.client,
      'uid': user.uid,
    };
    final response = await httpClient
        .get('https://rails-web-api.herokuapp.com/api/posts', headers: headers);
    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List;
      return data.map((rawPost) {
        return Post(
          id: rawPost['id'],
          title: rawPost['title'],
          imageUrl: rawPost['image_url'],
        );
      }).toList();
    } else {
      throw Exception('error fetching posts');
    }
  }
}
