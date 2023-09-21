// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:coinpulse2/1_Domain/usecases/bill_usecase.dart' as _i4;
import 'package:coinpulse2/2_Presentation/bloc/bill_bloc.dart' as _i3;
import 'package:coinpulse2/2_Presentation/bloc/income_bloc.dart' as _i5;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i3.BillBloc>(() => _i3.BillBloc());
    gh.factory<_i4.BillUseCases>(() => _i4.BillUseCases());
    gh.factory<_i5.IncomeBloc>(() => _i5.IncomeBloc());
    return this;
  }
}
