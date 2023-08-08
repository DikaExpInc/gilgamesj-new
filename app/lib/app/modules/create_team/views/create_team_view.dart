import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/create_team_controller.dart';

class CreateTeamView extends GetView<CreateTeamController> {
  const CreateTeamView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CreateTeamView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'CreateTeamView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
