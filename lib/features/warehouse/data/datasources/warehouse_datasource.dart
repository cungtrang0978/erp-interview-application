import 'package:injectable/injectable.dart';

import '../../../../core/models/warehouse.dart';
import '../../../../core/services/remote/services/warehouse_service.dart';

@LazySingleton()
class WarehouseDataSource {
  final WarehouseService _warehouseService;

  WarehouseDataSource(this._warehouseService);

  Future<List<Warehouse>> getWarehouses() async {
    return await _warehouseService.getWarehouses();
  }
}
