import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:github_repo/providers/main_provider.dart';
import 'package:github_repo/service/repo.dart';
import 'package:github_repo/ui/home/widgets/action_item.dart';
import 'package:github_repo/ui/home/widgets/floating_button.dart';
import 'package:github_repo/ui/home/widgets/repo_item.dart';
import 'package:github_repo/utils/colors.dart';
import 'package:github_repo/utils/styles.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final RepoService repoService = RepoService();
  late MainProvider mainProvider;

  @override
  void initState() {
    mainProvider = Provider.of(context, listen: false);
    loadData();
    super.initState();
  }

  void loadData() async {
    await repoService.getRepoWithSelectedDate(mainProvider).then((repos) {
      mainProvider.setRepos(repos);
      if (repos.isNotEmpty) mainProvider.setLoading(false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final MainProvider mainProvider = Provider.of<MainProvider>(context);
    return Scaffold(
        backgroundColor: Color(0xFF010409),
        appBar: AppBar(title: Text("Github Repo Viewer"), actions: [
          GestureDetector(
              child: ActionItem(
                  icon: Icons.info,
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: MColors.titleColor,
                        content:
                            Text("Use floating button to see action ^_^")));
                  }))
        ]),
        floatingActionButton: FloatingButton(),
        body: Stack(
          children: [
            Visibility(
                visible: mainProvider.loading,
                child: Center(
                    child: SpinKitChasingDots(color: MColors.titleColor))),
            Visibility(
              visible: !mainProvider.loading,
              child: mainProvider.repos.length > 0
                  ? ListView.separated(
                      itemCount: mainProvider.repos.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        if (mainProvider.languages.isNotEmpty) {
                          if ((mainProvider.languages.contains(
                              mainProvider.repos[index].language ?? "wwwwww")))
                            return RepoItem(mainProvider.repos[index]);
                          else
                            return Container();
                        } else
                          return RepoItem(mainProvider.repos[index]);
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        if (mainProvider.languages.isNotEmpty) {
                          if ((mainProvider.languages.contains(
                              mainProvider.repos[index].language ?? "wwwwww")))
                            return Divider(color: Colors.grey);
                          else
                            return Container();
                        } else
                          return Divider(color: Colors.grey);
                      })
                  : Center(
                      child: Text(
                        "Sorry no repositories available in this filter!",
                        style: MStyles.additionalInfoStyle,
                      ),
                    ),
            ),
          ],
        ));
  }
}
