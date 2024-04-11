typedef SerializeToJson<T> = Map<String, dynamic> Function(T obj);
typedef DeserializeFromJson<T> = T Function(Map<String, dynamic> json);
typedef DeserializeFromJsonList<T> = T Function(List<dynamic> list);