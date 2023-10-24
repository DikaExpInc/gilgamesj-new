import 'package:app/app/data/player_model.dart';
import 'package:app/app/routes/app_pages.dart';
import 'package:app/app/services/auth_service.dart';
import 'package:app/app/widgets/dialog/player_dialog.dart';
import 'package:app/app/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ViewPlayerController extends GetxController {
  //TODO: Implement ViewPlayerController

  final box = GetStorage();
  RxBool isLoading = false.obs;
  PlayerListModel? playerListModel;
  var playerNameControllers = <TextEditingController>[].obs;
  RxBool isButtonVisible = false.obs;

  Future<void> onNext() async {
    final changes = playerListModel?.items?.asMap().entries.map((entry) {
      final player = entry.value;
      final playerName = playerNameControllers[entry.key].text;
      return {
        "player_id": player.sId,
        "playerName": playerName,
        "seat": player.seat,
      };
    }).toList();

    if (changes != null && changes.isNotEmpty) {
      await AuthApi().changeNamePlayers(changes);
    }

    box.write('totalPlayer', playerListModel?.items?.length.toString());
    playerListModel?.items?.asMap().entries.map((entry) {
      final player = entry.value;
      final playerName = playerNameControllers[entry.key].text;
      box.write('played_name_${entry.key}', playerName);
      box.write('seat_id_${entry.key}', player.seatId);
      box.write('seat_${entry.key}', player.seat);
    }).toList();
    box.write('played_number', 0);
    box.write('mode', "item");

    Get.toNamed(Routes.PRE_GAME_SPIRIT_REALM);
  }

  @override
  void onInit() {
    super.onInit();
    loadPlayers();
  }

  loadPlayers() async {
    update();
    showLoading();
    playerListModel = await AuthApi().loadAllPlayerAPI();
    update();
    stopLoading();
    if (playerListModel?.statusCode == 200) {
      // Inisialisasi data pemain dan TextEditingController
      for (var i = 0; i < playerListModel!.items!.length; i++) {
        playerNameControllers.add(TextEditingController());
        // playerNameControllers[i].text = "${box.read('teamName')} ${i + 1}";
      }
    } else if (playerListModel!.statusCode == 204) {
      print("Empty");
    } else if (playerListModel!.statusCode == 404) {
      update();
    } else if (playerListModel!.statusCode == 401) {
    } else {
      print("someting wrong 400");
    }
  }

  void showPlayerDialog() {
    Get.dialog(
      WillPopScope(
        onWillPop: () async {
          // Cegah dialog ditutup dengan tombol "back"
          return false;
        },
        child: PlayerDialog(),
      ),
      barrierDismissible: false,
    );
  }
}
