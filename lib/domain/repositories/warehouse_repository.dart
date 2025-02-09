import 'package:flutter_interview_application/core/models/warehouse.dart';

abstract class WarehouseRepository {
  Future<List<Warehouse>> fetchAllWarehouses();
}
