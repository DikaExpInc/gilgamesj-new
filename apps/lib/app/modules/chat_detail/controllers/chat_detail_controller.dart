import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:gilgamesj/app/widgets/toast/custom_toast.dart';
import 'package:uuid/uuid.dart';

class ChatDetailController extends GetxController {
  RxBool isBottomSheetVisible = false.obs;
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final Map<String, dynamic> chatData = Get.arguments;
  RxBool isLoading = false.obs;

  @override
  void onInit() async {
    super.onInit();
    await createFirstChatData();
  }

  createFirstChatData() async {
    isLoading.value = true;

    try {
      String uid = auth.currentUser!.uid;
      CollectionReference<Map<String, dynamic>> userChatCollection =
          await firestore
              .collection("team_name")
              .doc(uid)
              .collection("chats")
              .doc(chatData['chatId'])
              .collection("detail_chats");

      QuerySnapshot<Map<String, dynamic>> snapshot =
          await userChatCollection.get();

      if (snapshot.size == 0) {
        CollectionReference<Map<String, dynamic>> chatCollection =
            await firestore
                .collection("chats")
                .doc(chatData['chatId'])
                .collection('detail_chats');

        QuerySnapshot<Map<String, dynamic>> chatSnapshot =
            await chatCollection.orderBy('order').get();
        Map<String, dynamic> chatDatas = chatSnapshot.docs.first.data();
        var uuidChat = Uuid().v1();

        await userChatCollection.doc(uuidChat).set({
          "order": chatDatas['order'],
          "sender": chatDatas['sender'],
          "status": chatDatas['status'],
          "title": chatDatas['title'],
          "chat_family_id": chatDatas['chat_family_id'],
          "chat_sibling_id": chatDatas['chat_sibling_id'],
          "created_at": DateTime.now().toIso8601String(),
        });

        // save data sender
        List<Map<String, dynamic>> senderChats = chatSnapshot.docs
            .where((doc) => doc.data()['status'] == 'sender')
            .map((doc) => {
                  'id': doc.id,
                  ...doc.data(),
                })
            .toList();

        for (var doc in chatSnapshot.docs) {
          Map<String, dynamic> chatData = doc.data();
          String status = chatData['status'];

          print(chatData['status']);

          if (status == "receiver") {
            // Cari chat yang memiliki order id berbeda namun sesuai dengan chat dengan status "sender"
            for (var senderChat in senderChats) {
              if (chatData['chat_family_id'] == senderChat['id']) {
                var uuidChat = Uuid().v1();
                await userChatCollection.doc(uuidChat).set({
                  "order": chatData['order'],
                  "sender": chatData['sender'],
                  "status": chatData['status'],
                  "title": chatData['title'],
                  "chat_family_id": chatData['chat_family_id'],
                  "chat_sibling_id": chatData['chat_sibling_id'],
                  "created_at": DateTime.now().toIso8601String(),
                });
              }
            }
          }
        }
      } else {}

      isLoading.value = false;
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      CustomToast.errorToast('Error', 'error : ${e.toString()}');
    }
  }

  void toggleBottomSheetVisibility() {
    isBottomSheetVisible.value = !isBottomSheetVisible.value;
  }

  Future<void> answerChat(String chatId) async {
    isLoading.value = true;

    try {
      String uid = auth.currentUser!.uid;
      CollectionReference<Map<String, dynamic>> userChatCollection =
          await firestore
              .collection("team_name")
              .doc(uid)
              .collection("chats")
              .doc(chatData['chatId'])
              .collection("detail_chats");

      CollectionReference<Map<String, dynamic>> chatCollection = await firestore
          .collection("chats")
          .doc(chatData['chatId'])
          .collection('detail_chats');

      DocumentSnapshot<Map<String, dynamic>> chatChooseSnapshot =
          await chatCollection.doc(chatId).get();

      Map<String, dynamic> chatDatas = chatChooseSnapshot.data()!;
      var uuidChat = Uuid().v1();

      // mengirimkan chat yang dipilih

      await userChatCollection.doc(uuidChat).set({
        "order": chatDatas['order'],
        "sender": chatDatas['sender'],
        "status": chatDatas['status'],
        "title": chatDatas['title'],
        "chat_family_id": chatDatas['chat_family_id'],
        "chat_sibling_id": chatDatas['chat_sibling_id'],
        "created_at": DateTime.now().toIso8601String(),
      });

      Get.back();

      // mengirimkan chat balasan

      DocumentReference<Map<String, dynamic>> chatDoc = firestore
          .collection("chats")
          .doc(chatData['chatId'])
          .collection('detail_chats')
          .doc(chatId.toString());

      DocumentSnapshot<Map<String, dynamic>> chatDocSnapshot =
          await chatDoc.get();
      int chatOrder = chatDocSnapshot.data()?['order'];

      QuerySnapshot<Map<String, dynamic>> chatSnapshot = await chatCollection
          .orderBy('order')
          .where("order", isGreaterThan: chatOrder)
          .get();

      List<Map<String, dynamic>> receiverChats = chatSnapshot.docs
          .where((doc) => doc.data()['status'] == 'receiver')
          .map((doc) => {
                'id': doc.id,
                ...doc.data(),
              })
          .toList();

      // Cari chat yang memiliki order id berbeda namun sesuai dengan chat dengan status "sender"
      for (var receiverChat in receiverChats) {
        if (chatDatas['order'] + 1 == receiverChat['order']) {
          var uuidChat = Uuid().v1();
          await userChatCollection.doc(uuidChat).set({
            "order": receiverChat['order'],
            "sender": receiverChat['sender'],
            "status": receiverChat['status'],
            "title": receiverChat['title'],
            "chat_family_id": receiverChat['chat_family_id'],
            "chat_sibling_id": receiverChat['chat_sibling_id'],
            "created_at": DateTime.now().toIso8601String(),
          });
        }
      }

      isLoading.value = false;
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      CustomToast.errorToast('Error', 'error : ${e.toString()}');
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getAnswer() async* {
    String uid = auth.currentUser!.uid;

    CollectionReference<Map<String, dynamic>> chatCollection = firestore
        .collection("team_name")
        .doc(uid)
        .collection("chats")
        .doc(chatData['chatId'])
        .collection("detail_chats");

    QuerySnapshot<Map<String, dynamic>> snapshot =
        await chatCollection.orderBy('order', descending: true).limit(1).get();

    int lastOrderId = snapshot.docs.first['order'];

    yield* firestore
        .collection("chats")
        .doc(chatData['chatId'])
        .collection('detail_chats')
        .where('order', isEqualTo: lastOrderId + 1)
        .where('status', isEqualTo: "sender")
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllDetailChat() async* {
    String uid = auth.currentUser!.uid;

    yield* firestore
        .collection("team_name")
        .doc(uid)
        .collection("chats")
        .doc(chatData['chatId'])
        .collection('detail_chats')
        .snapshots();
  }
}
