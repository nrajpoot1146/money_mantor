abstract class Repo<T extends Object> {
  //static Repo? _instance;
  Future<int> add(T t);
  Future<int> delete(int id);
  Future<int> update(T t);
  Future<List<T>?> fetchAll();
  Future<T?> fetchById(int id);

  // static T get<T extends Repo>() {
  //   T _instance = ((T as dynamic).new() as T);
  //   return _instance;
  // }
}
