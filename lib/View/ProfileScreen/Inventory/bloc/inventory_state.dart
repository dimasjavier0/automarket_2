part of 'inventory_bloc.dart';

@immutable
abstract class InventoryState {}

class InventoryInitial extends InventoryState {}

class InventorySuccess extends InventoryState {
  final List<ProductEntity> productList;

  InventorySuccess(this.productList);
}

class InventoryEmpty extends InventoryState {}
