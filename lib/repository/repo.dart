import 'package:flutter/material.dart';

import '../Database/db.dart';

abstract class Repo<T extends Object> {
  @protected
  final DB db;
  
  Repo(this.db);
  Future<int> add(T t);
  Future<int> delete(int id);
  Future<int> update(T t);
  Future<List<T>?> fetchAll();
  Future<T?> fetchById(int id);
}
