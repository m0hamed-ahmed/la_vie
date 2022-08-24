import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_vie/core/utils/methods.dart';
import 'package:la_vie/data/models/plant_model.dart';
import 'package:la_vie/data/models/seed_model.dart';
import 'package:la_vie/data/models/tool_model.dart';
import 'package:la_vie/domain/entities/cart.dart';
import 'package:la_vie/presentation/controller/cart/states.dart';
import 'package:la_vie/presentation/resources/strings_manager.dart';

class CartCubit extends Cubit<CartStates> {
  CartCubit() : super(CartInitialState());

  static CartCubit get(context) => BlocProvider.of(context);

  final List<Cart> _cart = [];
  List<Cart> get cart => _cart;
  addToCart(dynamic item, int quantity) {
    _cart.insert(0, Cart(item: item, quantity: quantity));
    Methods.showToastMessage(StringManager.addedToCart);
    emit(AddToCartState());
  }

  removeFromCart(dynamic item) {
    if(item.runtimeType == PlantModel) {
      int index = _cart.indexWhere((element) => element.item.runtimeType == PlantModel && element.item.plantId == item.plantId);
      _cart.removeAt(index);
    }
    else if(item.runtimeType == SeedModel) {
      int index = _cart.indexWhere((element) => element.item.runtimeType == SeedModel && element.item.seedId == item.seedId);
      _cart.removeAt(index);
    }
    else if(item.runtimeType == ToolModel) {
      int index = _cart.indexWhere((element) => element.item.runtimeType == ToolModel && element.item.toolId == item.toolId);
      _cart.removeAt(index);
    }
    emit(RemoveFromCartState());
  }

  incrementQuantity(dynamic item) {
    if(item.runtimeType == PlantModel) {
      int index = _cart.indexWhere((element) => element.item.runtimeType == PlantModel && element.item.plantId == item.plantId);
      _cart[index].quantity ++;
    }
    else if(item.runtimeType == SeedModel) {
      int index = _cart.indexWhere((element) => element.item.runtimeType == SeedModel && element.item.seedId == item.seedId);
      _cart[index].quantity ++;
    }
    else if(item.runtimeType == ToolModel) {
      int index = _cart.indexWhere((element) => element.item.runtimeType == ToolModel && element.item.toolId == item.toolId);
      _cart[index].quantity ++;
    }
    emit(ChangeQuantityState());
  }

  decrementQuantity(dynamic item) {
    if(item.runtimeType == PlantModel) {
      int index = _cart.indexWhere((element) => element.item.runtimeType == PlantModel && element.item.plantId == item.plantId);
      if(_cart[index].quantity > 1) {
        _cart[index].quantity --;
      }
    }
    else if(item.runtimeType == SeedModel) {
      int index = _cart.indexWhere((element) => element.item.runtimeType == SeedModel && element.item.seedId == item.seedId);
      if(_cart[index].quantity > 1) {
        _cart[index].quantity --;
      }
    }
    else if(item.runtimeType == ToolModel) {
      int index = _cart.indexWhere((element) => element.item.runtimeType == ToolModel && element.item.toolId == item.toolId);
      if(_cart[index].quantity > 1) {
        _cart[index].quantity --;
      }
    }
    emit(ChangeQuantityState());
  }

  int getQuantity(dynamic item) {
    if(item.runtimeType == PlantModel) {
      int index = _cart.indexWhere((element) => element.item.runtimeType == PlantModel && element.item.plantId == item.plantId);
      return index == -1 ? 1 : _cart[index].quantity;
    }
    else if(item.runtimeType == SeedModel) {
      int index = _cart.indexWhere((element) => element.item.runtimeType == SeedModel && element.item.seedId == item.seedId);
      return index == -1 ? 1 : _cart[index].quantity;
    }
    else if(item.runtimeType == ToolModel) {
      int index = _cart.indexWhere((element) => element.item.runtimeType == ToolModel && element.item.toolId == item.toolId);
      return index == -1 ? 1 : _cart[index].quantity;
    }
    else {
      return 1;
    }
  }

  bool inCart(dynamic item) {
    if(item.runtimeType == PlantModel) {
      int index = _cart.indexWhere((element) => element.item.runtimeType == PlantModel && element.item.plantId == item.plantId);
      return index == -1 ? false : true;
    }
    else if(item.runtimeType == SeedModel) {
      int index = _cart.indexWhere((element) => element.item.runtimeType == SeedModel && element.item.seedId == item.seedId);
      return index == -1 ? false : true;
    }
    else if(item.runtimeType == ToolModel) {
      int index = _cart.indexWhere((element) => element.item.runtimeType == ToolModel && element.item.toolId == item.toolId);
      return index == -1 ? false : true;
    }
    else {
      return false;
    }
  }

  int getTotalPrice() {
    int total = 0;
    for(int i=0; i<cart.length; i++) {
      total += (cart[i].quantity * 70);
    }
    return total;
  }
}