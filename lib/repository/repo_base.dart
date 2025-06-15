import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:money_mantor/models/model_base.dart';

import '../Database/db.dart';

abstract class RepoBase<T extends ModelBase> {
  @protected
  final DB db;
  
  @protected
  final Logger logger;
  final List<T> items = List.empty();
  
  RepoBase(this.db, this.logger);

  Future<int> add(T t)
  {
    items.add(t);
    return Future.value(t.id);
  }
  
  Future<int> delete(int id)
  {
    var index = find(id);
    if(index == -1)
    {
      return Future.value(-1);
    }
    items.removeAt(index);
    return Future.value(index);
  }

  Future<int> update(T t)
  {
    var index = find(t.id!);
    if(index == -1)
    {
      return Future.value(index);
    }
    items[index] = t;
    return Future.value(index);
  }

  Future<List<T>?> fetchAll()
  {
    return Future.value(items);
  }

  Future<T?> fetchById(int id)
  {
    return Future.value(items[find(id)]);
  }

  int find(int id)
  {
    for(int i = 0; i<items.length; i++)
    {
      if(items[i].id == id)
      {
        return i;
      }
    }
    return -1;
  }
}
