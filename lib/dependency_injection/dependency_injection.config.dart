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
import '../features/auth/data/datasources/auth_datasource.dart' as _i670;
import '../features/auth/data/repositories/auth_repository_impl.dart' as _i570;
import '../features/auth/domain/repositories/auth_repository.dart' as _i869;
import '../features/auth/domain/usecase/login_with_email_pw.dart' as _i463;
import '../features/auth/presentation/controller/choose_account_cubit.dart'
    as _i289;
import '../features/auth/presentation/controller/login_cubit.dart' as _i472;
import '../features/auth/presentation/controller/register_cubit.dart' as _i303;
import '../features/customer/data/datasources/customer_datasource.dart'
    as _i524;
import '../features/customer/data/repositories/customer_repository_impl.dart'
    as _i1003;
import '../features/customer/domain/repositories/customer_repository.dart'
    as _i591;
import '../features/inventory/data/datasources/inventory_datasource.dart'
    as _i14;
import '../features/inventory/data/repositories/inventory_repository_impl.dart'
    as _i1045;
import '../features/inventory/domain/repositories/inventory_repository.dart'
    as _i617;
import '../features/product/data/datasources/product_datasource.dart' as _i646;
import '../features/product/data/repositories/product_repository_impl.dart'
    as _i334;
import '../features/product/domain/repositories/product_repository.dart'
    as _i198;
import '../features/purchase_order/data/datasources/purchase_order_datasource.dart'
    as _i732;
import '../features/purchase_order/data/repositories/purchase_order_repository_impl.dart'
    as _i197;
import '../features/purchase_order/domain/repositories/purchase_order_repository.dart'
    as _i388;
import '../features/purchase_order/presentation/controllers/purchase_order_cubit.dart'
    as _i615;
import '../features/root/root_cubit.dart' as _i1050;
import '../features/sales_order/data/datasources/sale_order_datasource.dart'
    as _i524;
import '../features/sales_order/data/repositories/sale_order_repository_impl.dart'
    as _i146;
import '../features/sales_order/domain/repositories/sale_order_repository.dart'
    as _i205;
import '../features/sales_order/presentation/controllers/create_sale_order_cubit.dart'
    as _i122;
import '../features/sales_order/presentation/controllers/create_sale_order_info_cubit.dart'
    as _i458;
import '../features/sales_order/presentation/controllers/sale_order_detail_cubit.dart'
    as _i559;
import '../features/sales_order/presentation/controllers/sale_order_list_cubit.dart'
    as _i510;
import '../features/warehouse/data/datasources/warehouse_datasource.dart'
    as _i1038;
import '../features/warehouse/data/repositories/warehouse_repository_impl.dart'
    as _i72;
import '../features/warehouse/domain/repositories/warehouse_repository.dart'
    as _i457;

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
    gh.lazySingleton<_i460.LocalDatabaseService>(
        () => _i460.LocalDatabaseService());
    gh.lazySingleton<_i961.RemoteDatabaseService>(
        () => _i961.RemoteDatabaseService());
    gh.lazySingleton<_i244.PurchaseOrderService>(
        () => _i244.PurchaseOrderService());
    gh.lazySingleton<_i822.CustomerService>(() => _i822.CustomerService());
    gh.lazySingleton<_i116.WarehouseService>(() => _i116.WarehouseService());
    gh.lazySingleton<_i104.ProductService>(() => _i104.ProductService());
    gh.lazySingleton<_i416.AuthService>(() => _i416.AuthService());
    gh.lazySingleton<_i547.SaleOrderService>(() => _i547.SaleOrderService());
    gh.lazySingleton<_i540.InventoryService>(() => _i540.InventoryService());
    gh.lazySingleton<_i646.ProductDataSource>(
        () => _i646.ProductDataSource(gh<_i104.ProductService>()));
    gh.lazySingleton<_i670.AuthDataSource>(() => _i670.AuthDataSource(
          gh<_i416.AuthService>(),
          gh<_i460.LocalDatabaseService>(),
        ));
    gh.lazySingleton<_i524.CustomerDataSource>(
        () => _i524.CustomerDataSource(gh<_i822.CustomerService>()));
    gh.lazySingleton<_i1038.WarehouseDataSource>(
        () => _i1038.WarehouseDataSource(gh<_i116.WarehouseService>()));
    gh.lazySingleton<_i457.WarehouseRepository>(
        () => _i72.WarehouseRepositoryImpl(gh<_i1038.WarehouseDataSource>()));
    gh.lazySingleton<_i591.CustomerRepository>(
        () => _i1003.CustomerRepositoryImpl(gh<_i524.CustomerDataSource>()));
    gh.lazySingleton<_i869.AuthRepository>(
        () => _i570.AuthRepositoryImpl(gh<_i670.AuthDataSource>()));
    gh.lazySingleton<_i524.SaleOrderDataSource>(() => _i524.SaleOrderDataSource(
          gh<_i547.SaleOrderService>(),
          gh<_i540.InventoryService>(),
        ));
    gh.lazySingleton<_i732.PurchaseOrderDataSource>(
        () => _i732.PurchaseOrderDataSource(gh<_i244.PurchaseOrderService>()));
    gh.lazySingleton<_i14.InventoryDataSource>(
        () => _i14.InventoryDataSource(gh<_i540.InventoryService>()));
    gh.lazySingleton<_i198.ProductRepository>(
        () => _i334.ProductRepositoryImpl(gh<_i646.ProductDataSource>()));
    gh.lazySingleton<_i205.SaleOrderRepository>(
        () => _i146.SaleOrderRepositoryImpl(gh<_i524.SaleOrderDataSource>()));
    gh.factory<_i289.ChooseAccountCubit>(
        () => _i289.ChooseAccountCubit(gh<_i869.AuthRepository>()));
    gh.factory<_i303.RegisterCubit>(
        () => _i303.RegisterCubit(gh<_i869.AuthRepository>()));
    gh.factory<_i1050.RootCubit>(
        () => _i1050.RootCubit(gh<_i869.AuthRepository>()));
    gh.factory<_i458.CreateSaleOrderInfoCubit>(
        () => _i458.CreateSaleOrderInfoCubit(gh<_i591.CustomerRepository>()));
    gh.factory<_i463.LoginWithEmailPassword>(
        () => _i463.LoginWithEmailPassword(gh<_i869.AuthRepository>()));
    gh.lazySingleton<_i617.InventoryRepository>(
        () => _i1045.InventoryRepositoryImpl(gh<_i14.InventoryDataSource>()));
    gh.factory<_i122.CreateSaleOrderCubit>(
        () => _i122.CreateSaleOrderCubit(gh<_i205.SaleOrderRepository>()));
    gh.factory<_i510.SaleOrderListCubit>(
        () => _i510.SaleOrderListCubit(gh<_i205.SaleOrderRepository>()));
    gh.factory<_i559.SaleOrderDetailCubit>(
        () => _i559.SaleOrderDetailCubit(gh<_i205.SaleOrderRepository>()));
    gh.lazySingleton<_i388.PurchaseOrderRepository>(() =>
        _i197.PurchaseOrderRepositoryImpl(gh<_i732.PurchaseOrderDataSource>()));
    gh.factory<_i472.LoginCubit>(
        () => _i472.LoginCubit(gh<_i463.LoginWithEmailPassword>()));
    gh.factory<_i615.PurchaseOrderCubit>(
        () => _i615.PurchaseOrderCubit(gh<_i388.PurchaseOrderRepository>()));
    return this;
  }
}
