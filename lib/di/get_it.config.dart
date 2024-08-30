// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../data/repository/classroom_repo.dart' as _i417;
import '../data/repository/registration_repo.dart' as _i736;
import '../data/repository/student_repo.dart' as _i113;
import '../data/repository/subject_repo.dart' as _i87;
import '../presentation/provider/classroom_provider.dart' as _i165;
import '../presentation/provider/registration_provider.dart' as _i686;
import '../presentation/provider/student_provider.dart' as _i687;
import '../presentation/provider/subject_provider.dart' as _i659;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.lazySingleton<_i736.RegistrationRepo>(
        () => _i736.RegistrationRepoImpl());
    gh.lazySingleton<_i87.SubjectRepo>(() => _i87.SubjectRepoImpl());
    gh.lazySingleton<_i417.ClassroomRepo>(() => _i417.ClassroomRepoImpl());
    gh.lazySingleton<_i113.StudentRepo>(() => _i113.StudentRepoImpl());
    gh.factory<_i165.ClassroomProvider>(() =>
        _i165.ClassroomProvider(classroomRepo: gh<_i417.ClassroomRepo>()));
    gh.factory<_i659.SubjectProvider>(
        () => _i659.SubjectProvider(subjectRepo: gh<_i87.SubjectRepo>()));
    gh.factory<_i687.StudentProvider>(
        () => _i687.StudentProvider(studentRepo: gh<_i113.StudentRepo>()));
    gh.factory<_i686.RegistrationProvider>(() => _i686.RegistrationProvider(
        registrationRepo: gh<_i736.RegistrationRepo>()));
    return this;
  }
}
