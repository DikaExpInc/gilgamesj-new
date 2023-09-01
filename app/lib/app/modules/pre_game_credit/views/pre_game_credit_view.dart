import 'package:flutter/material.dart';

class PreGameCreditView extends StatefulWidget {
  @override
  _PreGameCreditViewState createState() => _PreGameCreditViewState();
}

class _PreGameCreditViewState extends State<PreGameCreditView> {
  final scrollController = ScrollController();
  late double mWidth;
  late double mHeight;

  @override
  void initState() {
    super.initState();
    _autoScroll();
  }

  void _autoScroll() {
    Future.delayed(Duration(milliseconds: 10), () {
      // if (scrollController.position.maxScrollExtent ==
      //     scrollController.offset) {
      //   scrollController.jumpTo(0);
      // } else {
      scrollController.animateTo(
        scrollController.offset + 1000,
        duration: Duration(seconds: 5),
        curve: Curves.linear,
      );
      // }
      // _autoScroll();
    });
  }

  @override
  Widget build(BuildContext context) {
    mWidth = MediaQuery.of(context).size.width;
    mHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: mWidth,
        height: mHeight,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          controller: scrollController,
          child: Column(
            children: [
              SizedBox(height: 20),
              for (int i = 1; i <= 30; i++)
                Container(
                  height: 100,
                  width: 200,
                  color: Colors.blue.shade200,
                  margin: EdgeInsets.symmetric(vertical: 10),
                  alignment: Alignment.center,
                  child: Text('Item $i'),
                ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
