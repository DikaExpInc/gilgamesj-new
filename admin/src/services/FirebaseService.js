import { auth, db, storage } from "auth/FirebaseAuth";
import { useEffect } from "react";
import { useDispatch, useSelector } from "react-redux";
import { getAllNews } from "redux/actions";

const FirebaseService = {};

FirebaseService.signInEmailRequest = async (email, password) =>
  await auth
    .signInWithEmailAndPassword(email, password)
    .then((user) => user)
    .catch((err) => err);

FirebaseService.signOutRequest = async () =>
  await auth
    .signOut()
    .then((user) => user)
    .catch((err) => err);

// ========================================================
// User Firestore CRUD
// ========================================================

FirebaseService.addUser = async (data) => {
  return await db.collection("team_name").doc().set(data);
};

FirebaseService.getUser = async () => {
  return await db.collection("team_name").get();
};

FirebaseService.getUserDetail = async (id) => {
  return await db.collection("team_name").doc(id).get();
};

FirebaseService.updateUser = async (id, data) => {
  return db.collection("team_name").doc(id).set(data);
};

FirebaseService.deleteUser = async (id) => {
  return db.collection("team_name").doc(id).delete();
};

// ========================================================
// News Firestore CRUD
// ========================================================
FirebaseService.addNews = async (data) => {
  return await db.collection("news").doc().set(data);
};

FirebaseService.getNews = async () => {
  return await db.collection("news").get();
};

FirebaseService.getNewsDetail = async (id) => {
  return await db.collection("news").doc(id).get();
};

FirebaseService.updateNews = async (id, data) => {
  return db.collection("news").doc(id).set(data);
};

FirebaseService.deleteNews = async (id) => {
  return db.collection("news").doc(id).delete();
};

// ========================================================
// Social Media Firebase CRUD
// ========================================================

FirebaseService.addSocialMedia = async (data) => {
  return await db.collection("social_medias").doc().set(data);
};

FirebaseService.getSocialMedia = async () => {
  return await db.collection("social_medias").get();
};

FirebaseService.getSocialMediaDetail = async (id) => {
  return await db.collection("social_medias").doc(id).get();
};

FirebaseService.updateSocialMedia = async (id, data) => {
  return db.collection("social_medias").doc(id).set(data);
};

FirebaseService.deleteSocialMedia = async (id) => {
  return db.collection("social_medias").doc(id).delete();
};

// ========================================================
// Detail Comment Firebase CRUD
// ========================================================

FirebaseService.addDetailComment = async (sosmed_id, data) => {
  return await db
    .collection("social_medias")
    .doc(sosmed_id)
    .collection("detail_comments")
    .doc()
    .set(data);
};

FirebaseService.getDetailComment = async (sosmed_id) => {
  return await db
    .collection("social_medias")
    .doc(sosmed_id)
    .collection("detail_comments")
    .get();
};

FirebaseService.getDetailCommentDetail = async (sosmed_id, id) => {
  return await db
    .collection("social_medias")
    .doc(sosmed_id)
    .collection("detail_comments")
    .doc(id)
    .get();
};

FirebaseService.updateDetailComment = async (sosmed_id, id, data) => {
  return db
    .collection("social_medias")
    .doc(sosmed_id)
    .collection("detail_comments")
    .doc(id)
    .set(data);
};

FirebaseService.deleteDetailComment = async (sosmed_id, id) => {
  return db
    .collection("social_medias")
    .doc(sosmed_id)
    .collection("detail_comments")
    .doc(id)
    .delete();
};

// ========================================================
// Gallery Photo Firebase CRUD
// ========================================================

FirebaseService.addGalleryPhoto = async (data) => {
  return await db.collection("gallery_photos").doc().set(data);
};

FirebaseService.getGalleryPhoto = async () => {
  return await db.collection("gallery_photos").get();
};

FirebaseService.getGalleryPhotoDetail = async (id) => {
  return await db.collection("gallery_photos").doc(id).get();
};

FirebaseService.updateGalleryPhoto = async (id, data) => {
  return db.collection("gallery_photos").doc(id).set(data);
};

FirebaseService.deleteGalleryPhoto = async (id) => {
  return db.collection("gallery_photos").doc(id).delete();
};

// ========================================================
// Gallery Video Firebase CRUD
// ========================================================

FirebaseService.addGalleryVideo = async (data) => {
  return await db.collection("gallery_videos").doc().set(data);
};

FirebaseService.getGalleryVideo = async () => {
  return await db.collection("gallery_videos").get();
};

FirebaseService.getGalleryVideoDetail = async (id) => {
  return await db.collection("gallery_videos").doc(id).get();
};

FirebaseService.updateGalleryVideo = async (id, data) => {
  return db.collection("gallery_videos").doc(id).set(data);
};

FirebaseService.deleteGalleryVideo = async (id) => {
  return db.collection("gallery_videos").doc(id).delete();
};

// ========================================================
// Maps Firebase CRUD
// ========================================================

FirebaseService.addMaps = async (data) => {
  return await db.collection("maps").doc().set(data);
};

FirebaseService.getMaps = async () => {
  return await db.collection("maps").get();
};

FirebaseService.getMapsDetail = async (id) => {
  return await db.collection("maps").doc(id).get();
};

