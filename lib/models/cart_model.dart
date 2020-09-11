import 'package:lojinha/datas/cart_product.dart';
import 'package:lojinha/models/user_model.dart';
import 'package:lojinha/services/api.dart';
import 'package:scoped_model/scoped_model.dart';

class CartModel extends Model {
  UserModel userModel;
  List<CartProduct> products = [];

  CartModel(this.userModel);

  void addCartItem(CartProduct cartProduct) {
    products.add(cartProduct);
    _storeCart(cartProduct);
  }

  void removeCartItem(CartProduct cartProduct) {
    products.remove(cartProduct);
  }

  Future<Map<String, dynamic>> _storeCart(CartProduct cartProduct) async {
    Map data = await ApiService.post(
        url: "/users/${this.userModel.user["id"]}/carts", data: {});
    return data;
  }
}
