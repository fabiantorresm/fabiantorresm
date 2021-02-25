import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fabiantorresm/src/providers/providers.dart';
import 'package:http/http.dart' as http;
import 'package:fabiantorresm/src/models/models.dart';
import 'package:meta/meta.dart';

part 'customer_event.dart';
part 'customer_state.dart';

class CustomerBloc extends Bloc<CustomerEvent, CustomerState> {
  CustomerBloc({@required this.httpClient}) : super(CustomerInitial());

  final http.Client httpClient;
  Session user;

  @override
  Stream<CustomerState> mapEventToState(
    CustomerEvent event,
  ) async* {
    final currentState = state;
    try {
      if (currentState is CustomerInitial) {
        final customers = await _fetchPosts();
        yield CustomerSuccess(customers: customers);
        return;
      }
      if (currentState is CustomerSuccess) {
        final customers = await _fetchPosts();
        yield CustomerSuccess(customers: customers);
        return;
      }
    } catch (_) {
      yield CustomerFailure();
    }
  }

  Future<List<Customer>> _fetchPosts() async {
    final Session user = await AuthProvider.instance.getSession();
    Map<String, String> headers;
    headers = {
      'access-token': user.token,
      'client': user.client,
      'uid': user.uid,
    };
    final response = await httpClient.get(
        'https://rails-web-api.herokuapp.com/api/customers',
        headers: headers);
    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List;
      // print('La solicitud generó: => ${data.length}');
      return data.map((rawCustomer) {
        return Customer(
          id: rawCustomer['id'],
          name: rawCustomer['name'],
          urlSite: rawCustomer['url_site'],
          urlImage: rawCustomer['url_image'],
        );
      }).toList();
    } else {
      throw Exception('error fetching customers');
    }
  }
}
