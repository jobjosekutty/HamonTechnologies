import 'package:get_it/get_it.dart';
import 'package:hamontest/di/get_it.config.dart';
import 'package:injectable/injectable.dart';


final getIt = GetIt.instance;

@InjectableInit(asExtension: true, preferRelativeImports: true)
configdependency() async {
  getIt.init();
}
