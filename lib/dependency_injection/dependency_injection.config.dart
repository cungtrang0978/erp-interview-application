// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../core/services/local/local_database_service.dart' as _i460;
import '../core/services/remote/remote_database_service.dart' as _i961;
import '../core/services/remote/services/auth_service.dart' as _i416;
import '../core/services/remote/services/customer_service.dart' as _i822;
import '../core/services/remote/services/inventory_service.dart' as _i540;
import '../core/services/remote/services/product_service.dart' as _i104;
import '../core/services/remote/services/purchase_order_service.dart' as _i244;
import '../core/services/remote/services/sale_order_service.dart' as _i547;
import '../core/services/remote/services/warehouse_service.dart' as _i116;
import '../data/datasources/auth_datasource.dart' as _i645;
import '../data/datasources/customer_datasource.dart' as _i2;
import '../data/datasources/inventory_datasource.dart' as _i124;
import '../data/datasources/product_datasource.dart' as _i795;
import '../data/datasources/purchase_order_datasource.dart' as _i675;
import '../data/datasources/sale_order_datasource.dart' as _i1024;
import '../data/datasources/warehouse_datasource.dart' as _i973;
import '../data/repositories/auth_repository_impl.dart' as _i74;
import '../data/repositories/customer_repository_impl.dart' as _i334;
import '../data/repositories/inventory_repository_impl.dart' as _i95;
import '../data/repositories/product_repository_impl.dart' as _i839;
import '../data/repositories/purchase_order_repository_impl.dart' as _i256;
import '../data/repositories/sale_order_repository_impl.dart' as _i944;
import '../data/repositories/warehouse_repository_impl.dart' as _i837;
import '../domain/repositories/auth_repository.dart' as _i800;
import '../domain/repositories/customer_repository.dart' as _i907;
import '../domain/repositories/inventory_repository.dart' as _i389;
import '../domain/repositories/product_repository.dart' as _i747;
import '../domain/repositories/purchase_order_repository.dart' as _i393;
import '../domain/repositories/sale_order_repository.dart' as _i453;
import '../domain/repositories/warehouse_repository.dart' as _i605;
import '../presentations/choose_account/choose_account_cubit.dart' as _i144;
import '../presentations/login/login_cubit.dart' as _i181;
import '../presentations/purchase_order/controllers/purchase_order_cubit.dart'
    as _i1032;
import '../presentations/register/register_cubit.dart' as _i57;
import '../presentations/root/root_cubit.dart' as _i309;
import '../presentations/sales_order/controllers/create_sale_order_cubit.dart'
    as _i591;
import '../presentations/sales_order/controllers/create_sale_order_info_cubit.dart'
    as _i523;
import '../presentations/sales_order/controllers/sale_order_detail_cubit.dart'
    as _i929;
import '../presentations/sales_order/controllers/sale_order_list_cubit.dart'
    as _i1064;

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
    gh.lazySingleton<_i961.RemoteDatabaseService>(
        () => _i961.RemoteDatabaseService());
    gh.lazySingleton<_i460.LocalDatabaseService>(
        () => _i460.LocalDatabaseService());
    gh.lazySingleton<_i244.PurchaseOrderService>(
        () => _i244.PurchaseOrderService());
    gh.lazySingleton<_i822.CustomerService>(() => _i822.CustomerService());
    gh.lazySingleton<_i116.WarehouseService>(() => _i116.WarehouseService());
    gh.lazySingleton<_i104.ProductService>(() => _i104.ProductService());
    gh.lazySingleton<_i416.AuthService>(() => _i416.AuthService());
    gh.lazySingleton<_i547.SaleOrderService>(() => _i547.SaleOrderService());
    gh.lazySingleton<_i540.InventoryService>(() => _i540.InventoryService());
    gh.lazySingleton<_i795.ProductDataSource>(
        () => _i795.ProductDataSource(gh<_i104.ProductService>()));
    gh.lazySingleton<_i645.AuthDataSource>(() => _i645.AuthDataSource(
          gh<_i416.AuthService>(),
          gh<_i460.LocalDatabaseService>(),
        ));
    gh.lazySingleton<_i2.CustomerDataSource>(
        () => _i2.CustomerDataSource(gh<_i822.CustomerService>()));
    gh.lazySingleton<_i973.WarehouseDataSource>(
        () => _i973.WarehouseDataSource(gh<_i116.WarehouseService>()));
    gh.lazySingleton<_i1024.SaleOrderDataSource>(
        () => _i1024.SaleOrderDataSource(
              gh<_i547.SaleOrderService>(),
              gh<_i540.InventoryService>(),
            ));
    gh.lazySingleton<_i675.PurchaseOrderDataSource>(
        () => _i675.PurchaseOrderDataSource(gh<_i244.PurchaseOrderService>()));
    gh.lazySingleton<_i124.InventoryDataSource>(
        () => _i124.InventoryDataSource(gh<_i540.InventoryService>()));
    gh.lazySingleton<_i747.ProductRepository>(
        () => _i839.ProductRepositoryImpl(gh<_i795.ProductDataSource>()));
    gh.lazySingleton<_i453.SaleOrderRepository>(
        () => _i944.SaleOrderRepositoryImpl(gh<_i1024.SaleOrderDataSource>()));
    gh.lazySingleton<_i800.AuthRepository>(
        () => _i74.AuthRepositoryImpl(gh<_i645.AuthDataSource>()));
    gh.lazySingleton<_i393.PurchaseOrderRepository>(() =>
        _i256.PurchaseOrderRepositoryImpl(gh<_i675.PurchaseOrderDataSource>()));
    gh.lazySingleton<_i389.InventoryRepository>(
        () => _i95.InventoryRepositoryImpl(gh<_i124.InventoryDataSource>()));
    gh.lazySingleton<_i907.CustomerRepository>(
        () => _i334.CustomerRepositoryImpl(gh<_i2.CustomerDataSource>()));
    gh.lazySingleton<_i605.WarehouseRepository>(
        () => _i837.WarehouseRepositoryImpl(gh<_i973.WarehouseDataSource>()));
    gh.factory<_i591.CreateSaleOrderCubit>(
        () => _i591.CreateSaleOrderCubit(gh<_i453.SaleOrderRepository>()));
    gh.factory<_i1064.SaleOrderListCubit>(
        () => _i1064.SaleOrderListCubit(gh<_i453.SaleOrderRepository>()));
    gh.factory<_i929.SaleOrderDetailCubit>(
        () => _i929.SaleOrderDetailCubit(gh<_i453.SaleOrderRepository>()));
    gh.factory<_i1032.PurchaseOrderCubit>(
        () => _i1032.PurchaseOrderCubit(gh<_i393.PurchaseOrderRepository>()));
    gh.factory<_i144.ChooseAccountCubit>(
        () => _i144.ChooseAccountCubit(gh<_i800.AuthRepository>()));
    gh.factory<_i57.RegisterCubit>(
        () => _i57.RegisterCubit(gh<_i800.AuthRepository>()));
    gh.factory<_i309.RootCubit>(
        () => _i309.RootCubit(gh<_i800.AuthRepository>()));
    gh.factory<_i181.LoginCubit>(
        () => _i181.LoginCubit(gh<_i800.AuthRepository>()));
    gh.factory<_i523.CreateSaleOrderInfoCubit>(
        () => _i523.CreateSaleOrderInfoCubit(gh<_i907.CustomerRepository>()));
    return this;
  }
}
