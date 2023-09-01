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
import '../modules/change_player/bindings/change_player_binding.dart';
import '../modules/change_player/views/change_player_view.dart';
import '../modules/chat/bindings/chat_binding.dart';
import '../modules/chat/views/chat_view.dart';
import '../modules/chat_detail/bindings/chat_detail_binding.dart';
import '../modules/chat_detail/views/chat_detail_view.dart';
import '../modules/clap/bindings/clap_binding.dart';
import '../modules/clap/views/clap_view.dart';
import '../modules/comment/bindings/comment_binding.dart';
import '../modules/comment/views/comment_view.dart';
import '../modules/connection/bindings/connection_binding.dart';
import '../modules/connection/views/connection_view.dart';
import '../modules/create_team/bindings/create_team_binding.dart';
import '../modules/create_team/views/create_team_view.dart';
import '../modules/gallery/bindings/gallery_binding.dart';
import '../modules/gallery/views/gallery_view.dart';
import '../modules/gallery_image_detail/bindings/gallery_image_detail_binding.dart';
import '../modules/gallery_image_detail/views/gallery_image_detail_view.dart';
import '../modules/gallery_video_detail/bindings/gallery_video_detail_binding.dart';
import '../modules/gallery_video_detail/views/gallery_video_detail_view.dart';
import '../modules/go_theater/bindings/go_theater_binding.dart';
import '../modules/go_theater/views/go_theater_view.dart';
import '../modules/group/bindings/group_binding.dart';
import '../modules/group/views/group_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/intro/bindings/intro_binding.dart';
import '../modules/intro/views/intro_view.dart';
import '../modules/introduction/bindings/introduction_binding.dart';
import '../modules/introduction/views/introduction_view.dart';
import '../modules/light/bindings/light_binding.dart';
import '../modules/light/views/light_view.dart';
import '../modules/lock_music/bindings/lock_music_binding.dart';
import '../modules/lock_music/views/lock_music_view.dart';
import '../modules/map/bindings/map_binding.dart';
import '../modules/map/views/map_view.dart';
import '../modules/news_detail/bindings/news_detail_binding.dart';
import '../modules/news_detail/views/news_detail_view.dart';
import '../modules/notification/bindings/notification_binding.dart';
import '../modules/notification/views/notification_view.dart';
import '../modules/objective_detail/bindings/objective_detail_binding.dart';
import '../modules/objective_detail/views/objective_detail_view.dart';
import '../modules/performance/bindings/performance_binding.dart';
import '../modules/performance/views/performance_view.dart';
import '../modules/phone/bindings/phone_binding.dart';
import '../modules/phone/views/phone_view.dart';
import '../modules/phone_call/bindings/phone_call_binding.dart';
import '../modules/phone_call/views/phone_call_view.dart';
import '../modules/pre_game_audio/bindings/pre_game_audio_binding.dart';
import '../modules/pre_game_audio/views/pre_game_audio_view.dart';
import '../modules/pre_game_credit/bindings/pre_game_credit_binding.dart';
import '../modules/pre_game_credit/views/pre_game_credit_view.dart';
import '../modules/pre_game_descibel_game/bindings/pre_game_descibel_game_binding.dart';
import '../modules/pre_game_descibel_game/views/pre_game_descibel_game_view.dart';
import '../modules/pre_game_items/bindings/pre_game_items_binding.dart';
import '../modules/pre_game_items/views/pre_game_items_view.dart';
import '../modules/pre_game_menu/bindings/pre_game_menu_binding.dart';
import '../modules/pre_game_menu/views/pre_game_menu_view.dart';
import '../modules/pre_game_music_game/bindings/pre_game_music_game_binding.dart';
import '../modules/pre_game_music_game/views/pre_game_music_game_view.dart';
import '../modules/pre_game_rune/bindings/pre_game_rune_binding.dart';
import '../modules/pre_game_rune/views/pre_game_rune_view.dart';
import '../modules/pre_game_shake_game/bindings/pre_game_shake_game_binding.dart';
import '../modules/pre_game_shake_game/views/pre_game_shake_game_view.dart';
import '../modules/pre_game_spirit_realm/bindings/pre_game_spirit_realm_binding.dart';
import '../modules/pre_game_spirit_realm/views/pre_game_spirit_realm_view.dart';
import '../modules/pre_game_splash/bindings/pre_game_splash_binding.dart';
import '../modules/pre_game_splash/views/pre_game_splash_view.dart';
import '../modules/pre_game_start/bindings/pre_game_start_binding.dart';
import '../modules/pre_game_start/views/pre_game_start_view.dart';
import '../modules/pre_game_talking_video/bindings/pre_game_talking_video_binding.dart';
import '../modules/pre_game_talking_video/views/pre_game_talking_video_view.dart';
import '../modules/pre_game_tutorial/bindings/pre_game_tutorial_binding.dart';
import '../modules/pre_game_tutorial/views/pre_game_tutorial_view.dart';
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
      name: _Paths.VIEW_PLAYER,
      page: () => ViewPlayerView(),
      binding: ViewPlayerBinding(),
    ),
    GetPage(
      name: _Paths.INTRO,
      page: () => IntroView(),
      binding: IntroBinding(),
    ),
    GetPage(
      name: _Paths.PRE_GAME_ITEMS,
      page: () => PreGameItemsView(),
      binding: PreGameItemsBinding(),
    ),
    GetPage(
      name: _Paths.PRE_GAME_TALKING_VIDEO,
      page: () => PreGameTalkingVideoView(),
      binding: PreGameTalkingVideoBinding(),
    ),
    GetPage(
      name: _Paths.GO_THEATER,
      page: () => GoTheaterView(),
      binding: GoTheaterBinding(),
    ),
    GetPage(
      name: _Paths.CONNECTION,
      page: () => const ConnectionView(),
      binding: ConnectionBinding(),
    ),
    GetPage(
      name: _Paths.LIGHT,
      page: () => const LightView(),
      binding: LightBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATION,
      page: () => const NotificationView(),
      binding: NotificationBinding(),
    ),
    GetPage(
      name: _Paths.GROUP,
      page: () => GroupView(),
      binding: GroupBinding(),
    ),
    GetPage(
      name: _Paths.CHANGE_PLAYER,
      page: () => ChangePlayerView(),
      binding: ChangePlayerBinding(),
    ),
    GetPage(
      name: _Paths.PRE_GAME_RUNE,
      page: () => PreGameRuneView(),
      binding: PreGameRuneBinding(),
    ),
    GetPage(
      name: _Paths.PRE_GAME_SPLASH,
      page: () => PreGameSplashView(),
      binding: PreGameSplashBinding(),
    ),
    GetPage(
      name: _Paths.PRE_GAME_START,
      page: () => PreGameStartView(),
      binding: PreGameStartBinding(),
    ),
    GetPage(
      name: _Paths.PRE_GAME_MENU,
      page: () => PreGameMenuView(),
      binding: PreGameMenuBinding(),
    ),
    GetPage(
      name: _Paths.PRE_GAME_TUTORIAL,
      page: () => PreGameTutorialView(),
      binding: PreGameTutorialBinding(),
    ),
    GetPage(
      name: _Paths.PRE_GAME_CREDIT,
      page: () => PreGameCreditView(),
      binding: PreGameCreditBinding(),
    ),
    GetPage(
      name: _Paths.PRE_GAME_SPIRIT_REALM,
      page: () => PreGameSpiritRealmView(),
      binding: PreGameSpiritRealmBinding(),
    ),
    GetPage(
      name: _Paths.PRE_GAME_MUSIC_GAME,
      page: () => const PreGameMusicGameView(),
      binding: PreGameMusicGameBinding(),
    ),
    GetPage(
      name: _Paths.PRE_GAME_DESCIBEL_GAME,
      page: () => const PreGameDescibelGameView(),
      binding: PreGameDescibelGameBinding(),
    ),
    GetPage(
      name: _Paths.PRE_GAME_SHAKE_GAME,
      page: () => const PreGameShakeGameView(),
      binding: PreGameShakeGameBinding(),
    ),
    GetPage(
      name: _Paths.PRE_GAME_AUDIO,
      page: () => PreGameAudioView(),
      binding: PreGameAudioBinding(),
    ),
  ];
}
