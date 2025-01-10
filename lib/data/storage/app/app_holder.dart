abstract class AppHolder {
  late String language;
  late String fcmToken;
  late double fontSize;
  late bool isDarkMode;
  late String token;
  late String notes;
  late int id;
  late int custId;
  late String name;
  late String price;
  late String password;
  late String number;
  late String email;
  late String level;
  late String group;
  late String myNotes;
  late bool blocked;
  late bool isSwitch;
  String? homeData;
  String? ledgerDetail;
  String? documentData;
  String? ledgerData;
  String? faqData;
  String? projectData;
  String? localDate;
  String? fCMToken;

  late bool isOpenFromNotification;
  late String? screenOpenViaNotification ;

  Future<void> clearAuth();

  Future<void> delete(String id);
}
