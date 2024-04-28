import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:automarket/Model/GetX/Controller/duplicate_controller.dart';
import 'package:automarket/Model/GetX/Controller/home_controller.dart';
import 'package:automarket/Model/GetX/Controller/profile_controller.dart';
import 'package:automarket/Model/Tools/Color/color.dart';
import 'package:automarket/Model/Tools/Constant/const.dart';
import 'package:automarket/Model/Tools/Font/font.dart';
import 'package:automarket/Model/Tools/JsonParse/product_parse.dart';
import 'package:automarket/Model/Widget/widget.dart';
import 'package:automarket/View/HomeScreen/SerachScreen/serach_screen.dart';
import 'package:automarket/View/HomeScreen/ShopScreen/shop_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import 'bloc/home_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

HomeBloc? homeBloc;

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  final duplicateController = Get.find<DuplicateController>();
  final homeController = Get.find<HomeController>();
  final getContext = Get.context!;
  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarColor: duplicateController.colors.whiteColor));
    super.initState();
  }

  @override
  void dispose() {
    homeBloc?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BlocProvider(
      create: (context) {
        final bloc = HomeBloc(homeRepository: homeController.homeRepository);
        bloc.add(HomeStart());
        homeBloc = bloc;
        return bloc;
      },
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          final CustomColors colors = duplicateController.colors;
          final CustomTextStyle textStyle = duplicateController.textStyle;
          final ScrollPhysics physics =
              duplicateController.uiDuplicate.defaultScroll;
          if (state is HomeLoading) {
            return const CustomLoading();
          } else if (state is HomeSuccess) {
            final List<ProductEntity> productList = state.productList;
            final profileFunctions =
                Get.find<ProfileController>().profileFunctions;
            return Scaffold(
              backgroundColor: colors.primary,
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.white,
                centerTitle: true,
                title: SafeArea(child: logo),
                leading: CupertinoButton(
                  child: Icon(
                    Icons.menu,
                    color: colors.captionColor,
                  ),
                  onPressed: () {
                    showMenu(
                        color: colors.gray,
                        context: context,
                        position: RelativeRect.fill,
                        items: [
                          PopupMenuItem(
                              child: TextButton(
                            onPressed: () {
                              Get.back();
                              showLicensePage(context: context);
                            },
                            child: Text(
                              "Licensias sobre la aplicacion",
                              style: textStyle.bodyNormal,
                            ),
                          ))
                        ]);
                  },
                ),
                actions: [
                  CupertinoButton(
                    child: Icon(
                      Icons.search,
                      color: colors.whiteColor,
                    ),
                    onPressed: () {
                      Get.to(const SearchScreen());
                    },
                  )
                ],
              ),
              body: duplicateContainer(
                colors: colors,
                child: ListView.builder(
                  physics: physics,
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    switch (index) {
                      case 1:
                        return Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Colección de Autos",
                                style: textStyle.titleLarge.copyWith(
                                  overflow: TextOverflow.clip,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Encuentra tu auto ideal.",
                                style: textStyle.bodyNormal,
                              )
                            ],
                          ),
                        );
                      case 2:
                        return ProductListView(
                            colors: colors,
                            profileFunctions: profileFunctions,
                            reverse: false,
                            physics: physics,
                            textStyle: textStyle,
                            productList: productList,
                            callback: () {
                              Get.to(ShopScreen(
                                  title: "Ultimos Agregados",
                                  productList: productList));
                            },
                            title: "Lo Ultimo");

                      case 3:
                        return BannerListView(
                            callback: () {
                              Get.to(ShopScreen(
                                  title: "Top", productList: productList));
                            },
                            produtList: productList,
                            colors: colors,
                            textStyle: textStyle);
                      default:
                        return Container();
                    }
                  },
                ),
              ),
            );
          } else if (state is HomeError) {
            return AppException(
              callback: () {
                homeBloc!.add(HomeStart());
              },
            );
          }
          return Container();
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
