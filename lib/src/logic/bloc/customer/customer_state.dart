part of 'customer_bloc.dart';

abstract class CustomerState extends Equatable {
  const CustomerState();

  @override
  List<Object> get props => [];
}

class CustomerInitial extends CustomerState {}

class CustomerFailure extends CustomerState {}

class CustomerSuccess extends CustomerState {
  final List<Customer> customers;

  const CustomerSuccess({this.customers});

  @override
  List<Object> get props => [customers];

  @override
  String toString() => 'CustomerSuccess { posts: ${customers.length} }';
}

class CustomerError extends CustomerState {
  final String message;
  const CustomerError(this.message);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is CustomerError && o.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
