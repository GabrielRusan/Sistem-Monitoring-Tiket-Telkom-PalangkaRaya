import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return events.throttleTime(duration, trailing: false).switchMap(mapper);
  };
}
