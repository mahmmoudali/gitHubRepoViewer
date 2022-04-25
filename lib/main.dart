import 'package:flutter/material.dart';
import 'package:github_repo/providers/main_provider.dart';
import 'package:github_repo/ui/home/home_screen.dart';
import 'package:github_repo/utils/colors.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MainProvider()),
      ],
      child: MaterialApp(
        title: 'Github Repo Viewer',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primaryColor: MColors.primary),
        home: HomePage(),
      ),
    );
  }
}
