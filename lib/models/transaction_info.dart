import 'package:expenses/models/transaction_info_dto.dart';
import 'helpers/datetime_converter.dart';

class TransactionInfo {
  int transactionId;
  int transactionTypeId;
  double transactionAmount;
  DateTime transactionDate;
  String transactionNote;

  TransactionInfo({
    this.transactionId,
    this.transactionTypeId,
    this.transactionAmount,
    this.transactionDate,
    this.transactionNote,
  });

  TransactionInfo.fromJSON(Map<String, dynamic> jsonMap)
      : transactionId = jsonMap['id'],
        transactionTypeId = jsonMap['transactionTypeId'],
        transactionAmount = jsonMap['transactionAmount'] as double,
        transactionDate = jsonMap['transactionDate'],
        transactionNote = jsonMap['transactionNote'];

  factory TransactionInfo.fromTransactionInfoDto(TransactionInfoDto dto) {
    return TransactionInfo(
      transactionId: dto.transactionId,
        transactionTypeId: dto.transactionTypeId,
        transactionAmount: dto.transactionAmount,
        transactionDate  : dto.transactionDate,
        transactionNote  : dto.transactionNote
    );
  } 

  Map<String, dynamic> toDbMap() => {
        'id': transactionId,
        'transaction_type_id': transactionTypeId,
        'transaction_date':
            DateTimeConverter.fromDateTimeToDouble(transactionDate),
        'transaction_note': transactionNote,
        'transaction_amount': transactionAmount,
      };

  factory TransactionInfo.fromDbMap(Map<String, dynamic> json) {
    TransactionInfo _ti = new TransactionInfo(
      transactionId: json['id'],
      transactionTypeId: json['transaction_type_id'],
      transactionAmount: json['transaction_amount'] as double,
      transactionNote: json['transaction_note'],
    );

    var _transactionDate =
        DateTimeConverter.fromDoubleToDateTime(json['transaction_date']);
    if (_transactionDate != null) {
      _ti.transactionDate = _transactionDate;
    }

    return _ti;
  }
}
