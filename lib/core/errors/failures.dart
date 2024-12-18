// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'enums.dart';

class Failure {}

class ServerFailure extends Failure {
  String? message;
  ServerFailure({
    this.message,
  });
}

class LoginFailure extends Failure {
  List<LoginError>? errors;
  LoginFailure({
    this.errors,
  });
}

class RegisterFailure extends Failure {
  List<RegisterError>? errors;
  RegisterFailure({
    this.errors,
  });
}

class OfflineFailure extends Failure {}

class CheckTokenFailure extends Failure {}

class ProductsFailure extends Failure {}

class ProductFailure extends Failure {
  ProductError? error;
  ProductFailure({
    this.error,
  });
}

class UnauthenticatedFailure extends Failure {}

class InvalidRequestBodyFailure extends Failure {}

class AccountAlreadyTakenFailure extends Failure {}

class EmailPasswordNotMatchFailure extends Failure {}

class IncorrectPasswordFailure extends Failure {}

class EmailNotExistFailure extends Failure {}

class MeterNotFoundFailure extends Failure {}

class CleanBillsShouldPaidBeforeFailure extends Failure {}

class RechargeMeterServerFailure extends Failure {
  String? message;
  RechargeMeterServerFailure(this.message);
}

class AllMonthBillsPaidFailure extends Failure {}

class MonthBillPaidBeforeFailure extends Failure {}

class ReceiverNotFoundFailure extends Failure {}

class UserNotFoundFailure extends Failure {}

class CardNotFoundFailure extends Failure {}

class InsufficientBalanceFailure implements Failure {}

class SaveFCMTokenFailure implements Failure {}

class FCMTokenFailure implements Failure {}

class GoogleSignInFailure implements Failure {}

class AddOrderFailure implements Failure {}

class FirebaseAuthEmailPasswordFailure implements Failure {}

class FirebaseAuthPhonePasswordFailure implements Failure {}

class UserNotFoundForThatEmailFailure implements Failure {}

class WrongPasswordFailure implements Failure {}

class NotValidBarcodeFailure implements Failure {}

class ProductAlreadyExistFailure implements Failure {}

class NoConfigFoundFailure implements Failure {}

class RegisterNotCompleteFailure implements Failure {
  String email;
  RegisterNotCompleteFailure(this.email);
}
