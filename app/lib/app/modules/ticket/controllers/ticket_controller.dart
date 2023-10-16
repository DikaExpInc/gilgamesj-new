import 'package:app/app/data/player_model.dart';
import 'package:app/app/data/seat_model.dart';
import 'package:app/app/services/auth_service.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class TicketController extends GetxController {
  //TODO: Implement TicketController
  PlayerListModel? playerListModel;
  SeatModel? seatModel;
  final box = GetStorage();
  RxInt col = 0.obs;
  RxInt row = 0.obs;

  @override
  void onInit() {
    _startBlinking();
    loadPlayers();
    loadSeatRowCol();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  final RxBool isVisible = true.obs;

  void toggleVisibility() {
    isVisible.value = !isVisible.value;
  }

  void _startBlinking() {
    Future.delayed(Duration(milliseconds: 500), () {
      toggleVisibility(); // Mengubah visibilitas teks
      _startBlinking(); // Membuat loop kedip
    });
  }

  loadPlayers() async {
    update();
    playerListModel = await AuthApi().loadAllPlayerAPI();
    update();
    if (playerListModel?.statusCode == 200) {
      // Inisialisasi data pemain dan TextEditingController
      playerListModel?.items?.asMap().entries.map((entry) {
        final player = entry.value;
        box.write('seat_${entry.key}', player.seat);
        box.write('position_${entry.key}', player.seat);
        box.write('status_seat_${entry.key}', player.status_seat);
        box.write('stoel_${entry.key}', player.stoel);
        box.write('rij_${entry.key}', player.rij);
        print(player.rij);
      }).toList();
      print(playerListModel?.items?[0].rij);
      box.write('rij_tablet', playerListModel?.items?[0].rij);
      box.write('stoel_tablet', playerListModel?.items?[0].stoel);
      box.write('position_tablet', playerListModel?.items?[0].position);
      box.write('status_seat_tablet', playerListModel?.items?[0].status_seat);
    } else if (playerListModel!.statusCode == 204) {
      print("Empty");
    } else if (playerListModel!.statusCode == 404) {
      update();
    } else if (playerListModel!.statusCode == 401) {
    } else {
      print("someting wrong 400");
    }
  }

  loadSeatRowCol() async {
    update();
    seatModel = await AuthApi().loadSeatColRow();
    if (seatModel?.statusCode == 200) {
      col.value = seatModel!.col!;
      row.value = seatModel!.row!;
    } else if (seatModel!.statusCode == 204) {
      print("Empty");
    } else if (seatModel!.statusCode == 404) {
      update();
    } else if (seatModel!.statusCode == 401) {
    } else {
      print("someting wrong 400");
    }
  }
}
