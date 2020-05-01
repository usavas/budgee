import '../models/transaction_info_dto.dart';
import '../dao/transaction_info_dao.dart';
import '../dao/transaction_info_dto_dao.dart';

import 'package:expenses/models/transaction_info.dart';

class TransactionRepository {
  Future<List<TransactionInfoDto>> getTransactionInfoDtosByMonth(
      int year, int month) {
    return TransactionInfoDtoDao().getTransactionInfoDtosByMonth(year, month);
  }
  
  Future<List<TransactionInfo>> getTransactionInfos() {
    return TransactionDao().getTransactions();
  }

  Future<int> deleteTransaction(int transactionId) {
    return TransactionDao().deleteTransactionById(transactionId);
  }

  Future<int> insertTransaction(TransactionInfo transactionInfo) {
    return TransactionDao().insertTransaction(transactionInfo);
  }
}
