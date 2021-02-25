import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Customer extends Equatable {
  int id;
  String name;
  String urlSite;
  String urlImage;

  Customer({this.id, this.name, this.urlSite, this.urlImage});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    urlSite = json['url_site'];
    urlImage = json['url_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['url_site'] = this.urlSite;
    data['url_image'] = this.urlImage;
    return data;
  }

  @override
  List<Object> get props => [id, name, urlSite, urlImage];

  @override
  String toString() => 'Customer { id: $id }';
}
