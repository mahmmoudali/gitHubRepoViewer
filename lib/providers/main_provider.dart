import 'package:flutter/material.dart';
import 'package:github_repo/models/repo_model.dart';

class MainProvider with ChangeNotifier {
  bool loading = true;

  void setLoading(bool value) {
    loading = value;
    notifyListeners();
  }

  List<RepoDataBean> repos = [];

  void setRepos(List<RepoDataBean> data) {
    repos = data;
    loading = false;
    notifyListeners();
  }

  DateTime selectedDate = DateTime.now().subtract(Duration(days: 1));

  void setSelectedDate(DateTime date) {
    selectedDate = date;
    notifyListeners();
  }

  String numberOfResults = "50";

  void setNumberOfResults(String number) {
    numberOfResults = number;
    notifyListeners();
  }

  List<String> languageList = [];
  String languages = "";

  void setLanguages(String language, List<String> list) {
    languageList = list;
    this.languages = "";
    if (this.languages.isNotEmpty)
      this.languages = "${this.languages},$language";
    else
      this.languages = language;
  }
}
