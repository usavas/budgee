import 'helpers/datetime_converter.dart';

class TransactionInfoDto {
  int transactionId;
  String transactionType;
  int transactionTypeId;
  String transactionCategoryName;
  int transactionCategoryId;
  String transactionNote;
  DateTime transactionDate;
  double transactionAmount;

  TransactionInfoDto(
      {this.transactionId,
      this.transactionType,
      this.transactionTypeId,
      this.transactionCategoryName,
      this.transactionCategoryId,
      this.transactionNote,
      this.transactionDate,
      this.transactionAmount});

  factory TransactionInfoDto.fromDbMap(Map<String, dynamic> json) {
    TransactionInfoDto _transactionInfoDto = TransactionInfoDto(
      transactionId: json['id'],
      transactionType: json['transaction_type_name'],
      transactionTypeId: json['transaction_type_id'] as int,
      transactionCategoryName: json['transaction_cat_name'],
      transactionCategoryId: json['transaction_cat_id'] as int,
      transactionNote: json['transaction_note'],
      transactionAmount: json['transaction_amount'] as double,
    );
    var _transactionDate =
        DateTimeConverter.fromDoubleToDateTime(json['transaction_date']);
    if (_transactionDate != null) {
      _transactionInfoDto.transactionDate = _transactionDate;
    }

    return _transactionInfoDto;
  }
}
