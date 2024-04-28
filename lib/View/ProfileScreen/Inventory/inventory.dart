import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:automarket/Model/GetX/Controller/duplicate_controller.dart';
import 'package:automarket/Model/GetX/Controller/profile_controller.dart';
import 'package:automarket/Model/Tools/Constant/const.dart';
import 'package:automarket/Model/Widget/widget.dart';
import 'package:automarket/View/ProfileScreen/Inventory/bloc/inventory_bloc.dart';
import 'package:automarket/ViewModel/Profile/profile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class Inventory extends StatefulWidget {
  const Inventory({super.key});

  @override
  State<Inventory> createState() => _InventoryState();
}

class _InventoryState extends State<Inventory> {
  InventoryBloc? inventoryBloc;
  @override
  void dispose() {
    inventoryBloc?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final duplicateController = Get.find<DuplicateController>();
    final profileController = Get.find<ProfileController>();
    final ProfileFunctions profileFunctions =
        profileController.profileFunctions;
    final textStyle = duplicateController.textStyle;
    final colors = duplicateController.colors;
    return BlocProvider(
      create: (context) {
        final bloc = InventoryBloc();
        bloc.add(InventoryStart());
        inventoryBloc = bloc;
        return bloc;
      },
      child: BlocBuilder<InventoryBloc, InventoryState>(
        builder: (context, state) {
          if (state is InventorySuccess) {
            return DuplicateTemplate(
              title: "Inventory Screen",
              colors: colors,
              textStyle: textStyle,
              child: ListView.builder(
                padding: const EdgeInsets.only(bottom: 40),
                physics: duplicateController.uiDuplicate.defaultScroll,
                itemCount: state.productList.length,
                itemBuilder: (context, index) {
                  final product = state.productList[index];
                  return HorizontalProductView(
                      colors: colors,
                      product: product,
                      textStyle: textStyle,
                      widget: CupertinoButton(
                        child: Icon(
                          Icons.delete,
                          color: colors.whiteColor,
                        ),
                        onPressed: () async {
                          bool isDeleted = await profileFunctions
                              .removeInventory(productEntity: product);
                          if (isDeleted) {
                            //InventoryBloc!.add(InventoryStart());
                          }
                        },
                      ),
                      margin: const EdgeInsets.only(
                          top: 15, right: 8, left: 8, bottom: 15));
                },
              ),
            );
          } else if (state is InventoryEmpty) {
            return EmptyScreen(
                colors: colors,
                textStyle: textStyle,
                title: "Inventory Screen",
                content: "you're Inventory list is empty",
                lottieName: emptyListLottie);
          }
          return Container();
        },
      ),
    );
  }
}
