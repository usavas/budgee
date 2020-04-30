import 'package:expenses/models/transaction_category.dart';
import 'package:expenses/models/transaction_type.dart';
import 'package:flutter/material.dart';


final List<TransactionCategory> transactionCategories = <TransactionCategory>[
  TransactionCategory(
      transactionCategoryId: 1, transactionCategoryName: 'income'),
  TransactionCategory(
      transactionCategoryId: 2, transactionCategoryName: 'expense')  
];

const int _colorTone = 200;

final List<TransactionType> expenseTypes = <TransactionType>[
  TransactionType(
      transactionCategoryId: 2,
      transactionTypeId: 1,
      transactionTypeName: 'Rent',
      transactionTypeDescription: 'House rent, Workplace rent etc.',
      transactionTypeColor:
          Colors.brown[_colorTone].value,
      transactionTypeIcon: Icons.home.codePoint),
  TransactionType(
    transactionCategoryId: 2,
    transactionTypeId: 2,
    transactionTypeName: 'Utilities',
    transactionTypeDescription: 'Electricity, gas, water etc.',
    transactionTypeColor: Colors.pink[_colorTone].value,
    transactionTypeIcon: Icons.lightbulb_outline.codePoint,
  ),
  TransactionType(
      transactionCategoryId: 2,
      transactionTypeId: 3,
      transactionTypeName: 'Transport',
      transactionTypeDescription: 'Gasoline, bus ticket etc.',
      transactionTypeColor:
          Colors.purple[_colorTone].value,
      transactionTypeIcon: Icons.directions_bus.codePoint,
      ),
  TransactionType(
      transactionCategoryId: 2,
      transactionTypeId: 4,
      transactionTypeName: 'Restaurant',
      transactionTypeDescription: 'Restaurant, cafe, eating out',
      transactionTypeColor:
          Colors.yellow[_colorTone].value,
      transactionTypeIcon: Icons.restaurant.codePoint,
      ),
  TransactionType(
      transactionCategoryId: 2,
      transactionTypeId: 5,
      transactionTypeName: 'Groceries',
      transactionTypeDescription: 'Groceries',
      transactionTypeColor:
          Colors.green[_colorTone].value,
      transactionTypeIcon: Icons.shopping_cart.codePoint,
      ),
  TransactionType(
      transactionCategoryId: 2,
      transactionTypeId: 6,
      transactionTypeName: 'Shopping',
      transactionTypeDescription: 'Cloting, shoes etc.',
      transactionTypeColor:
          Colors.blue[_colorTone].value,
      transactionTypeIcon: Icons.shopping_basket.codePoint,
      ),
  TransactionType(
      transactionCategoryId: 2,
      transactionTypeId: 7,
      transactionTypeName: 'Health',
      transactionTypeDescription: 'Hospital, pharmacy, self-care products',
      transactionTypeColor: Colors.red[_colorTone].value,
      transactionTypeIcon: Icons.local_hospital.codePoint
      ),
  TransactionType(
    transactionCategoryId: 2,
    transactionTypeId: 8,
    transactionTypeName: 'Education',
    transactionTypeDescription: 'College fees, courses, books etc.',
    transactionTypeColor:
        Colors.indigo[_colorTone].value,
    transactionTypeIcon: Icons.school.codePoint,
  ),
  TransactionType(
      transactionCategoryId: 2,
      transactionTypeId: 9,
      transactionTypeName: 'Fun',
      transactionTypeDescription: 'Hobbies, travel, party etc.',
      transactionTypeColor:
          Colors.orange[_colorTone].value,
      transactionTypeIcon: Icons.audiotrack.codePoint),
];

final List<TransactionType> incomeTypes = <TransactionType>[
  TransactionType(
    transactionCategoryId: 1,
    transactionTypeId: 101,
    transactionTypeName: "Salary",
    transactionTypeDescription: "Monthly stable income",
    transactionTypeColor: Colors.green[_colorTone].value,
    transactionTypeIcon: Icons.attach_money.codePoint,
  ),
  TransactionType(
    transactionCategoryId: 1,
    transactionTypeId: 102,
    transactionTypeName: "Daily wage",
    transactionTypeDescription: "Daily wage, trade profit, one-time jobs etc.",
    transactionTypeColor: Colors.teal[_colorTone].value,
    transactionTypeIcon: Icons.attach_money.codePoint,
  ),
  TransactionType(
    transactionCategoryId: 1,
    transactionTypeId: 103,
    transactionTypeName: "Other",
    transactionTypeDescription: "All other types of income",
    transactionTypeColor: Colors.blue[_colorTone].value,
    transactionTypeIcon: Icons.attach_money.codePoint,
  )
];
