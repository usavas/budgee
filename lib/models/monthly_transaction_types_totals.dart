class MonthlyTransactionTypesTotal {

  String month;
  String year;
  int transactionCategoryId;
  String transactionCategoryName;
  int transactionTypeId;
  String transactionTypeName;
  double totalAmount;

  MonthlyTransactionTypesTotal({
    this.month,
    this.year,
    this.transactionCategoryId,
    this.transactionCategoryName,
    this.transactionTypeId,
    this.transactionTypeName,
    this.totalAmount
  });

  factory MonthlyTransactionTypesTotal.fromDbMap(Map<String, dynamic> json){
    return new MonthlyTransactionTypesTotal(
      month: json['month_num'],
      year: json['year_num'],
      transactionCategoryId: json['transaction_cat_id'] as int,
      transactionCategoryName: json['transaction_cat_name'],
      transactionTypeId: json['transaction_type_id'] as int,
      transactionTypeName: json['transaction_type_name'],
      totalAmount: json['total_amount'] as double
    );
  }

}