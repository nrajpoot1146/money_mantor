import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../Database/db.dart';

abstract class Repo<T extends Object> {
  @protected
  final DB db;
  
  @protected
  final Logger logger;
  
  Repo(this.db, this.logger);
  Future<int> add(T t);
  Future<int> delete(int id);
  Future<int> update(T t);
  Future<List<T>?> fetchAll();
  Future<T?> fetchById(int id);
}