FirebaseService.updateMaps = async (id, data) => {
  return db.collection("maps").doc(id).set(data);
};

FirebaseService.deleteMaps = async (id) => {
  return db.collection("maps").doc(id).delete();
};

// ========================================================
// Chat Firebase CRUD
// ========================================================

FirebaseService.addChat = async (data) => {
  return await db.collection("chats").doc().set(data);
};

FirebaseService.getChat = async () => {
  return await db.collection("chats").get();
};

FirebaseService.getChatDetail = async (id) => {
  return await db.collection("chats").doc(id).get();
};

FirebaseService.updateChat = async (id, data) => {
  return db.collection("chats").doc(id).set(data);
};

FirebaseService.deleteChat = async (id) => {
  return db.collection("chats").doc(id).delete();
};

// ========================================================
// Detail Chat Firebase CRUD
// ========================================================

FirebaseService.addDetailChat = async (chat_id, data) => {
  return await db
    .collection("chats")
    .doc(chat_id)
    .collection("detail_chats")
    .doc()
    .set(data);
};

FirebaseService.getDetailChat = async (chat_id) => {
  return await db
    .collection("chats")
    .doc(chat_id)
    .collection("detail_chats")
    .get();
};

FirebaseService.getDetailChatDetail = async (chat_id, id) => {
  return await db
    .collection("chats")
    .doc(chat_id)
    .collection("detail_chats")
    .doc(id)
    .get();
};

FirebaseService.updateDetailChat = async (chat_id, id, data) => {
  return db
    .collection("chats")
    .doc(chat_id)
    .collection("detail_chats")
    .doc(id)
    .set(data);
};

FirebaseService.deleteDetailChat = async (chat_id, id) => {
  return db
    .collection("chats")
    .doc(chat_id)
    .collection("detail_chats")
    .doc(id)
    .delete();
};

// ========================================================
// Camera Firebase CRUD
// ========================================================

FirebaseService.addCamera = async (data) => {
  return await db.collection("cameras").doc().set(data);
};

FirebaseService.getCamera = async () => {
  return await db.collection("cameras").get();
};

FirebaseService.getCameraDetail = async (id) => {
  return await db.collection("cameras").doc(id).get();
};

FirebaseService.updateCamera = async (id, data) => {
  return db.collection("cameras").doc(id).set(data);
};

FirebaseService.deleteCamera = async (id) => {
  return db.collection("cameras").doc(id).delete();
};

// ========================================================
// Phone Firebase CRUD
// ========================================================

FirebaseService.addPhone = async (data) => {
  return await db.collection("phones").doc().set(data);
};

FirebaseService.getPhone = async () => {
  return await db.collection("phones").get();
};

FirebaseService.getPhoneDetail = async (id) => {
  return await db.collection("phones").doc(id).get();
};

FirebaseService.updatePhone = async (id, data) => {
  return db.collection("phones").doc(id).set(data);
};

FirebaseService.deletePhone = async (id) => {
  return db.collection("phones").doc(id).delete();
};

// ========================================================
// Contact Firebase CRUD
// ========================================================

FirebaseService.addContact = async (data) => {
  return await db.collection("contacts").doc().set(data);
};

FirebaseService.getContact = async () => {
  return await db.collection("contacts").get();
};

FirebaseService.getContactDetail = async (id) => {
  return await db.collection("contacts").doc(id).get();
};

FirebaseService.updateContact = async (id, data) => {
  return db.collection("contacts").doc(id).set(data);
};

FirebaseService.deleteContact = async (id) => {
  return db.collection("contacts").doc(id).delete();
};

// ========================================================
// Stage Firebase CRUD
// ========================================================

FirebaseService.addStage = async (data) => {
  return await db.collection("stages").doc().set(data);
};

FirebaseService.getStage = async () => {
  return await db.collection("stages").get();
};

FirebaseService.getStageDetail = async (id) => {
  return await db.collection("stages").doc(id).get();
};

FirebaseService.updateStage = async (id, data) => {
  return db.collection("stages").doc(id).set(data);
};

FirebaseService.deleteStage = async (id) => {
  return db.collection("stages").doc(id).delete();
};

// ========================================================
// Task Firebase CRUD
// ========================================================

FirebaseService.addTask = async (data) => {
  return await db.collection("tasks").doc().set(data);
};

FirebaseService.getTask = async () => {
  return await db.collection("tasks").get();
};

FirebaseService.getTaskDetail = async (id) => {
  return await db.collection("tasks").doc(id).get();
};

FirebaseService.updateTask = async (id, data) => {
  return db.collection("tasks").doc(id).set(data);
};

FirebaseService.deleteTask = async (id) => {
  return db.collection("tasks").doc(id).delete();
};

// ========================================================
// Setting Firebase CRUD
// ========================================================

FirebaseService.addSetting = async (data) => {
  return await db.collection("settings").doc().set(data);
};

FirebaseService.getSetting = async () => {
  return await db.collection("settings").get();
};

FirebaseService.getSettingDetail = async (id) => {
  return await db.collection("settings").doc(id).get();
};

FirebaseService.updateSetting = async (id, data) => {
  return db.collection("settings").doc(id).set(data);
};

FirebaseService.deleteSetting = async (id) => {
  return db.collection("settings").doc(id).delete();
};

// ========================================================
export default FirebaseService;
