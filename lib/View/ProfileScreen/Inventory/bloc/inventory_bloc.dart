import 'package:flutter/material.dart';
import 'package:automarket/Model/GetX/Controller/profile_controller.dart';
import 'package:automarket/Model/Tools/JsonParse/product_parse.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

part 'inventory_event.dart';
part 'inventory_state.dart';

class InventoryBloc extends Bloc<InventoryEvent, InventoryState> {
  InventoryBloc() : super(InventoryInitial()) {
    on<InventoryEvent>((event, emit) async {
      final profileFunctions = Get.find<ProfileController>().profileFunctions;
      if (event is InventoryStart) {
        final List<ProductEntity> productList =
            await profileFunctions.getInventoryProducts();
        if (productList.isNotEmpty) {
          emit(InventorySuccess(productList));
        } else {
          emit(InventoryEmpty());
        }
      }
    });
  }
}
