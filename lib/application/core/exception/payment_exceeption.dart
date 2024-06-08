
class PaymentException implements Exception {
  final String? status;
  final Map? paymentObject;
  final String? failedReason;

  @override
  String toString() {
    return 'PaymentException{status: $status, paymentObject: $paymentObject, failedReason: $failedReason}';
  }

  PaymentException(
      {required this.status, required this.paymentObject, this.failedReason});
}
