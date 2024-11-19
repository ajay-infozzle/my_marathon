// dimport 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class LanguageController extends Translations {
//   @override
//   Map<String, Map<String, String>> get keys =>
//       {'en_US': enEN, 'ru_RU': ruRU, 'uz_UZ': uzUZ};
//
//   static const fallbackLocale = Locale('en', 'US');
//
//   static final items = ['English', 'Русский', 'O\'zbekcha'];
//
//   static final languages = ['en', 'ru', 'uz'];
//
//   static final List<Locale> locales = [
//     const Locale('en', 'US'),
//     const Locale('ru', 'RU'),
//     const Locale('uz', 'UZ'),
//   ];
//
//   static final locale = defLanguage(Get.find<AppHolder>().language);
//
//   static String defaultLanguage() {
//     final locale = Get.locale;
//     var lan = locale.toString();
//     if (lan == "ru_RU") return languages[1];
//     if (lan == "uz_UZ") return languages[2];
//     return languages[0];
//   }
//
//   static Locale defLanguage(String code) {
//     Get.log(code);
//     try {
//       var index = languages.indexOf(code);
//       return locales[index];
//     } catch (e) {
//       return locales[0];
//     }
//   }
//
//   static void changeLocale(String lang) {
//     final locale = _getLocaleFromLanguage(lang);
//     if (locale != null) {
//       Get.updateLocale(locale);
//       Get.find<AppHolder>().language = lang;
//     }
//   }
//
//   static Locale? _getLocaleFromLanguage(String lang) {
//     for (int i = 0; i < languages.length; i++) {
//       if (lang == languages[i]) return locales[i];
//     }
//     return Get.deviceLocale;
//   }
//
//   static String get selectedLang =>
//       items.elementAt(languages.indexOf(defaultLanguage()));
// }
