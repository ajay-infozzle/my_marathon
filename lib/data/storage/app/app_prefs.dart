import 'package:hive_flutter/hive_flutter.dart';
import 'app_holder.dart';

class AppPrefs extends AppHolder {
  late Box appBox;
  late Box navigationBox;

  AppPrefs() {
    appBox = Hive.box(appBoxId);
    navigationBox = Hive.box(naviationBoxId);
  }

  //encapsulations of variables ------------------------------------------------
  @override
  String get language => appBox.get(languageId, defaultValue: 'en');

  @override
  set language(String language) => appBox.put(languageId, language);

  @override
  bool get isDarkMode => appBox.get(isDarkModeId, defaultValue: false);

  @override
  set isDarkMode(bool isDarkMode) => appBox.put(isDarkModeId, isDarkMode);

  @override
  double get fontSize => appBox.get(fontSizeId, defaultValue: 1.0);

  @override
  set fontSize(double fontSize) => appBox.put(fontSizeId, fontSize);

  @override
  String get token => appBox.get(tokenId, defaultValue: '');

  @override
  set token(String token) => appBox.put(tokenId, token);

  @override
  String get notes => appBox.get(importantNotesId, defaultValue: "");

  @override
  set notes(String notes) => appBox.put(importantNotesId, notes);

  @override
  String get name => appBox.get(nameId, defaultValue: "");

  @override
  set name(String name) => appBox.put(nameId, name);

  @override
  int get id => appBox.get(userId, defaultValue: 0);

  @override
  set id(int id) => appBox.put(userId, id);

  @override
  String get price => appBox.get(priceId, defaultValue: "0");

  @override
  set price(String price) => appBox.put(priceId, price);

  @override
  String get password => appBox.get(passwordId, defaultValue: "");

  @override
  set password(String password) => appBox.put(passwordId, password);

  @override
  String get number => appBox.get(numberId, defaultValue: "");

  @override
  set number(String number) => appBox.put(numberId, number);

  @override
  String get level => appBox.get(levelId, defaultValue: "");

  @override
  set level(String level) => appBox.put(levelId, level);

  @override
  String get group => appBox.get(groupId, defaultValue: "");

  @override
  set group(String group) => appBox.put(groupId, group);

  @override
  String get myNotes => appBox.get(myNotesId, defaultValue: "");

  @override
  set myNotes(String myNotes) => appBox.put(myNotesId, myNotes);

  @override
  String get fcmToken => appBox.get(fcmTokenId, defaultValue: "");

  @override
  set fcmToken(String fcmToken) => appBox.put(fcmTokenId, fcmToken);

  @override
  String get email => appBox.get(emailId, defaultValue: "");

  @override
  set email(String email) => appBox.put(emailId, email);

  @override
  int get custId => appBox.get(custIdId, defaultValue: 0);

  @override
  set custId(int custId) => appBox.put(custIdId, custId);

  @override
  bool get blocked => appBox.get(blockedId, defaultValue: false);

  @override
  set blocked(bool blocked) => appBox.put(blockedId, blocked);

  @override
  bool get isSwitch => appBox.get(isSwitchApt, defaultValue: false);

  @override
  set isSwitch(bool isSwitch) => appBox.put(isSwitchApt, isSwitch);

  @override
  String get homeData => appBox.get(homeData1, defaultValue: "");

  @override
  set homeData(String? data) => appBox.put(homeData1, data);

  @override
  String get ledgerDetail => appBox.get(ledgerDetail1, defaultValue: "");

  @override
  set ledgerDetail(String? data) => appBox.put(ledgerDetail1, data);

  @override
  String get documentData => appBox.get(documentData1, defaultValue: "");

  @override
  set documentData(String? data) => appBox.put(documentData1, data);

  @override
  String get ledgerData => appBox.get(ledgerData1, defaultValue: "");

  @override
  set ledgerData(String? data) => appBox.put(ledgerData1, data);

  @override
  String get faqData => appBox.get(faqData1, defaultValue: "");

  @override
  set faqData(String? data) => appBox.put(faqData1, data);

  @override
  String get localDate => appBox.get(localDate1, defaultValue: "");

  @override
  set localDate(String? data) => appBox.put(localDate1, data);

  @override
  String get projectData => appBox.get(projectData1, defaultValue: "");

  @override
  set projectData(String? data) => appBox.put(projectData1, data);

  @override
  String get fCMToken => appBox.get(fCMToken1, defaultValue: "");

  @override
  set fCMToken(String? data) => appBox.put(fCMToken1, data);


  //~
  @override
  String get screenOpenViaNotification => navigationBox.get(screenOpen, defaultValue: "");

  @override
  set screenOpenViaNotification(String? data) => navigationBox.put(screenOpen, data);

  @override
  bool get isOpenFromNotification => navigationBox.get(isFromNotification, defaultValue: false);

  @override
  set isOpenFromNotification(bool? data) => navigationBox.put(isFromNotification, data);
  //~


  //variablesId ----------------------------------------------------------------
  static const appBoxId = 'app_hive_box';
  static const naviationBoxId = 'app_navigation';
  static const languageId = 'language';
  static const fontSizeId = 'fontSize';
  static const isDarkModeId = 'isDark';
  static const tokenId = 'token';
  static const importantNotesId = "notes";
  static const nameId = "name";
  static const userId = "id";
  static const custIdId = "custId";
  static const priceId = 'price';
  static const passwordId = 'password';
  static const numberId = 'number';
  static const emailId = 'email';
  static const levelId = 'level';
  static const groupId = 'group';
  static const myNotesId = 'myNotes';
  static const fcmTokenId = 'fcmToken';
  static const blockedId = 'blocked';
  static const isSwitchApt = 'isSwitch';
  static const homeData1 = 'homeData';
  static const ledgerDetail1 = 'ledgerDetail';
  static const documentData1 = 'documentData';
  static const ledgerData1 = 'ledgerData';
  static const faqData1 = 'faqData';
  static const localDate1 = 'localDate';
  static const projectData1 = 'projectData';
  static const fCMToken1 = 'fCMToken';

  //~
  static const screenOpen = 'screenOpen';
  static const isFromNotification = 'isFromNotification';
  //~

  //functions ------------------------------------------------------------------
  @override
  Future<void> clearAuth() async => await appBox.clear();

  @override
  Future<void> delete(String id) async => await appBox.delete(id);
}
