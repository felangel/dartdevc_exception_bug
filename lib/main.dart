import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

abstract class MyEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class Event extends MyEvent {
  @override
  String toString() => 'Event';
}

abstract class MyState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialState extends MyState {
  @override
  String toString() => 'InitialState';
}

class Loading extends MyState {
  @override
  String toString() => 'Loading';
}

class Success extends MyState {
  @override
  String toString() => 'Success';
}

class Failure extends MyState {
  @override
  String toString() => 'Failure';
}

class MyBloc extends Bloc<MyEvent, MyState> {
  @override
  MyState get initialState => InitialState();

  @override
  void onEvent(MyEvent event) {
    super.onEvent(event);
    print('$event');
  }

  @override
  void onTransition(Transition<MyEvent, MyState> transition) {
    print('$transition');
    super.onTransition(transition);
  }

  @override
  void onError(Object error, StackTrace stacktrace) {
    super.onError(error, stacktrace);
    print('$error, $stacktrace');
  }

  @override
  Stream<MyState> mapEventToState(
    MyEvent event,
  ) async* {
    if (event is Event) {
      yield Loading();
      try {
        await _foo();
        yield Success();
      } catch (e) {
        yield Failure();
      }
    }
  }

  Future<String> _foo() async {
    throw Exception('oops');
  }
}

void main() async {
  MyBloc bloc = MyBloc();

  bloc.add(Event());

  await Future.delayed(Duration(seconds: 1));

  bloc.add(Event());
}
