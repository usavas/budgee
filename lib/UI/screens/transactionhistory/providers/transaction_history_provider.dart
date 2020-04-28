import 'package:expenses/models/transaction_info_dto.dart';
import 'package:expenses/repositories/transaction_repository.dart';
import 'package:flutter/foundation.dart';

class TransactionHistoryProvider with ChangeNotifier {
  Future<List<TransactionInfoDto>> transactionInfos =
      TransactionRepository().getTransactionInfoDtos();

  updateTransactionInfoDtos() {
    print('updateTransactionInfoDtos method being called');
    transactionInfos = TransactionRepository().getTransactionInfoDtos();
    notifyListeners();
  }
}
