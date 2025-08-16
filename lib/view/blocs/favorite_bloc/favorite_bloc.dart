import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
part 'favorite_event.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, Set<int>> {
  FavoriteBloc() : super(<int>{}) {
    on<ToggleFavoriteEvent>((event, emit) {
      final newSet = Set<int>.from(state);
      if (newSet.contains(event.productId)) {
        newSet.remove(event.productId);
      } else {
        newSet.add(event.productId);
      }
      emit(newSet);
    });
  }
}
