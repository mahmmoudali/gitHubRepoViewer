import 'dart:convert';
import 'dart:developer';

import 'package:github_repo/models/repo_model.dart';
import 'package:github_repo/providers/main_provider.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class RepoService {
  Future<List<RepoDataBean>> getRepoWithSelectedDate(
      MainProvider mainProvider) async {
    // mainProvider.setLoading(true);
    final String date =
        DateFormat('yyyy-MM-dd').format(mainProvider.selectedDate).toString();
    final String url =
        '''https://api.github.com/search/repositories?q=created:>$date&sort=stars&order=desc&per_page=${mainProvider.numberOfResults}''';
    List<RepoDataBean> repos = [];
    http.Request request = new http.Request("GET", Uri.parse(url));
    try {
      await request.send().then((response) async {
        List<RepoDataBean>? result = RepoResponse.fromJson(
                jsonDecode(utf8.decode(await response.stream.toBytes())))
            .items;

        if (response.statusCode == 200 /* && result!*/) repos = result!;
        // mainProvider.setLoading(false);
      });
    } catch (e) {
      log("Error during getting repos $e");
    }
    return repos;
  }
}
