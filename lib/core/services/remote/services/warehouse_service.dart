import 'package:flutter_interview_application/core/services/remote/remote_database_service.dart';
import 'package:injectable/injectable.dart';

import '../../../models/warehouse.dart';

@LazySingleton()
class WarehouseService {
  /// 2️⃣ Fetch Warehouses
  Future<List<Warehouse>> getWarehouses() async {
    var result =
        await RemoteDatabaseService.execute("SELECT * FROM warehouses");

    return result.rows.map((row) => Warehouse.fromJson(row.assoc())).toList();
  }
}
