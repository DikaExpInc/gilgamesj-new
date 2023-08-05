import 'package:get/get.dart';
import 'package:gilgamesj/app/modules/blank/bindings/blank_binding.dart';
import 'package:gilgamesj/app/modules/blank/views/blank_view.dart';
import 'package:gilgamesj/app/modules/bonus/bindings/bonus_binding.dart';
import 'package:gilgamesj/app/modules/bonus/views/bonus_view.dart';
import 'package:gilgamesj/app/modules/bonus_camera/bindings/bonus_camera_binding.dart';
import 'package:gilgamesj/app/modules/bonus_camera/views/bonus_camera_view.dart';
import 'package:gilgamesj/app/modules/bonus_home/bindings/bonus_home_binding.dart';
import 'package:gilgamesj/app/modules/bonus_home/views/bonus_home_view.dart';
import 'package:gilgamesj/app/modules/browser/bindings/browser_binding.dart';
import 'package:gilgamesj/app/modules/browser/views/browser_view.dart';
import 'package:gilgamesj/app/modules/browser_search/bindings/browser_search_binding.dart';
import 'package:gilgamesj/app/modules/browser_search/views/browser_search_view.dart';
import 'package:gilgamesj/app/modules/camera/bindings/camera_binding.dart';
import 'package:gilgamesj/app/modules/camera/views/camera_view.dart';
import 'package:gilgamesj/app/modules/chat/bindings/chat_binding.dart';
import 'package:gilgamesj/app/modules/chat/views/chat_view.dart';
import 'package:gilgamesj/app/modules/chat_detail/bindings/chat_detail_binding.dart';
import 'package:gilgamesj/app/modules/chat_detail/views/chat_detail_view.dart';
import 'package:gilgamesj/app/modules/clap/bindings/clap_binding.dart';
import 'package:gilgamesj/app/modules/clap/views/clap_view.dart';
import 'package:gilgamesj/app/modules/comment/bindings/comment_binding.dart';
import 'package:gilgamesj/app/modules/comment/views/comment_view.dart';
import 'package:gilgamesj/app/modules/create_team/bindings/create_team_binding.dart';
import 'package:gilgamesj/app/modules/create_team/views/create_team_view.dart';
import 'package:gilgamesj/app/modules/gallery_image_detail/bindings/gallery_image_detail_binding.dart';
import 'package:gilgamesj/app/modules/gallery_image_detail/views/gallery_image_detail_view.dart';
import 'package:gilgamesj/app/modules/gallery_video_detail/bindings/gallery_video_detail_binding.dart';
import 'package:gilgamesj/app/modules/gallery_video_detail/views/gallery_video_detail_view.dart';
import 'package:gilgamesj/app/modules/gallery/bindings/gallery_binding.dart';
import 'package:gilgamesj/app/modules/gallery/views/gallery_view.dart';
import 'package:gilgamesj/app/modules/home/bindings/home_binding.dart';
import 'package:gilgamesj/app/modules/home/views/home_view.dart';
import 'package:gilgamesj/app/modules/introduction/views/introduction_view.dart';
import 'package:gilgamesj/app/modules/lock_music/bindings/lock_music_binding.dart';
import 'package:gilgamesj/app/modules/lock_music/views/lock_music_view.dart';
import 'package:gilgamesj/app/modules/lock_screen/bindings/lock_screen_binding.dart';
import 'package:gilgamesj/app/modules/lock_screen/views/lock_screen_view.dart';
import 'package:gilgamesj/app/modules/map/bindings/maps_binding.dart';
import 'package:gilgamesj/app/modules/map/views/maps_view.dart';
import 'package:gilgamesj/app/modules/news_detail/bindings/news_detail_binding.dart';
import 'package:gilgamesj/app/modules/news_detail/views/news_detail_view.dart';
import 'package:gilgamesj/app/modules/objective_detail/bindings/objective_detail_binding.dart';
import 'package:gilgamesj/app/modules/objective_detail/views/objective_detail_view.dart';
import 'package:gilgamesj/app/modules/performance/bindings/performance_binding.dart';
import 'package:gilgamesj/app/modules/performance/views/performance_view.dart';
import 'package:gilgamesj/app/modules/phone/bindings/phone_binding.dart';
import 'package:gilgamesj/app/modules/phone/views/phone_view.dart';
import 'package:gilgamesj/app/modules/phone_call/bindings/phone_call_binding.dart';
import 'package:gilgamesj/app/modules/phone_call/views/phone_call_view.dart';
import 'package:gilgamesj/app/modules/rules/bindings/rules_binding.dart';
import 'package:gilgamesj/app/modules/rules/views/rules_view.dart';
import 'package:gilgamesj/app/modules/social_media/bindings/social_media_binding.dart';
import 'package:gilgamesj/app/modules/social_media/views/social_media_view.dart';
import 'package:gilgamesj/app/modules/start/bindings/start_binding.dart';
import 'package:gilgamesj/app/modules/start/views/start_view.dart';
part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.INTRODUCTION,
      page: () => IntroductionView(),
      binding: StartBinding(),
    ),
    GetPage(
      name: _Paths.RULES,
      page: () => RulesView(),
      binding: RulesBinding(),
    ),
    GetPage(
      name: _Paths.START,
      page: () => StartView(),
      binding: StartBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.OBJECTIVE_DETAIL,
      page: () => ObjectiveDetailView(),
      binding: ObjectiveDetailBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.CREATE_TEAM,
      page: () => CreateTeamView(),
      binding: CreateTeamBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.LOCK_SCREEN,
      page: () => LockScreenView(),
      binding: LockScreenBinding(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: _Paths.LOCK_MUSIC,
      page: () => LockMusicView(),
      binding: LockMusicBinding(),
      transition: Transition.downToUp,
    ),

    // Menu
    GetPage(
      name: _Paths.SOCIAL_MEDIA,
      page: () => SocialMediaView(),
      binding: SocialMediaBinding(),
      transition: Transition.zoom,
    ),
    GetPage(
      name: _Paths.COMMENT_SOCIAL_MEDIA,
      page: () => CommentView(),
      binding: CommentBinding(),
      transition: Transition.zoom,
    ),
    GetPage(
      name: _Paths.CHAT,
      page: () => ChatView(),
      binding: ChatBinding(),
      transition: Transition.zoom,
    ),
    GetPage(
      name: _Paths.CHAT_DETAIL,
      page: () => ChatDetailView(),
      binding: ChatDetailBinding(),
      transition: Transition.leftToRight,
    ),
    GetPage(
      name: _Paths.CAMERA,
      page: () => CameraView(),
      binding: CameraBinding(),
      transition: Transition.zoom,
    ),
    GetPage(
      name: _Paths.GALLERY,
      page: () => GalleryView(),
      binding: GalleryBinding(),
      transition: Transition.zoom,
    ),
    GetPage(
      name: _Paths.GALLERY_IMAGE_DETAIL,
      page: () => GalleryImageDetailView(),
      binding: GalleryImageDetailBinding(),
      transition: Transition.zoom,
    ),
    GetPage(
      name: _Paths.GALLERY_VIDEO_DETAIL,
      page: () => GalleryVideoDetailView(),
      binding: GalleryVideoDetailBinding(),
      transition: Transition.zoom,
    ),
    GetPage(
      name: _Paths.PHONE,
      page: () => PhoneView(),
      binding: PhoneBinding(),
      transition: Transition.zoom,
    ),
    GetPage(
      name: _Paths.PHONE_CALL,
      page: () => PhoneCallView(),
      binding: PhoneCallBinding(),
      transition: Transition.zoom,
    ),
    GetPage(
      name: _Paths.BROWSER,
      page: () => BrowserView(),
      binding: BrowserBinding(),
      transition: Transition.zoom,
    ),
    GetPage(
      name: _Paths.BROWSER_SEARCH,
      page: () => BrowserSearchView(),
      binding: BrowserSearchBinding(),
      transition: Transition.zoom,
    ),
    GetPage(
      name: _Paths.NEWS_DETAIL,
      page: () => NewsDetailView(),
      binding: NewsDetailBinding(),
      transition: Transition.zoom,
    ),
    GetPage(
      name: _Paths.MAP,
      page: () => MapView(),
      binding: MapBinding(),
      transition: Transition.zoom,
    ),
    GetPage(
      name: _Paths.BLANK_SCREEN,
      page: () => BlankView(),
      binding: BlankBinding(),
      transition: Transition.zoom,
    ),
    GetPage(
      name: _Paths.CLAP_SCREEN,
      page: () => ClapView(),
      binding: ClapBinding(),
      transition: Transition.zoom,
    ),
    GetPage(
      name: _Paths.PERFORMANCE_SCREEN,
      page: () => PerformanceView(),
      binding: PerformanceBinding(),
      transition: Transition.zoom,
    ),
    GetPage(
      name: _Paths.BONUS_SCREEN,
      page: () => BonusView(),
      binding: BonusBinding(),
      transition: Transition.zoom,
    ),
    GetPage(
      name: _Paths.BONUS_HOME_SCREEN,
      page: () => BonusHomeView(),
      binding: BonusHomeBinding(),
      transition: Transition.zoom,
    ),
    GetPage(
      name: _Paths.BONUS_CAMERA_SCREEN,
      page: () => BonusCameraView(),
      binding: BonusCameraBinding(),
      transition: Transition.zoom,
    ),
  ];
}
