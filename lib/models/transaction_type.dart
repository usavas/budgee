class TransactionType {
  int transactionTypeId;
  int transactionCategoryId;
  String transactionTypeName;
  int transactionTypeColor;
  int transactionTypeIcon;
  String transactionTypeDescription;
  bool isActive = true;

  TransactionType(
      {this.transactionTypeId,
      this.transactionCategoryId,
      this.transactionTypeName,
      this.transactionTypeColor,
      this.transactionTypeIcon,
      this.transactionTypeDescription,
      this.isActive = true});

  TransactionType.fromJSON(Map<String, dynamic> jsonMap)
      : transactionTypeId = jsonMap['transactionTypeId'],
        transactionCategoryId = jsonMap['transactionCategoryId'],
        transactionTypeName = jsonMap['transactionTypeName'],
        transactionTypeColor = jsonMap['transactionTypeColor'],
        transactionTypeIcon = jsonMap['transactionTypeIcon'],
        transactionTypeDescription = jsonMap['transactionTypeDescription'],
        isActive = jsonMap['isActive'];

  Map<String, dynamic> toDbMap() => {
        'transaction_type_id': transactionTypeId,
        'transaction_cat_id': transactionCategoryId,
        'transaction_type_name': transactionTypeName,
        'transaction_type_color': transactionTypeColor,
        'transaction_type_icon': transactionTypeIcon,
        'transaction_type_description': transactionTypeDescription,
        'is_active': isActive ? 1 : 0,
      };

  factory TransactionType.fromDbMap(Map<String, dynamic> json) {
    return new TransactionType(
      transactionTypeId: json['id'],
      transactionCategoryId: json['transaction_cat_id'],
      transactionTypeName: json['transaction_type_name'],
      transactionTypeColor: json['transaction_type_color'],
      transactionTypeIcon: int.parse(json['transaction_type_icon']),
      transactionTypeDescription: json['transaction_type_description'],
      isActive: (json['is_active'] == 1) ? true : false,
    );
  }
}
