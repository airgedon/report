import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http_practice/presentation/bloc/clothes_cubit.dart';
import 'package:http_practice/presentation/screens/home_screen/model/product.dart';
import 'package:http_practice/presentation/screens/home_screen/widget/cart_grid_widget.dart';
import 'package:http_practice/presentation/screens/home_screen/widget/drawer_widget.dart';
import 'package:http_practice/presentation/screens/home_screen/widget/shimmer_loading_widget.dart';
import 'package:http_practice/presentation/screens/home_screen/widget/shopping_cart_icon_widget.dart';

import 'package:http_practice/core/constant/string.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String dropDownValue = 'Сортировать';

  var key = Category.MEN_S_CLOTHING;

  final Map<String, dynamic> categoryItems = {
    'Сортировать': Category.ALL,
    'Мужская одежда': Category.MEN_S_CLOTHING,
    'Ювелирная': Category.JEWELERY,
    'Электроника': Category.ELECTRONICS,
    'Женская одежда': Category.WOMEN_S_CLOTHING,
  };

  final items = <String>{
    'Сортировать',
    'Мужская одежда',
    'Ювелирная',
    'Электроника',
    'Женская одежда',
  };

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: const Color.fromRGBO(251, 250, 245, 1),
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.black),
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: const [
              Padding(
                  padding: EdgeInsets.only(right: 10, top: 5),
                  child: ShoppingCartWidget())
            ],
            title: const Text(
              Strings.homeScreenAppBarTitle,
              style: TextStyle(color: Colors.black87),
            ),
          ),
          drawer: const DrawerWidget(),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Container(
                        width: 150,
                        height: 40,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(12)),
                        child: Center(
                          child: DropdownButton<String>(
                            dropdownColor: Colors.white,
                            elevation: 5,
                            underline: const SizedBox(),
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                            iconEnabledColor: Colors.black,
                            alignment: Alignment.center,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(12)),
                            icon: Transform.translate(
                              offset: const Offset(-2, 0),
                              child: const Icon(
                                Icons.keyboard_arrow_down_rounded,
                                size: 26,
                              ),
                            ),
                            value: dropDownValue,
                            items: items.map((String e) {
                              return DropdownMenuItem<String>(
                                child: Text(
                                  e,
                                  textAlign: TextAlign.left,
                                ),
                                alignment: Alignment.centerLeft,
                                value: e,
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              BlocProvider.of<ClothesCubit>(context)
                                  .sortAllProduct(categoryItems[newValue]!);
                              setState(() {
                                dropDownValue = newValue!;
                              });
                            },
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Center(child: BlocBuilder<ClothesCubit, ClothesState>(
                    builder: (context, state) {
                      if (state is ClothesLoading) {
                        final double itemHeight =
                            MediaQuery.of(context).size.height / 4.7;
                        final double itemWidth =
                            MediaQuery.of(context).size.width / 3.3;
                        return GridView.builder(
                            addAutomaticKeepAlives: true,
                            shrinkWrap: true,
                            //physics: const BouncingScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    childAspectRatio: (itemWidth / itemHeight),
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 4,
                                    crossAxisSpacing: 4),
                            itemCount: 6,
                            itemBuilder: (context, index) {
                              return const ShimmerLoadingWidget();
                            });
                      } else if (state is ClothesError) {
                        return const Text('Something get wrong');
                      } else if (state is ClothesNoInternet) {
                        return const Center(
                          child: Text(
                            'No internet connection',
                            style: TextStyle(fontSize: 20),
                          ),
                        );
                      } else if (state is ClothesLoaded) {
                        final product = state.product;
                        return GridCart(
                          product: product.map((e) => e).toList(),
                        );
                      }
                      return const SizedBox();
                    },
                  )),
                ),
              ],
            ),
          )),
    );
  }

  sortProduct(String value) {
    switch (value) {
      case 'Men\'s clothing':
    }
  }
}
