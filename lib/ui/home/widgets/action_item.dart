import 'package:flutter/material.dart';

class ActionItem extends StatelessWidget {
  final IconData? icon;
  final Function? onPressed;
  const ActionItem({@required this.icon, @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPressed!(),
      child: Container(
          margin: EdgeInsets.only(right: 10),
          child: Icon(icon, color: Colors.white)),
    );
  }
}
