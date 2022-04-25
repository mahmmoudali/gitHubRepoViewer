import 'package:flutter/material.dart';
import 'package:github_repo/models/repo_model.dart';
import 'package:github_repo/utils/styles.dart';

class RepoItem extends StatelessWidget {
  final RepoDataBean repo;
  const RepoItem(this.repo);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        // color: MColors.primary,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(repo.name ?? "", style: MStyles.titleStyle),
          SizedBox(height: 5),
          Text(repo.description ?? "",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: MStyles.additionalInfoStyle),
          SizedBox(height: 5),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Icon(Icons.star_border, size: 20, color: Colors.grey),
              SizedBox(width: 2),
              Text(repo.stargazersCount.toString(),
                  style: MStyles.additionalInfoStyle),
              SizedBox(width: 20),
              Icon(Icons.tag, size: 20, color: Colors.grey),
              SizedBox(width: 2),
              Text(repo.language ?? "Not mentioned",
                  style: MStyles.additionalInfoStyle)
            ],
          ),
        ],
      ),
    );
  }
}
