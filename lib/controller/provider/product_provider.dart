import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shoping_app/model/product_model.dart';

class ProductData extends ChangeNotifier {
  List<ProductModel?> post = [];
  bool loading = false;
  List<CategoryDishes?> cart = [];
   Map<String, CategoryDishes> _items = {};
   Map<String, CategoryDishes> get items {
    return {..._items};
  }

  int get itemCount {
    
    return _items.length;
  }

  void additem(String productid, int quntity, String title) {
    if (_items.containsKey(productid)) {
      _items.update(
          productid,
          (existingCartItem) => CategoryDishes(
              dishId: productid,
              dishName: title,
              quantity: existingCartItem.quantity! + 1));
    } else {
      _items.putIfAbsent(
          productid,
          () =>
              CategoryDishes(dishId: productid, dishName: title, quantity: 1));
    }
    notifyListeners();
  }

  Future<List<ProductModel>?> productlist(context) async {
    print("start");
    var url = Uri.parse("https://www.mocky.io/v2/5dfccffc310000efc8d2c1ad");
    var response = await http.get(url);

    if (response.statusCode == 200) {
      print("Added");
      var productlist = response.body;
      // List<ProductModel?> temp =
      //     (productlist as List).map((e) => ProductModel.fromJson(e)).toList();
      // post.addAll(temp);
      notifyListeners();
      return productModelFromJson(productlist);
    } else {
      print('not Added');
      return throw Exception('Failed to load product');
    }
  }

  getPostData(context) async {
    loading = true;
    final response = await productlist(context);

    post.addAll(response!);

    loading = false;

    notifyListeners();
  }
}
