import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../controller/provider/product_provider.dart';

class OrdersDetails extends StatefulWidget {
  const OrdersDetails({super.key});

  @override
  State<OrdersDetails> createState() => _OrdersDetailsState();
}

class _OrdersDetailsState extends State<OrdersDetails> {
  @override
  Widget build(BuildContext context) {
     final postMdl = Provider.of<ProductData>(context);
    print(postMdl.post.length);
    return Scaffold(
      body: Center(
        child: Text(postMdl.items.length.toString()),
      ),
    );
  }
}
