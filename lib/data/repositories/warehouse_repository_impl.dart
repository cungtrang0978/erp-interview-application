import 'package:injectable/injectable.dart';

import '../../core/models/warehouse.dart';
import '../../domain/repositories/warehouse_repository.dart';
import '../datasources/warehouse_datasource.dart';

@LazySingleton(as: WarehouseRepository)
class WarehouseRepositoryImpl implements WarehouseRepository {
  final WarehouseDataSource warehouseDataSource;

  WarehouseRepositoryImpl(this.warehouseDataSource);

  @override
  Future<List<Warehouse>> fetchAllWarehouses() {
    return warehouseDataSource.getWarehouses();
  }
}
