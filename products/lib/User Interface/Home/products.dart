import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:products/Bloc/products_bloc.dart';
import 'package:products/Data%20Model/categories.dart';
import 'package:products/Data%20Model/products.dart';
import 'package:products/reuseable_widgets/SearchBar.dart';
import 'package:products/reuseable_widgets/textStyle.dart';

class ProductsList extends StatefulWidget {
  const ProductsList({Key? key}) : super(key: key);

  @override
  State<ProductsList> createState() => _ProductsListState();
}

class _ProductsListState extends State<ProductsList> {
  ProductBloc? productBloc;
  final ScrollController _scrollController = ScrollController();

  bool loading = false, allLoaded = false;
  @override
  void initState() {
    productBloc = new ProductBloc();
    // TODO: implement initState

    super.initState();
    productBloc!.eventSink.add(Product_Event.GET_CATEGORIES_LIST);
    productBloc!.eventSink.add(Product_Event.GET_PRODUCT_LIST);

    _scrollController.addListener(_scrollListener);
  }

  _scrollListener() {
    if (_scrollController.offset <=
            _scrollController.position.minScrollExtent &&
        !_scrollController.position.outOfRange) {
      print("load top");
    }

    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      productBloc!.nextPage();
    }
  }

  List<ProductsList> items = [];

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
  }

  var itemList = [
    'Hight to Low',
    'Low to Hight',
  ];

  PopupMenuItem _buildPopupMenuItem(String title) {
    return PopupMenuItem(
      child: Text(title),
      onTap: () {
        if (title == "Remove filter") {
          productBloc!.filterByPrice(0);
        } else if (title == "High to Low") {
          productBloc!.filterByPrice(2);
        } else if (title == "Low to High") {
          productBloc!.filterByPrice(1);
          print(title);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.dark,
      home: Scaffold(
        body: SafeArea(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 20, 0),
              child: Column(
                children: [
                  Container(
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 0),
                            child: Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                child: SearchBar()),
                          ),
                          PopupMenuButton(
                            onSelected: (value) {},
                            itemBuilder: (ctx) => [
                              _buildPopupMenuItem('High to Low'),
                              _buildPopupMenuItem('Low to High'),
                              _buildPopupMenuItem('Remove filter'),
                            ],
                          )
                        ]),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  StreamBuilder<List<Categories>>(
                      stream: productBloc!.stateStreamCategories,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(children: [
                              for (int i = 0; i < snapshot.data!.length; i++)
                                GestureDetector(
                                  onTap: () {
                                    productBloc!
                                        .filterByCategory(snapshot.data![i].id);
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(0, 0, 10, 10),
                                    child: Container(
                                        decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.5),
                                                spreadRadius: 1,
                                                blurRadius: 7,
                                                offset: Offset(0,
                                                    3), // changes position of shadow
                                              ),
                                            ],
                                            color: Colors.white,
                                            shape: BoxShape.rectangle,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(25))),
                                        height: 40,
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Image.network(
                                              snapshot.data![i].imageUrl,
                                              height: 30,
                                              width: 30,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(right: 6),
                                              child: Text(
                                                snapshot.data![i].name,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                          ],
                                        )),
                                  ),
                                ),
                            ]),
                          );
                        } else {
                          return Container();
                        }
                      }),
                  SizedBox(
                    height: 20,
                  ),
                  ProductList()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget ProductList() {
    return Expanded(
      child: StreamBuilder<List<Products>>(
          stream: productBloc!.stateStreamProduct,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Stack(
                children: [
                  ListView.builder(
                    controller: _scrollController,
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, i) {
                      return GestureDetector(
                        onTap: () {},
                        child: Container(
                          color: Colors.white,
                          height: 130,
                          child: Container(
                              margin: const EdgeInsets.all(5.0),
                              //    padding: const EdgeInsets.all(3.0),
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 1,
                                      blurRadius: 7,
                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                  color: Colors.white,
                                  shape: BoxShape.rectangle,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25))),
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          child: Image.network(
                                            snapshot.data![i].imageUrl,
                                            fit: BoxFit.cover,
                                            height: 150.0,
                                            width: 120.0,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Container(
                                          color: Colors.white,
                                          width: 200,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              AutoSizeText(
                                                snapshot.data![i].name,
                                                style: getTextTyle("sb", 13,
                                                    color: Colors.black),
                                                maxLines: 2,
                                                maxFontSize: 14,
                                                minFontSize: 14,
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              AutoSizeText(
                                                snapshot.data![i].description,
                                                style: getTextTyle("sb", 10,
                                                    color: Colors.grey),
                                                maxLines: 3,
                                                maxFontSize: 10,
                                                minFontSize: 8,
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                children: [
                                                  AutoSizeText(
                                                    'RM ${snapshot.data![i].price}',
                                                    style: getTextTyle("sb", 16,
                                                        color: Colors.amber),
                                                    maxLines: 3,
                                                    maxFontSize: 16,
                                                    minFontSize: 12,
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      );
                    },
                  ),
                  if (loading) ...[
                    Positioned(
                        bottom: 0,
                        left: 0,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 80,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        )),
                  ]
                ],
              );
            } else {
              return Container();
            }
          }),
    );
  }
}
