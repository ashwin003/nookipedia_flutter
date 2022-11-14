import '../types/museum/fossil.dart';

abstract class FossilService {
  Future<List<Fossil>> fetch({int? thumbSize});

  Future<Fossil> get({required String name, int? thumbSize});

  Future<List<FossilGroup>> fetchGroups({
    bool? includeFossils,
    int? thumbSize,
  });

  Future<FossilGroup> getGroup({
    required String name,
    bool? includeFossils,
    int? thumbSize,
  });
}
