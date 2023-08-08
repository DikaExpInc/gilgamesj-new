import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/browser_search_controller.dart';

class BrowserSearchView extends GetView<BrowserSearchController> {
  const BrowserSearchView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BrowserSearchView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'BrowserSearchView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
