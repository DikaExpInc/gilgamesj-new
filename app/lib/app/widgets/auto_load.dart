import 'package:flutter/material.dart';

class AutoLoad extends StatefulWidget {
  final Function? onInit;
  final Widget? child;
  const AutoLoad({@required this.onInit, @required this.child});
  @override
  // ignore: library_private_types_in_public_api
  _AutoLoadState createState() => _AutoLoadState();
}

class _AutoLoadState extends State<AutoLoad> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      print("WidgetsBinding");

      if (widget.onInit != null) {
        widget.onInit!();
      }
    });
  }

  void runFunction() {
    if (widget.onInit != null) {
      widget.onInit!();
    }
    // super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: widget.child!,
    );
  }
}
