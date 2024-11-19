import 'package:get/get.dart';
import 'package:marathon/controllers/auth/authController.dart';
import 'package:marathon/controllers/auth/password_verification_controller/password_verification_controller.dart';
import 'package:marathon/controllers/home/apartment_details_controller/apartment_controller.dart';
import 'package:marathon/controllers/home/home_conroller.dart';
import 'package:marathon/controllers/home/payments/payments_controller.dart';
import 'package:marathon/controllers/home/refer_controller/refer_controller.dart';
import 'package:marathon/controllers/mainController/main_controller.dart';
import 'package:marathon/controllers/support_controller/support_controller.dart';
import 'package:marathon/domain/use_cases/apartments_use_case/all_project_use_case/all_project_use_case.dart';
import 'package:marathon/domain/use_cases/apartments_use_case/details_use_case/get_apartment_details_use_case.dart';
import 'package:marathon/domain/use_cases/apartments_use_case/get_apartments_use_case.dart';
import 'package:marathon/domain/use_cases/auth/login_use_case.dart';
import 'package:marathon/domain/use_cases/get_documents/get_documents_use_case.dart';
import 'package:marathon/domain/use_cases/get_documents/post_documents_use_case.dart';
import 'package:marathon/domain/use_cases/ledger_use_case/get_ledger_details_use_case.dart';
import 'package:marathon/domain/use_cases/ledger_use_case/payment/payment_info_use_case.dart';
import 'package:marathon/domain/use_cases/message_/message_use_case.dart';
import 'package:marathon/domain/use_cases/my_account_use_case/my_account_use_case.dart';
import 'package:marathon/domain/use_cases/refer_use_case/refer_project_use_case.dart';
import 'package:marathon/domain/use_cases/refer_use_case/refer_use_case.dart';
import 'package:marathon/domain/use_cases/support_use_case/get_faqdata_use_case.dart';
import 'package:marathon/domain/use_cases/terms_and_condition_use_case/terms_and_condition_use_case.dart';
import '../controllers/document/document_controller.dart';
import '../controllers/home/payments/milestone/make_payment_controller/make_payment_controller.dart';
import '../controllers/my_account/my_account_controller.dart';
import '../controllers/terms_and_condition/terms_and_condition_controller.dart';
import '../data/server/api/api_service.dart';
import '../data/server/interceptors/auth.dart';
import '../data/storage/app/app_holder.dart';
import '../data/storage/app/app_prefs.dart';
import '../domain/repo/app_repo.dart';
import '../domain/repo/app_repo_impl.dart';
import '../domain/use_cases/message_/send_message_use_case.dart';

class DIService {
  static Future<void> init() async {
    ///storage -----------------------------------------------------------------
    Get.lazyPut<AppHolder>(() => AppPrefs(), fenix: true);

    ///api_service -------------------------------------------------------------
    Get.lazyPut<ApiService>(() => ApiService(Get.find()), fenix: true);
    Get.lazyPut<AuthInterceptor>(() => AuthInterceptor(Get.find()),
        fenix: true);

    ///repo --------------------------------------------------------------------
    Get.lazyPut<AppRepo>(() => AppRepoImpl(Get.find()), fenix: true);
    Get.lazyPut<LoginUseCase>(() => LoginUseCase(Get.find(), Get.find()),
        fenix: true);
    Get.lazyPut<GetApartmentsUseCase>(() => GetApartmentsUseCase(Get.find()),
        fenix: true);
    Get.lazyPut<GetApartmentDetailsUseCase>(
        () => GetApartmentDetailsUseCase(Get.find()),
        fenix: true);
    Get.lazyPut<GetLedgerDetailsUseCase>(
        () => GetLedgerDetailsUseCase(Get.find()),
        fenix: true);

    Get.lazyPut<GetDocumentsUseCase>(() => GetDocumentsUseCase(Get.find()),
        fenix: true);

    Get.lazyPut<MessageUseCase>(() => MessageUseCase(Get.find()), fenix: true);

    Get.lazyPut<PostDocumentsUseCase>(() => PostDocumentsUseCase(Get.find()),
        fenix: true);
    Get.lazyPut<PaymentInfoUseCase>(() => PaymentInfoUseCase(Get.find()),
        fenix: true);
    Get.lazyPut<SendMessageUseCase>(() => SendMessageUseCase(Get.find()),
        fenix: true);
    //Get.lazyPut<FaqUseCase>(() => FaqUseCase(Get.find()), fenix: true);
    Get.lazyPut<AllProjectUseCase>(() => AllProjectUseCase(Get.find()),
        fenix: true);

    Get.lazyPut<GetFaqDataUseCase>(() => GetFaqDataUseCase(Get.find()),
        fenix: true);
    Get.lazyPut<ReferUseCase>(() => ReferUseCase(Get.find()), fenix: true);
    Get.lazyPut<ReferProjectUseCase>(() => ReferProjectUseCase(Get.find()), fenix: true);
    Get.lazyPut<MyAccountUseCase>(() => MyAccountUseCase(Get.find()), fenix: true);
    Get.lazyPut<TermsAndConditionUseCase>(() => TermsAndConditionUseCase(Get.find()), fenix: true);

    //   Get.lazyPut<CallController>(() => CallController(), fenix: true);
    Get.lazyPut<AuthController>(() => AuthController(Get.find()), fenix: true);
    Get.lazyPut<MainController>(() => MainController(), fenix: true);
    Get.lazyPut<HomeController>(() => HomeController(Get.find()), fenix: true);
    Get.lazyPut<ApartmentController>(
        () =>
            ApartmentController(Get.find(), Get.find(), Get.find(), Get.find()),
        fenix: true);
    Get.lazyPut<PaymentsController>(
        () => PaymentsController(Get.find(), Get.find()),
        fenix: true);
    Get.lazyPut<DocumentController>(
        () => DocumentController(Get.find(), Get.find(), Get.find()),
        fenix: true);
    Get.lazyPut<PasswordVerificationController>(
        () => PasswordVerificationController(Get.find()),
        fenix: true);

    Get.lazyPut<SupportController>(
        () => SupportController(
              Get.find(),
              Get.find(),
              //  Gedocument_screent.find(),
            ),
        fenix: true);
    Get.lazyPut<MakePaymentController>(
        () => MakePaymentController(Get.find(), Get.find()),
        fenix: true);

    Get.lazyPut<ReferController>(() => ReferController(Get.find(),Get.find()), fenix: true);
    Get.lazyPut<MyAccountController>(() => MyAccountController(Get.find()),fenix: true);
    Get.lazyPut<TermsAndConditionController>(() => TermsAndConditionController(Get.find()),fenix: true);
  }
}
