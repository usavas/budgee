class MonthlyTotalAmount{

  String month;
  String year;
  double amount;

  MonthlyTotalAmount({
    this.amount, 
    this.month,
    this.year, 
  });

  factory MonthlyTotalAmount.fromDbMap(Map<String, dynamic> json) {
    return new MonthlyTotalAmount(
        amount: json['total'] as double,
        month: json['month_num'],
        year: json['year_num']
    );
  }
}