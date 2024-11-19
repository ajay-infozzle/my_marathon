class AppAssets {
  static const AppAssets _assets = AppAssets._();

  const AppAssets._();

  factory AppAssets() => _assets;

  static IconAssets icon = IconAssets();
  static Images images = Images();
  static LottieUrl lottie = LottieUrl();
}

class IconAssets {

  static const IconAssets _icon = IconAssets._();

  const IconAssets._();

  factory IconAssets() => _icon;

  String get _icons => 'assets/icons';

  //logo
  String get logo => '$_icons/logo.svg';

  //mainNavBar
  String get background => '$_icons/splash_background.svg';

  String get lessons => '$_icons/lessons.svg';

  String get home => '$_icons/home.svg';
  String get marathonLogo => '$_icons/marathon_logo.svg';
  String get splashMarathonLogo => '$_icons/splash_marathon_logo.svg';
  String get marathonTextLogo=> '$_icons/marathon_text.svg';
  String get splashIcon=> '$_icons/splash_icon.svg';

  String get document => '$_icons/document.svg';
  String get documentt => '$_icons/documentt.svg';

  String get payment => '$_icons/payment1.svg';

  String get support => '$_icons/support.svg';
  String get supportt => '$_icons/supportt.svg';
  String get homee => '$_icons/homee.svg';
  String get profile => '$_icons/profile.svg';
  String get profileDeleteIcon => '$_icons/profile_delete.svg';
  String get warningIcon => '$_icons/warningIcon.svg';

  String get health => '$_icons/refer.svg';
  String get sideDrop => '$_icons/bottom_drop_down.svg';
  String get bottomDrop => '$_icons/side_drop_down.svg';

}

class Images {
  static const Images _images = Images._();

  const Images._();

  factory Images() => _images;

  String get _pngPath => 'assets/images';

  //Log in
  String get mobileHome => '$_pngPath/mobile_home.png';

  String get loginWhite => '$_pngPath/login_white.png';

  String get logoMarathon => '$_pngPath/marathon_logo.png';
  String get building => '$_pngPath/building.png';
  String get avatar => '$_pngPath/avatar.png';
  String get image1 => '$_pngPath/image1.png';
  String get image2 => '$_pngPath/image2.png';
  String get image3 => '$_pngPath/image3.png';
  String get image4 => '$_pngPath/image4.png';
  String get referImage => '$_pngPath/refer_image.png';
  String get referImage2 => '$_pngPath/refer_image2.png';
  String get splashM => '$_pngPath/splash_marathon.png';
  String get splashMNew => '$_pngPath/marathon-logo_new.png';
  String get splashLogo => '$_pngPath/splash_logo.png';
  String get splashLogoNew => '$_pngPath/splash_logo_new.png';
  String get splashLogoNew1 => '$_pngPath/splash_logo_new1.png';
  String get marathonTextLogo => '$_pngPath/marathon_text.png';
  String get splashGrp => '$_pngPath/splash_grp.png';
  String get price => '$_pngPath/price.png';
  String get like => '$_pngPath/like.png';
  String get whatsAppIcon => '$_pngPath/whatsApp_icon.png';


// String get chatUser3 => "$_pngPath/chat_user3.png";
// String get chatUser4 => "$_pngPath/chat_user4.png";
}

class AppFonts {
  ///Fonts
  static const String fnGilroyBlack = 'GilroyBlack';
  static const String fnGilroyLight = 'GilroyLight';
  static const String fnproximanovaLight = 'proximanovaLight';
  static const String fnproximanovaThin = 'proximanovaThin';
  static const String fnproximanovaRegular = 'proximanovaRegular';
  static const String fnproximanovaMedium = 'proximanovaMedium';
  static const String fnproximanovaBold = 'proximanovaBold';
  static const String fnproximanovaBlack = 'proximanovaBlack';
}

class LottieUrl {

  static const LottieUrl _lottieUrl = LottieUrl._();

  const LottieUrl._();

  factory LottieUrl() => _lottieUrl;

  String get _json => 'assets/lottie';

  //home
  String get noData => '$_json/no-data.json';

  String get loadingBattle => '$_json/loading_battle.json';

  String get notification => '$_json/notification.json';

}
