abstract class AppIcons {
  static const String heart = 'assets/images/svg/heart.svg';
  static const String heartFilled = 'assets/images/svg/heart_filled.svg';
  static const String home = 'assets/images/svg/home.svg';
  static const String homeFilled = 'assets/images/svg/home_filled.svg';
  static const String category = 'assets/images/svg/category.svg';
  static const String categoryFilled = 'assets/images/svg/category_filled.svg';
  static const String user = 'assets/images/svg/user.svg';
  static const String userFilled = 'assets/images/svg/user_filled.svg';
  static const String notification = 'assets/images/svg/notification.svg';
  static const String notificationFilled =
      'assets/images/svg/notification_filled.svg';

  static const Map<String, dynamic> bottomNavigationItems = {
    'Lessons': {'inactive': category, 'active': categoryFilled},
    'Chat': {'inactive': notification, 'active': notificationFilled},
    'Home': {'inactive': home, 'active': homeFilled},
    'File': {'inactive': heart, 'active': heartFilled},
    'Setting': {'inactive': user, 'active': userFilled}
  };
}
