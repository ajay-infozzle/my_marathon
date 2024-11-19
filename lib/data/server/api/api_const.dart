class Api {
  // static const baseUrl = 'https://marathoncrm.mydemoweblink.com';
  static const baseUrl = 'https://crm.marathon.in';
  static const _api = '/api';
  static const apiKey = '90c19d7e748785d3d37b4abf50e98b14';
  // static const _baseUrl = 'https://marathon-staging.testingweblink.com/wp-json';
  static const _baseUrl = 'https://marathon.in/wp-json';

  static const _student = 'student';
  static const _teacher = 'teacher';

  //auth
  static const getAppVersion = '$baseUrl/api/getinfoformobileapp?apikey=$apiKey&action=app_version';
  static const login = '$_api/login';
  static const getInfo = '$_api/getinfoformobileapp';
  static const getAllProject = '$_baseUrl/marathon-api/v1/all-projects';
  static const getTermsAndCondition ='$_baseUrl/marathon-api/v1/terms-and-conditions';

  static const referApi =
      'https://hooks.zapier.com/hooks/catch/293636/2b2t5vf/';
  static Uri whatsApp = Uri.parse(
      "https://wa.me/917677350350?text=%22Hi%2C%20I%20require%20support%20from%20the%20Marathon%20Customer%20Care%20team.%20Please%20get%20in%20touch%22");
}
