part of 'sharedpreference_cubit.dart';

abstract class SharedpreferenceState extends Equatable {
  const SharedpreferenceState();

  @override
  List<Object> get props => [];

  @override
  String toString() => 'SharedpreferenceState';
}

class SharedpreferenceInitial extends SharedpreferenceState {}

class SharedpreferenceLoaded extends SharedpreferenceState {
  final String token;

  SharedpreferenceLoaded(this.token);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is SharedpreferenceLoaded && o.token == token;
  }

  @override
  int get hashCode => token.hashCode;

  @override
  List<Object> get props => [token];
}

class SharedpreferenceError extends SharedpreferenceState {
  final String message;
  const SharedpreferenceError(this.message);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is SharedpreferenceError && o.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
