import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

class InAppPurchaseProvider with ChangeNotifier {
  InAppPurchaseConnection _iap;
  InAppPurchaseProvider() {
    _iap = InAppPurchaseConnection.instance;
    print('_iap instance initialized?');
    print(_iap.isAvailable()); //returns future<bool>
    print(_iap.toString());
  }

  Future<bool> isPurchased(String productId) async {
    QueryPurchaseDetailsResponse response = await _iap.queryPastPurchases();
    print('is _iap available: ' + (await _iap.isAvailable()).toString());
    bool _isPurchased = response.pastPurchases.any((purchase) =>
        purchase.productID == productId &&
        purchase.status == PurchaseStatus.purchased);
    print('isPurchased: ' + _isPurchased.toString());
    return _isPurchased;
  }

  Future<void> purchaseProduct(String productId) async {
    ProductDetails productDetails = await _getProduct(productId);
    if (productDetails == null) return;

    final PurchaseParam _purchaseParam =
        PurchaseParam(productDetails: productDetails);
    bool isPurchased =
        await _iap.buyNonConsumable(purchaseParam: _purchaseParam);
    print('isPurchased: ' + isPurchased.toString());
    notifyListeners();
  }

  Future<ProductDetails> _getProduct(String productId) async {
    ProductDetailsResponse response =
        await _iap.queryProductDetails(Set.from([productId]));
    List<ProductDetails> _products = response.productDetails;

    if (_products == null) {
      print('productDetails is null');
      return null;
    }

    print('products length: ' + _products.length.toString());
    return _products.firstWhere(
      (p) => p.id == productId,
      orElse: () => null,
    );
  }
}
