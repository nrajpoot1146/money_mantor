// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:logger/logger.dart' as _i974;

import '../Database/db.dart' as _i47;
import '../repository/person_repo.dart' as _i581;
import '../repository/taxation_repo.dart' as _i545;
import '../repository/transaction_repo.dart' as _i114;
import '../viewmodels/home_screen_viewmodel.dart' as _i382;
import '../viewmodels/person_viewmodel.dart' as _i837;
import '../viewmodels/transaction_viewmodel.dart' as _i657;

// initializes the registration of main-scope dependencies inside of GetIt
_i174.GetIt init(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i526.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  gh.factory<_i382.HomeScreenViewmodel>(
      () => _i382.HomeScreenViewmodel(gh<_i974.Logger>()));
  gh.singleton<_i47.DB>(() => _i47.DB(gh<_i974.Logger>()));
  gh.factory<_i545.TaxationRepo>(() => _i545.TaxationRepo(gh<_i47.DB>()));
  gh.singleton<_i581.PersonRepo>(() => _i581.PersonRepo(
        gh<_i47.DB>(),
        gh<_i974.Logger>(),
      ));
  gh.singleton<_i114.TransactionRepo>(() => _i114.TransactionRepo(
        gh<_i974.Logger>(),
        gh<_i47.DB>(),
      ));
  gh.factory<_i837.PersonViewModel>(() => _i837.PersonViewModel(
        gh<_i581.PersonRepo>(),
        gh<_i114.TransactionRepo>(),
        gh<_i974.Logger>(),
      ));
  gh.factory<_i657.TransactionViewModel>(() => _i657.TransactionViewModel(
        gh<_i114.TransactionRepo>(),
        gh<_i974.Logger>(),
      ));
  return getIt;
}
