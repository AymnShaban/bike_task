

import '../../exports.dart';

final GetIt getIt = GetIt.instance;

abstract interface class ServiceLocator {
      static Future<void> init() async{
        getIt.registerFactory<SelectCategoryBloc>(() => SelectCategoryBloc());
      }
}