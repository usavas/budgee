import 'package:expenses/models/transaction_info.dart';

final List<TransactionInfo> _transactionsMock = <TransactionInfo>[
    TransactionInfo(
      transactionDate: DateTime.now(),
      transactionAmount: 600,
      transactionTypeId: 1,
      transactionNote: "House rent payed",
    ),
    TransactionInfo(
      transactionDate: DateTime.now().add(Duration(days: -10)),
      transactionAmount: 320.40,
      transactionTypeId: 3,
      transactionNote: "Gasoline",
    ),
    TransactionInfo(
      transactionDate: DateTime.now().add(Duration(days: -5)),
      transactionAmount: 120,
      transactionTypeId: 4,
    ),
    TransactionInfo(
      transactionDate: DateTime.now().add(Duration(days: -5)),
      transactionAmount: 230,
      transactionTypeId: 6,
      transactionNote: "I bought a gift for my mother's birthday",
    ),
    TransactionInfo(
      transactionDate: DateTime.now().add(Duration(days: -2)),
      transactionAmount: 160,
      transactionTypeId: 8,
      transactionNote: "A lot of books",
    ),
    TransactionInfo(
      transactionDate: DateTime.now(),
      transactionAmount: 120,
      transactionTypeId: 1,
      transactionNote: "A romantic dinner :P",
    ),
    TransactionInfo(
      transactionDate: DateTime.now().add(Duration(days: -5)),
      transactionAmount: 230,
      transactionTypeId: 6,
      transactionNote: "I bought a gift for my mother's birthday",
    ),
    TransactionInfo(
      transactionDate: DateTime.now().add(Duration(days: -2)),
      transactionAmount: 160,
      transactionTypeId: 8,
      transactionNote: "A lot of books",
    ),
    TransactionInfo(
      transactionDate: DateTime.now(),
      transactionAmount: 120,
      transactionTypeId: 1,
      transactionNote: "A romantic dinner :P",
    )
  ];