import 'package:expenses/models/transaction_info_dto.dart';
import 'package:expenses/repositories/transaction_repository.dart';
import 'package:flutter/foundation.dart';

class TransactionHistoryProvider with ChangeNotifier {
  Future<List<TransactionInfoDto>> _transactionInfos;

  Future<List<TransactionInfoDto>> getTransactionInfoDtos() async {
    _transactionInfos = TransactionRepository().getTransactionInfoDtos();
    return _transactionInfos;
  }

  updateTransactionInfoDtos() async { 
    //todo cache the list of transactions and retrieve only the newly added or updated one
    //maybe compare over hash values of transaction infos'
    _transactionInfos = TransactionRepository().getTransactionInfoDtos();
    notifyListeners();
  }
}
