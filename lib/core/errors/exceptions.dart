// ignore_for_file: public_member_api_docs, sort_constructors_first
class ServerException implements Exception {
  int? statusCode;
  String? error;
  ServerException({this.statusCode, this.error});
}

class LoginException implements Exception {
  List<String>? messages;
  LoginException({
    this.messages,
  });
}

class RegisterException implements Exception {
  List<String>? messages;
  RegisterException({
    this.messages,
  });
}

class CheckTokenException implements Exception {}

class ProductsException implements Exception {}

class ProductException implements Exception {
  int? statusCode;
  ProductException({
    this.statusCode,
  });
}

class UnauthenticatedException implements Exception {}

class InvalidRequestBodyException implements Exception {}

class AccountAlreadyTakenException implements Exception {}

class EmailPasswordNotMatchException implements Exception {}

class IncorrectPasswordException implements Exception {}

class EmailNotExistException implements Exception {}

class MeterNotFoundException implements Exception {}

class RechargeMeterServerException implements Exception {
  String? message;
  RechargeMeterServerException(this.message);
}

class CleanBillsShouldPaidBeforeException implements Exception {}

class AllMonthBillsPaidException implements Exception {}

class MonthBillPaidBeforeException implements Exception {}

class ReceiverNotFoundException implements Exception {}

class UserNotFoundException implements Exception {}

class CardNotFoundException implements Exception {}

class InsufficientBalanceException implements Exception {}

class SaveFCMTokenException implements Exception {}

class FCMTokenException implements Exception {}

class GoogleSignInException implements Exception {}

class AddOrderException implements Exception {}

class FirebaseAuthEmailPasswordException implements Exception {}

class FirebaseAuthPhonePasswordException implements Exception {}

class UserNotFoundForThatEmailException implements Exception {}

class WrongPasswordException implements Exception {}

class NotValidBarcodeException implements Exception {}

class ProductAlreadyExistException implements Exception {}

class NoConfigFoundException implements Exception {}

class RegisterNotCompleteException implements Exception {
  String email;
  RegisterNotCompleteException(this.email);
}


