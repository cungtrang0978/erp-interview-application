import 'package:flutter_interview_application/mysql/remote_database_service.dart';
import 'package:injectable/injectable.dart';

import '../../core/models/warehouse.dart';

@LazySingleton()
class WarehouseService {
  /// 2️⃣ Fetch Warehouses
  Future<List<Warehouse>> getWarehouses() async {
    if (RemoteDatabaseService.conn == null) throw Exception("Database connection not initialized!");

    var result = await RemoteDatabaseService.conn!.execute("SELECT * FROM warehouses");

    return result.rows.map((row) => Warehouse.fromJson(row.assoc())).toList();
  }
}
