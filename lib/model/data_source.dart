// import 'package:nafal/model/matches_model.dart';
import 'package:nafal/providers/base_network.dart';

class MatchesDetailDataSource {
  static MatchesDetailDataSource instance = MatchesDetailDataSource();
  Future<Map<String, dynamic>> loadDetail(String id) {
    return BaseNetwork.get("matches/${id}");
  }

  Future<List<dynamic>> loadListData() {
    return BaseNetwork.getList("matches");
  }
}
