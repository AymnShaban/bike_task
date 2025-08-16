part of 'favorite_bloc.dart';

abstract class FavoriteEvent extends Equatable {
  const FavoriteEvent();
  @override
  List<Object?> get props => [];
}

class ToggleFavoriteEvent extends FavoriteEvent {
  final int productId;
  const ToggleFavoriteEvent(this.productId);
  @override
  List<Object?> get props => [productId];
}
