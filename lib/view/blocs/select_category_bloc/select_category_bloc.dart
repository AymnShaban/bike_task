
import '../../../exports.dart';
part "select_category_event.dart";
class SelectCategoryBloc extends Bloc<CategoryEvent,int>{
  SelectCategoryBloc() : super(0) {
    on<SelectCategoryEvent>((event, emit) {
      emit(event.category.id);
    });
  }
}