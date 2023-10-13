import 'package:get/get.dart';

import '../modules/blank/bindings/blank_binding.dart';
import '../modules/blank/views/blank_view.dart';
import '../modules/bonus/bindings/bonus_binding.dart';
import '../modules/bonus/views/bonus_view.dart';
import '../modules/bonus_camera/bindings/bonus_camera_binding.dart';
import '../modules/bonus_camera/views/bonus_camera_view.dart';
import '../modules/bonus_home/bindings/bonus_home_binding.dart';
import '../modules/bonus_home/views/bonus_home_view.dart';
import '../modules/bring_tablet_back/bindings/bring_tablet_back_binding.dart';
import '../modules/bring_tablet_back/views/bring_tablet_back_view.dart';
import '../modules/browser/bindings/browser_binding.dart';
import '../modules/browser/views/browser_view.dart';
import '../modules/browser_search/bindings/browser_search_binding.dart';
import '../modules/browser_search/views/browser_search_view.dart';
import '../modules/camera/bindings/camera_binding.dart';
import '../modules/camera/views/camera_view.dart';
import '../modules/change_player/bindings/change_player_binding.dart';
import '../modules/change_player/views/change_player_view.dart';
import '../modules/change_seat/bindings/change_seat_binding.dart';
import '../modules/change_seat/views/change_seat_view.dart';
import '../modules/chat/bindings/chat_binding.dart';
import '../modules/chat/views/chat_view.dart';
import '../modules/chat_detail/bindings/chat_detail_binding.dart';
import '../modules/chat_detail/views/chat_detail_view.dart';
import '../modules/choice_role/bindings/choice_role_binding.dart';
import '../modules/choice_role/views/choice_role_view.dart';
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
import '../modules/give_tablet/bindings/give_tablet_binding.dart';
import '../modules/give_tablet/views/give_tablet_view.dart';
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
import '../modules/lightning/bindings/lightning_binding.dart';
import '../modules/lightning/views/lightning_view.dart';
import '../modules/lock_music/bindings/lock_music_binding.dart';
import '../modules/lock_music/views/lock_music_view.dart';
import '../modules/map/bindings/map_binding.dart';
import '../modules/map/views/map_view.dart';
import '../modules/mini_game_descibel_game/bindings/mini_game_descibel_game_binding.dart';
import '../modules/mini_game_descibel_game/views/mini_game_descibel_game_view.dart';
import '../modules/mini_game_music_game/bindings/mini_game_music_game_binding.dart';
import '../modules/mini_game_music_game/views/mini_game_music_game_view.dart';
import '../modules/mini_game_music_theater_game/bindings/mini_game_music_theater_game_binding.dart';
import '../modules/mini_game_music_theater_game/views/mini_game_music_theater_game_view.dart';
import '../modules/mini_game_shake_game/bindings/mini_game_shake_game_binding.dart';
import '../modules/mini_game_shake_game/views/mini_game_shake_game_view.dart';
import '../modules/movement_page/bindings/movement_page_binding.dart';
import '../modules/movement_page/views/movement_page_view.dart';
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
import '../modules/pre_game_guess/bindings/pre_game_guess_binding.dart';
import '../modules/pre_game_guess/views/pre_game_guess_view.dart';
import '../modules/pre_game_items/bindings/pre_game_items_binding.dart';
import '../modules/pre_game_items/views/pre_game_items_view.dart';
import '../modules/pre_game_items_ar/bindings/pre_game_items_ar_binding.dart';
import '../modules/pre_game_items_ar/views/pre_game_items_ar_view.dart';
import '../modules/pre_game_menu/bindings/pre_game_menu_binding.dart';
import '../modules/pre_game_menu/views/pre_game_menu_view.dart';
import '../modules/pre_game_photo/bindings/pre_game_photo_binding.dart';
import '../modules/pre_game_photo/views/pre_game_photo_view.dart';
import '../modules/pre_game_rune/bindings/pre_game_rune_binding.dart';
import '../modules/pre_game_rune/views/pre_game_rune_view.dart';
import '../modules/pre_game_spirit_realm/bindings/pre_game_spirit_realm_binding.dart';
import '../modules/pre_game_spirit_realm/views/pre_game_spirit_realm_view.dart';
import '../modules/pre_game_splash/bindings/pre_game_splash_binding.dart';
import '../modules/pre_game_splash/views/pre_game_splash_view.dart';
import '../modules/pre_game_start/bindings/pre_game_start_binding.dart';
import '../modules/pre_game_start/views/pre_game_start_view.dart';
import '../modules/pre_game_success/bindings/pre_game_success_binding.dart';
import '../modules/pre_game_success/views/pre_game_success_view.dart';
import '../modules/pre_game_talking_video/bindings/pre_game_talking_video_binding.dart';
import '../modules/pre_game_talking_video/views/pre_game_talking_video_view.dart';
import '../modules/pre_game_tutorial/bindings/pre_game_tutorial_binding.dart';
import '../modules/pre_game_tutorial/views/pre_game_tutorial_view.dart';
import '../modules/rules/bindings/rules_binding.dart';
import '../modules/rules/views/rules_view.dart';
import '../modules/scan_ar/bindings/scan_ar_binding.dart';
import '../modules/scan_ar/views/scan_ar_view.dart';
import '../modules/scan_qr/bindings/scan_qr_binding.dart';
import '../modules/scan_qr/views/scan_qr_view.dart';
import '../modules/social_media/bindings/social_media_binding.dart';
import '../modules/social_media/views/social_media_view.dart';
import '../modules/start/bindings/start_binding.dart';
import '../modules/start/views/start_view.dart';
import '../modules/tablet_holder/bindings/tablet_holder_binding.dart';
import '../modules/tablet_holder/views/tablet_holder_view.dart';
import '../modules/theater_game_call_humbaba_game/bindings/theater_game_call_humbaba_game_binding.dart';
import '../modules/theater_game_call_humbaba_game/views/theater_game_call_humbaba_game_view.dart';
import '../modules/theater_game_call_humbaba_game_done/bindings/theater_game_call_humbaba_game_done_binding.dart';
import '../modules/theater_game_call_humbaba_game_done/views/theater_game_call_humbaba_game_done_view.dart';
import '../modules/theater_game_chat_and_call_game/bindings/theater_game_chat_and_call_game_binding.dart';
import '../modules/theater_game_chat_and_call_game/views/theater_game_chat_and_call_game_view.dart';
import '../modules/theater_game_chat_and_call_game_done/bindings/theater_game_chat_and_call_game_done_binding.dart';
import '../modules/theater_game_chat_and_call_game_done/views/theater_game_chat_and_call_game_done_view.dart';
import '../modules/theater_game_chat_game/bindings/theater_game_chat_game_binding.dart';
import '../modules/theater_game_chat_game/views/theater_game_chat_game_view.dart';
import '../modules/theater_game_chat_game_done/bindings/theater_game_chat_game_done_binding.dart';
import '../modules/theater_game_chat_game_done/views/theater_game_chat_game_done_view.dart';
import '../modules/theater_game_choice_game/bindings/theater_game_choice_game_binding.dart';
import '../modules/theater_game_choice_game/views/theater_game_choice_game_view.dart';
import '../modules/theater_game_choice_game_done/bindings/theater_game_choice_game_done_binding.dart';
import '../modules/theater_game_choice_game_done/views/theater_game_choice_game_done_view.dart';
import '../modules/theater_game_choose_your_character/bindings/theater_game_choose_your_character_binding.dart';
import '../modules/theater_game_choose_your_character/views/theater_game_choose_your_character_view.dart';
import '../modules/theater_game_choose_your_character_done/bindings/theater_game_choose_your_character_done_binding.dart';
import '../modules/theater_game_choose_your_character_done/views/theater_game_choose_your_character_done_view.dart';
import '../modules/theater_game_contact_chat/bindings/theater_game_contact_chat_binding.dart';
import '../modules/theater_game_contact_chat/views/theater_game_contact_chat_view.dart';
import '../modules/theater_game_contact_chat_detail/bindings/theater_game_contact_chat_detail_binding.dart';
import '../modules/theater_game_contact_chat_detail/views/theater_game_contact_chat_detail_view.dart';
import '../modules/theater_game_humbaba/bindings/theater_game_humbaba_binding.dart';
import '../modules/theater_game_humbaba/views/theater_game_humbaba_view.dart';
import '../modules/theater_game_lightning_game/bindings/theater_game_lightning_game_binding.dart';
import '../modules/theater_game_lightning_game/views/theater_game_lightning_game_view.dart';
import '../modules/theater_game_lightning_game_custom/bindings/theater_game_lightning_game_custom_binding.dart';
import '../modules/theater_game_lightning_game_custom/views/theater_game_lightning_game_custom_view.dart';
import '../modules/theater_game_lightning_game_done/bindings/theater_game_lightning_game_done_binding.dart';
import '../modules/theater_game_lightning_game_done/views/thater_game_lightning_game_done_view.dart';
import '../modules/theater_game_rebus/bindings/theater_game_rebus_binding.dart';
import '../modules/theater_game_rebus/views/theater_game_rebus_view.dart';
import '../modules/theater_game_reviving/bindings/theater_game_reviving_binding.dart';
import '../modules/theater_game_reviving/views/theater_game_reviving_view.dart';
import '../modules/theater_game_shake_game/bindings/theater_game_shake_game_binding.dart';
import '../modules/theater_game_shake_game/views/theater_game_shake_game_view.dart';
import '../modules/theater_game_shake_game_done/bindings/theater_game_shake_game_done_binding.dart';
import '../modules/theater_game_shake_game_done/views/theater_game_shake_game_done_view.dart';
import '../modules/theater_game_show_humbaba/bindings/theater_game_show_humbaba_binding.dart';
import '../modules/theater_game_show_humbaba/views/theater_game_show_humbaba_view.dart';
import '../modules/theater_game_star_game/bindings/theater_game_star_game_binding.dart';
import '../modules/theater_game_star_game/views/theater_game_star_game_view.dart';
import '../modules/theater_game_star_game_done/bindings/theater_game_star_game_done_binding.dart';
import '../modules/theater_game_star_game_done/views/theater_game_star_game_done_view.dart';
import '../modules/theater_game_star_game_solving/bindings/theater_game_star_game_solving_binding.dart';
import '../modules/theater_game_star_game_solving/views/theater_game_star_game_solving_view.dart';
import '../modules/theater_game_star_timer_game/bindings/theater_game_star_timer_game_binding.dart';
import '../modules/theater_game_star_timer_game/views/theater_game_star_timer_game_view.dart';
import '../modules/theater_game_tablet_dies/bindings/theater_game_tablet_dies_binding.dart';
import '../modules/theater_game_tablet_dies/views/theater_game_tablet_dies_view.dart';
import '../modules/ticket/bindings/ticket_binding.dart';
import '../modules/ticket/views/ticket_view.dart';
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
      name: _Paths.PRE_GAME_AUDIO,
      page: () => PreGameAudioView(),
      binding: PreGameAudioBinding(),
    ),
    GetPage(
      name: _Paths.PRE_GAME_ITEMS_AR,
      page: () => PreGameItemsArView(),
      binding: PreGameItemsArBinding(),
    ),
    GetPage(
      name: _Paths.PRE_GAME_SUCCESS,
      page: () => PreGameSuccessView(),
      binding: PreGameSuccessBinding(),
    ),
    GetPage(
      name: _Paths.MINI_GAME_MUSIC_GAME,
      page: () => MiniGameMusicGameView(),
      binding: MiniGameMusicGameBinding(),
    ),
    GetPage(
      name: _Paths.MINI_GAME_DESCIBEL_GAME,
      page: () => MiniGameDescibelGameView(),
      binding: MiniGameDescibelGameBinding(),
    ),
    GetPage(
      name: _Paths.MINI_GAME_SHAKE_GAME,
      page: () => MiniGameShakeGameView(),
      binding: MiniGameShakeGameBinding(),
    ),
    GetPage(
      name: _Paths.MINI_GAME_MUSIC_THEATER_GAME,
      page: () => MiniGameMusicTheaterGameView(),
      binding: MiniGameMusicTheaterGameBinding(),
    ),
    GetPage(
      name: _Paths.THEATER_GAME_CHOICE_GAME,
      page: () => TheaterGameChoiceGameView(),
      binding: TheaterGameChoiceGameBinding(),
    ),
    GetPage(
      name: _Paths.THEATER_GAME_LIGHTNING_GAME,
      page: () => TheaterGameLightningGameView(),
      binding: TheaterGameLightningGameBinding(),
    ),
    GetPage(
      name: _Paths.THEATER_GAME_LIGHTNING_GAME_DONE,
      page: () => TheaterGameLightningGameDoneView(),
      binding: TheaterGameLightningGameDoneBinding(),
    ),
    GetPage(
      name: _Paths.THEATER_GAME_STAR_GAME,
      page: () => TheaterGameStarGameView(),
      binding: TheaterGameStarGameBinding(),
    ),
    GetPage(
      name: _Paths.THEATER_GAME_STAR_GAME_DONE,
      page: () => TheaterGameStarGameDoneView(),
      binding: TheaterGameStarGameDoneBinding(),
    ),
    GetPage(
      name: _Paths.THEATER_GAME_STAR_TIMER_GAME,
      page: () => TheaterGameStarTimerGameView(),
      binding: TheaterGameStarTimerGameBinding(),
    ),
    GetPage(
      name: _Paths.THEATER_GAME_CHOICE_GAME_DONE,
      page: () => TheaterGameChoiceGameDoneView(),
      binding: TheaterGameChoiceGameDoneBinding(),
    ),
    GetPage(
      name: _Paths.THEATER_GAME_CHAT_GAME,
      page: () => TheaterGameChatGameView(),
      binding: TheaterGameChatGameBinding(),
    ),
    GetPage(
      name: _Paths.THEATER_GAME_CHAT_GAME_DONE,
      page: () => TheaterGameChatGameDoneView(),
      binding: TheaterGameChatGameDoneBinding(),
    ),
    GetPage(
      name: _Paths.THEATER_GAME_SHAKE_GAME_DONE,
      page: () => TheaterGameShakeGameDoneView(),
      binding: TheaterGameShakeGameDoneBinding(),
    ),
    GetPage(
      name: _Paths.THEATER_GAME_SHAKE_GAME,
      page: () => TheaterGameShakeGameView(),
      binding: TheaterGameShakeGameBinding(),
    ),
    GetPage(
      name: _Paths.THEATER_GAME_STAR_GAME_SOLVING,
      page: () => TheaterGameStarGameSolvingView(),
      binding: TheaterGameStarGameSolvingBinding(),
    ),
    GetPage(
      name: _Paths.THEATER_GAME_CHAT_AND_CALL_GAME,
      page: () => TheaterGameChatAndCallGameView(),
      binding: TheaterGameChatAndCallGameBinding(),
    ),
    GetPage(
      name: _Paths.THEATER_GAME_CALL_HUMBABA_GAME,
      page: () => TheaterGameCallHumbabaGameView(),
      binding: TheaterGameCallHumbabaGameBinding(),
    ),
    GetPage(
      name: _Paths.THEATER_GAME_CALL_HUMBABA_GAME_DONE,
      page: () => TheaterGameCallHumbabaGameDoneView(),
      binding: TheaterGameCallHumbabaGameDoneBinding(),
    ),
    GetPage(
      name: _Paths.TICKET,
      page: () => TicketView(),
      binding: TicketBinding(),
    ),
    GetPage(
      name: _Paths.CHANGE_SEAT,
      page: () => ChangeSeatView(),
      binding: ChangeSeatBinding(),
    ),
    GetPage(
      name: _Paths.CHOICE_ROLE,
      page: () => ChoiceRoleView(),
      binding: ChoiceRoleBinding(),
    ),
    GetPage(
      name: _Paths.TABLET_HOLDER,
      page: () => TabletHolderView(),
      binding: TabletHolderBinding(),
    ),
    GetPage(
      name: _Paths.MOVEMENT_PAGE,
      page: () => MovementPageView(),
      binding: MovementPageBinding(),
    ),
    GetPage(
      name: _Paths.GIVE_TABLET,
      page: () => GiveTabletView(),
      binding: GiveTabletBinding(),
    ),
    GetPage(
      name: _Paths.THEATER_GAME_LIGHTNING_GAME_CUSTOM,
      page: () => TheaterGameLightningGameCustomView(),
      binding: TheaterGameLightningGameCustomBinding(),
    ),
    GetPage(
      name: _Paths.THEATER_GAME_SHOW_HUMBABA,
      page: () => TheaterGameShowHumbabaView(),
      binding: TheaterGameShowHumbabaBinding(),
    ),
    GetPage(
      name: _Paths.THEATER_GAME_CHOOSE_YOUR_CHARACTER,
      page: () => TheaterGameChooseYourCharacterView(),
      binding: TheaterGameChooseYourCharacterBinding(),
    ),
    GetPage(
      name: _Paths.THEATER_GAME_TABLET_DIES,
      page: () => TheaterGameTabletDiesView(),
      binding: TheaterGameTabletDiesBinding(),
    ),
    GetPage(
      name: _Paths.THEATER_GAME_REVIVING,
      page: () => TheaterGameRevivingView(),
      binding: TheaterGameRevivingBinding(),
    ),
    GetPage(
      name: _Paths.BRING_TABLET_BACK,
      page: () => BringTabletBackView(),
      binding: BringTabletBackBinding(),
    ),
    GetPage(
      name: _Paths.THEATER_GAME_CHAT_AND_CALL_GAME_DONE,
      page: () => TheaterGameChatAndCallGameDoneView(),
      binding: TheaterGameChatAndCallGameDoneBinding(),
    ),
    GetPage(
      name: _Paths.THEATER_GAME_CHOOSE_YOUR_CHARACTER_DONE,
      page: () => TheaterGameChooseYourCharacterDoneView(),
      binding: TheaterGameChooseYourCharacterDoneBinding(),
    ),
    GetPage(
      name: _Paths.SCAN_AR,
      page: () => const ScanArView(),
      binding: ScanArBinding(),
    ),
    GetPage(
      name: _Paths.LIGHTNING,
      page: () => LightningView(),
      binding: LightningBinding(),
    ),
    GetPage(
      name: _Paths.THEATER_GAME_REBUS,
      page: () => TheaterGameRebusView(),
      binding: TheaterGameRebusBinding(),
    ),
    GetPage(
      name: _Paths.THEATER_GAME_HUMBABA,
      page: () => TheaterGameHumbabaView(),
      binding: TheaterGameHumbabaBinding(),
    ),
    GetPage(
      name: _Paths.THEATER_GAME_CONTACT_CHAT,
      page: () => TheaterGameContactChatView(),
      binding: TheaterGameContactChatBinding(),
    ),
    GetPage(
      name: _Paths.THEATER_GAME_CONTACT_CHAT_DETAIL,
      page: () => TheaterGameContactChatDetailView(),
      binding: TheaterGameContactChatDetailBinding(),
    ),
    GetPage(
      name: _Paths.SCAN_QR,
      page: () => ScanQrView(),
      binding: ScanQrBinding(),
    ),
    GetPage(
      name: _Paths.PRE_GAME_PHOTO,
      page: () => const PreGamePhotoView(),
      binding: PreGamePhotoBinding(),
    ),
    GetPage(
      name: _Paths.PRE_GAME_GUESS,
      page: () => const PreGameGuessView(),
      binding: PreGameGuessBinding(),
    ),
  ];
}
