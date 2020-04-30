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
  int transactionTypeIcon;
  int transactionTypeColor;

  TransactionInfoDto(
      {this.transactionId,
      this.transactionType,
      this.transactionTypeId,
      this.transactionCategoryName,
      this.transactionCategoryId,
      this.transactionNote,
      this.transactionDate,
      this.transactionAmount,
      this.transactionTypeIcon,
      this.transactionTypeColor});

  factory TransactionInfoDto.fromDbMap(Map<String, dynamic> json) {
    TransactionInfoDto _transactionInfoDto = TransactionInfoDto(
        transactionId: json['id'],
        transactionType: json['transaction_type_name'],
        transactionTypeId: json['transaction_type_id'] as int,
        transactionCategoryName: json['transaction_cat_name'],
        transactionCategoryId: json['transaction_cat_id'] as int,
        transactionNote: json['transaction_note'],
        transactionAmount: json['transaction_amount'] as double,
        transactionTypeColor: int.parse(json['transaction_type_color']));

    //todo this is temporary for older values, simlify this, delete the if statement. as of now the only the icon's int representation will be saved in the db
    int _iconDataInt = int.tryParse(json['transaction_type_icon']);
    if (_iconDataInt == null || _iconDataInt == 0) {
      String a = json['transaction_type_icon'];
      String sub = a.substring(11, 16);

      _iconDataInt = int.parse(sub, radix: 16);
    }
    _transactionInfoDto.transactionTypeIcon = _iconDataInt;

    var _transactionDate =
        DateTimeConverter.fromDoubleToDateTime(json['transaction_date']);
    if (_transactionDate != null) {
      _transactionInfoDto.transactionDate = _transactionDate;
    }

    return _transactionInfoDto;
  }
}
