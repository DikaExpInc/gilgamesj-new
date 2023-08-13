import 'package:get/get.dart';

import '../modules/blank/bindings/blank_binding.dart';
import '../modules/blank/views/blank_view.dart';
import '../modules/bonus/bindings/bonus_binding.dart';
import '../modules/bonus/views/bonus_view.dart';
import '../modules/bonus_camera/bindings/bonus_camera_binding.dart';
import '../modules/bonus_camera/views/bonus_camera_view.dart';
import '../modules/bonus_home/bindings/bonus_home_binding.dart';
import '../modules/bonus_home/views/bonus_home_view.dart';
import '../modules/browser/bindings/browser_binding.dart';
import '../modules/browser/views/browser_view.dart';
import '../modules/browser_search/bindings/browser_search_binding.dart';
import '../modules/browser_search/views/browser_search_view.dart';
import '../modules/camera/bindings/camera_binding.dart';
import '../modules/camera/views/camera_view.dart';
import '../modules/chat/bindings/chat_binding.dart';
import '../modules/chat/views/chat_view.dart';
import '../modules/chat_detail/bindings/chat_detail_binding.dart';
import '../modules/chat_detail/views/chat_detail_view.dart';
import '../modules/clap/bindings/clap_binding.dart';
import '../modules/clap/views/clap_view.dart';
import '../modules/comment/bindings/comment_binding.dart';
import '../modules/comment/views/comment_view.dart';
import '../modules/create_player/bindings/create_player_binding.dart';
import '../modules/create_player/views/create_player_view.dart';
import '../modules/create_team/bindings/create_team_binding.dart';
import '../modules/create_team/views/create_team_view.dart';
import '../modules/gallery/bindings/gallery_binding.dart';
import '../modules/gallery/views/gallery_view.dart';
import '../modules/gallery_image_detail/bindings/gallery_image_detail_binding.dart';
import '../modules/gallery_image_detail/views/gallery_image_detail_view.dart';
import '../modules/gallery_video_detail/bindings/gallery_video_detail_binding.dart';
import '../modules/gallery_video_detail/views/gallery_video_detail_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/introduction/bindings/introduction_binding.dart';
import '../modules/introduction/views/introduction_view.dart';
import '../modules/lock_music/bindings/lock_music_binding.dart';
import '../modules/lock_music/views/lock_music_view.dart';
import '../modules/map/bindings/map_binding.dart';
import '../modules/map/views/map_view.dart';
import '../modules/news_detail/bindings/news_detail_binding.dart';
import '../modules/news_detail/views/news_detail_view.dart';
import '../modules/objective_detail/bindings/objective_detail_binding.dart';
import '../modules/objective_detail/views/objective_detail_view.dart';
import '../modules/performance/bindings/performance_binding.dart';
import '../modules/performance/views/performance_view.dart';
import '../modules/phone/bindings/phone_binding.dart';
import '../modules/phone/views/phone_view.dart';
import '../modules/phone_call/bindings/phone_call_binding.dart';
import '../modules/phone_call/views/phone_call_view.dart';
import '../modules/rules/bindings/rules_binding.dart';
import '../modules/rules/views/rules_view.dart';
import '../modules/social_media/bindings/social_media_binding.dart';
import '../modules/social_media/views/social_media_view.dart';
import '../modules/start/bindings/start_binding.dart';
import '../modules/start/views/start_view.dart';
import '../modules/view_player/bindings/view_player_binding.dart';
import '../modules/view_player/views/view_player_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.CREATE_TEAM;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.BLANK,
      page: () => BlankView(),
      binding: BlankBinding(),
    ),
    GetPage(
      name: _Paths.BONUS,
      page: () => BonusView(),
      binding: BonusBinding(),
    ),
    GetPage(
      name: _Paths.BONUS_CAMERA,
      page: () => BonusCameraView(),
      binding: BonusCameraBinding(),
    ),
    GetPage(
      name: _Paths.BONUS_HOME,
      page: () => BonusHomeView(),
      binding: BonusHomeBinding(),
    ),
    GetPage(
      name: _Paths.BROWSER,
      page: () => BrowserView(),
      binding: BrowserBinding(),
    ),
    GetPage(
      name: _Paths.BROWSER_SEARCH,
      page: () => BrowserSearchView(),
      binding: BrowserSearchBinding(),
    ),
    GetPage(
      name: _Paths.CAMERA,
      page: () => CameraView(),
      binding: CameraBinding(),
    ),
    GetPage(
      name: _Paths.CHAT,
      page: () => ChatView(),
      binding: ChatBinding(),
    ),
    GetPage(
      name: _Paths.CHAT_DETAIL,
      page: () => ChatDetailView(),
      binding: ChatDetailBinding(),
    ),
    GetPage(
      name: _Paths.CLAP,
      page: () => ClapView(),
      binding: ClapBinding(),
    ),
    GetPage(
      name: _Paths.COMMENT,
      page: () => CommentView(),
      binding: CommentBinding(),
    ),
    GetPage(
      name: _Paths.CREATE_TEAM,
      page: () => CreateTeamView(),
      binding: CreateTeamBinding(),
    ),
    GetPage(
      name: _Paths.GALLERY,
      page: () => GalleryView(),
      binding: GalleryBinding(),
    ),
    GetPage(
      name: _Paths.GALLERY_IMAGE_DETAIL,
      page: () => GalleryImageDetailView(),
      binding: GalleryImageDetailBinding(),
    ),
    GetPage(
      name: _Paths.GALLERY_VIDEO_DETAIL,
      page: () => GalleryVideoDetailView(),
      binding: GalleryVideoDetailBinding(),
    ),
    GetPage(
      name: _Paths.INTRODUCTION,
      page: () => IntroductionView(),
      binding: IntroductionBinding(),
    ),
    GetPage(
      name: _Paths.LOCK_MUSIC,
      page: () => LockMusicView(),
      binding: LockMusicBinding(),
    ),
    GetPage(
      name: _Paths.MAP,
      page: () => MapView(),
      binding: MapBinding(),
    ),
    GetPage(
      name: _Paths.NEWS_DETAIL,
      page: () => NewsDetailView(),
      binding: NewsDetailBinding(),
    ),
    GetPage(
      name: _Paths.OBJECTIVE_DETAIL,
      page: () => ObjectiveDetailView(),
      binding: ObjectiveDetailBinding(),
    ),
    GetPage(
      name: _Paths.PERFORMANCE,
      page: () => PerformanceView(),
      binding: PerformanceBinding(),
    ),
    GetPage(
      name: _Paths.PHONE,
      page: () => PhoneView(),
      binding: PhoneBinding(),
    ),
    GetPage(
      name: _Paths.PHONE_CALL,
      page: () => PhoneCallView(),
      binding: PhoneCallBinding(),
    ),
    GetPage(
      name: _Paths.RULES,
      page: () => RulesView(),
      binding: RulesBinding(),
    ),
    GetPage(
      name: _Paths.SOCIAL_MEDIA,
      page: () => SocialMediaView(),
      binding: SocialMediaBinding(),
    ),
    GetPage(
      name: _Paths.START,
      page: () => StartView(),
      binding: StartBinding(),
    ),
    GetPage(
      name: _Paths.CREATE_PLAYER,
      page: () => CreatePlayerView(),
      binding: CreatePlayerBinding(),
    ),
    GetPage(
      name: _Paths.VIEW_PLAYER,
      page: () => ViewPlayerView(),
      binding: ViewPlayerBinding(),
    ),
  ];
}
