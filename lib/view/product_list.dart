import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:shoping_app/controller/provider/product_provider.dart';
import 'package:shoping_app/model/product_model.dart';
import 'package:shoping_app/view/order_details.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ProductData>(context, listen: false).getPostData(context);
      Provider.of<ProductData>(context, listen: false).items;
    });
    super.initState();
  }

  var items;
  ProductData product = ProductData();
  int counter = 1;
  int current = 0;
  double changePositionedOfLine() {
    switch (current) {
      case 0:
        return 0;
      case 1:
        return 150;
      case 2:
        return 295;
      case 3:
        return 263;
      default:
        return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final postMdl = Provider.of<ProductData>(context);
    print(postMdl.post.length);

    return Scaffold(
      drawer: const Icon(
        Icons.draw_rounded,
      ),
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const OrdersDetails()),
            );
            },
            child: Center(
                child: Badge(
              badgeContent: Text(context.read<ProductData>().itemCount.toString()),
              badgeAnimation: BadgeAnimation.slide(),
              child: Icon(Icons.shopping_cart_outlined),
            )),
          ),
          SizedBox(
            width: 20,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                    itemCount: postMdl.post.length,
                    itemBuilder: ((context, index) {
                      return Column(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.06,
                            width: MediaQuery.of(context).size.width,
                            color: Colors.white,
                            child: Stack(
                              children: [
                                Positioned(
                                  top: 0,
                                  left: 0,
                                  right: 0,
                                  child: SizedBox(
                                      height: 42,
                                      width: double.infinity,
                                      child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: postMdl.post[index]!
                                              .tableMenuList!.length,
                                          itemBuilder: ((context, curentindex) {
                                            return Row(
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      current = curentindex;
                                                    });
                                                  },
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: curentindex == 0
                                                            ? 10
                                                            : 23,
                                                        top: 7),
                                                    child: Text(
                                                      postMdl
                                                          .post[index]!
                                                          .tableMenuList![
                                                              curentindex]
                                                          .menuCategory
                                                          .toString(),
                                                      style: TextStyle(
                                                          color: current ==
                                                                  curentindex
                                                              ? Colors.red
                                                              : Colors.grey,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            );
                                          }))),
                                ),
                                Positioned(
                                  bottom: 0,
                                  left: changePositionedOfLine(),
                                  child: Container(
                                    height: 2,
                                    width: MediaQuery.of(context).size.width *
                                        0.33,
                                    color: Colors.red,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.85,
                                width: MediaQuery.of(context).size.width,
                                child: ListView.builder(
                                    itemCount: postMdl
                                        .post[index]!.tableMenuList!.length,
                                    itemBuilder: ((context, indextable) {
                                      var product = postMdl.post[index]!
                                          .tableMenuList![indextable];
                                      return Column(
                                        children: [
                                          SizedBox(
                                              // height: MediaQuery.of(context)
                                              //         .size
                                              //         .height *
                                              //     0.24,
                                              width: double.infinity,
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Icon(
                                                    Icons.food_bank_sharp,
                                                    size: 20,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 8),
                                                        child: Text(
                                                          product
                                                              .categoryDishes![
                                                                  index]
                                                              .dishName
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                      Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 8,
                                                                    top: 8),
                                                            child: Text(
                                                              product
                                                                  .categoryDishes![
                                                                      index]
                                                                  .dishCurrency
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 8,
                                                                    top: 8),
                                                            child: Text(
                                                              product
                                                                  .categoryDishes![
                                                                      index]
                                                                  .dishPrice
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 8),
                                                        child: Container(
                                                          width: 200,
                                                          child: Text(
                                                            product
                                                                .categoryDishes![
                                                                    index]
                                                                .dishDescription
                                                                .toString(),
                                                            maxLines: 4,
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Counter(
                                                        id: product
                                                            .categoryDishes![
                                                                index]
                                                            .dishId,
                                                        title: product
                                                            .categoryDishes![
                                                                index]
                                                            .dishName,
                                                      )
                                                    ],
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.topCenter,
                                                    child: Text(
                                                        "${product.categoryDishes![index].dishCalories.toString()} calories"),
                                                  ),
                                                  // Image(
                                                  //     height: 100,
                                                  //     width: 30,
                                                  //     image: NetworkImage(
                                                  //         product
                                                  //             .categoryDishes![
                                                  //                 index]
                                                  //             .dishImage
                                                  //             .toString()))
                                                ],
                                              )),
                                          const Divider(
                                            color: Colors.grey,
                                            thickness: 1,
                                          ),
                                        ],
                                      );
                                    })),
                              ),
                            ],
                          ),
                        ],
                      );
                    }))),
          ],
        ),
      ),
    );
  }
}

class Counter extends StatefulWidget {
  final String? title;
  final String? id;
  const Counter({super.key, this.title, this.id});

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ProductData>(context, listen: false).getPostData(context);
      Provider.of<ProductData>(context, listen: false).items;
    });
    super.initState();
  }

  int count = 1;
  @override
  Widget build(BuildContext context) {
    final postMdl = Provider.of<ProductData>(context);
    print(postMdl.post.length);
    return Padding(
      padding: const EdgeInsets.only(top: 8, left: 8),
      child: Container(
        height: 43,
        width: 120,
        decoration: BoxDecoration(
            color: Colors.green, borderRadius: BorderRadius.circular(24)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.remove),
              Text(
                "${count}",
                style: TextStyle(color: Colors.white),
              ),
              InkWell(
                  onTap: () {
                    setState(() {
                      count++;
                      postMdl.additem(
                          widget.id.toString(), count, widget.title.toString());
                    });
                  },
                  child: Icon(Icons.add))
            ],
          ),
        ),
      ),
    );
  }
}
