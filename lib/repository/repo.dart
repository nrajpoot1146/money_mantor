abstract class Repo<T extends Object> {
  Future<int> add(T t);
  Future<int> delete(int id);
  Future<int> update(T t);
  Future<List<T>?> fetchAll();
}
