import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:products/Data%20Model/categories.dart';
import 'package:products/Data%20Model/products.dart';

enum Product_Event {
  GET_PRODUCT_LIST,
  GET_CATEGORIES_LIST,
}

class ProductBloc {
  final eventStreamController = StreamController<Product_Event>();

  StreamSink get eventSink => eventStreamController.sink;
  Stream get _eventStream => eventStreamController.stream;

  final stateStreamCategoriesController =
      StreamController<List<Categories>>.broadcast();

  StreamSink<List<Categories>> get _stateSinkCategories =>
      stateStreamCategoriesController.sink;
  Stream<List<Categories>> get stateStreamCategories =>
      stateStreamCategoriesController.stream;

  final stateStreamProductController = StreamController<List<Products>>();

  StreamSink<List<Products>> get _stateSinkProduct =>
      stateStreamProductController.sink;
  Stream<List<Products>> get stateStreamProduct =>
      stateStreamProductController.stream;

  int category_id = 0;
  int filter_id = 0;

  void filterByCategory(int category_id) {
    this.category_id = category_id;
    eventSink.add(Product_Event.GET_PRODUCT_LIST);
  }

  int page = 1, limit = 7;
  List<Products> savedProducts = [];

  void filterByPrice(int filter_id) {
    this.filter_id = filter_id;
    eventSink.add(Product_Event.GET_PRODUCT_LIST);
  }

  bool isNextPage = false, allowNextPage = true;

  void nextPage() {
    if (!allowNextPage) return;

    page = page + 1;
    isNextPage = true;
    eventSink.add(Product_Event.GET_PRODUCT_LIST);
  }

  ProductBloc() {
    _eventStream.listen((event) async {
      if (event == Product_Event.GET_CATEGORIES_LIST) {
        final String response =
            await rootBundle.loadString('assets/jsonData/categories.json');

        List responseData = json.decode(response)["categoryList"] as List;

        _stateSinkCategories
            .add(responseData.map((e) => Categories.fromJson(e)).toList());
      } else if (event == Product_Event.GET_PRODUCT_LIST) {
        final String response =
            await rootBundle.loadString('assets/jsonData/products.json');

        List responseData = json.decode(response)["productList"] as List;

        List<Products> products =
            responseData.map((e) => Products.fromJson(e)).toList();

        int untilIndex = (page * limit);

        if (filter_id == 1) {
          products.sort((a, b) => a.price.compareTo(b.price));
        } else if (filter_id == 2) {
          products.sort((b, a) => a.price.compareTo(b.price));
        }

        if (category_id > 0) {
          products = products
              .where((element) => element.category_id == category_id)
              .toList();
        }
        if ((page * limit) > products.length) {
          untilIndex = products.length - (((page * limit) - products.length));
          allowNextPage = false;
        } else {
          savedProducts
              .addAll(products.getRange((page * limit) - limit, untilIndex));

          products = savedProducts;

          isNextPage = false;
        }

        _stateSinkProduct.add(products);
      }
    });
  }

  void dispose() {}
}
