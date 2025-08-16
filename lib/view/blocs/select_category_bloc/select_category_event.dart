part of "select_category_bloc.dart";

abstract interface class CategoryEvent extends Equatable {
  @override
  List<Object?> get props => [];
  const CategoryEvent();
}

class SelectCategoryEvent extends CategoryEvent {
  final Category category;

  const SelectCategoryEvent(this.category);

  @override
  List<Object?> get props => [category];
}
