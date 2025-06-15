import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final int? index;
  final Widget? leading;
  final Widget? title;
  final Widget? subtitle;
  final Widget? trailing;
  final Function(int)? onTap;

  const CustomListTile(
      {super.key,
      this.index,
      this.leading,
      this.title,
      this.subtitle,
      this.trailing,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    var items = <Widget>[];
    if (leading != null) {
      items.add(leading!);
    }
    var titlesubtitlelist = <Widget>[];
    if (title != null) {
      titlesubtitlelist.add(title!);
    }
    if (subtitle != null) {
      titlesubtitlelist.add(subtitle!);
    }
    items.add(
      Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: titlesubtitlelist,
        ),
      ),
    );
    if (trailing != null) {
      items.add(trailing!);
    }
    return Card(
      margin: const EdgeInsets.all(0),
      shape: const BeveledRectangleBorder(),
      color: Theme.of(context).colorScheme.secondaryContainer,
      child: InkWell(
       // onHover: (value) => onHover!(va),
        onTap: () {
          if (onTap != null) onTap!(index!);
        },
        splashFactory: InkRipple.splashFactory,
        child: Container(
          height: 60,
          padding: const EdgeInsets.fromLTRB(5, 3, 5, 3),
          child: Row(children: items),),
      ),
    );
  }
}
