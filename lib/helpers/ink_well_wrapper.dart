import 'package:flutter/material.dart';

class InkWellWrapper extends StatelessWidget {
  final Widget child;
  final Function onTap;
  final BorderRadius borderRadius;

  const InkWellWrapper({Key key, this.child, this.onTap, this.borderRadius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        borderRadius: borderRadius,
        child: child,
        onTap: onTap,
      ),
    );
  }
}
