class TransactionCategory {
  int transactionCategoryId;
  String transactionCategoryName;

  TransactionCategory(
    {
      this.transactionCategoryId,
      this.transactionCategoryName});

  TransactionCategory.fromJSON(Map<String, dynamic> jsonMap)
      : transactionCategoryId = jsonMap['transactionCategoryId'],
        transactionCategoryName = jsonMap['transactionCategoryName'];

  Map<String, dynamic> toDbMap() => {
        'transaction_cat_id': transactionCategoryId,
        'transaction_cat_name': transactionCategoryName,
      };

  factory TransactionCategory.fromDbMap(Map<String, dynamic> json) {
    return new TransactionCategory(
        transactionCategoryId: json['transaction_cat_id'],
        transactionCategoryName: json['transaction_cat_name'],
    );
  }
}