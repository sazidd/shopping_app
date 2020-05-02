import 'package:flutter/material.dart';
import 'package:my_app/auth.dart';
import 'package:my_app/auth_screen.dart';
import 'package:my_app/product_overView_screen.dart';
import 'package:provider/provider.dart';

import 'cart.dart';
import 'cart_screen.dart';
import 'edit_product_screen.dart';
import 'order_screen.dart';
import 'orders.dart';
import 'product_details.dart';
import 'provider_product.dart';
import 'user_product_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Products>(
          create: null,
          update: (ctx, auth, previousProducts) => Products(
            auth.token,
            auth.userId,
            previousProducts == null ? [] : previousProducts.items,
          ),
        ),
        ChangeNotifierProvider.value(
          value: Cart(),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          create: null,
          update: (ctx, auth, previousOrders) => Orders(
            auth.token,
            previousOrders == null ? [] : previousOrders.orders,
          ),
        ),
      ],
      child: Consumer<Auth>(
          builder: (ctx, auth, _) => MaterialApp(
                  title: 'MyShop',
                  theme: ThemeData(
                    primarySwatch: Colors.purple,
                    accentColor: Colors.deepOrange,
                    fontFamily: 'Lato',
                  ),
                  home: auth.isAuth ? ProductsOverviewScreen() : AuthScreen(),
                  routes: {
                    ProductDetailScreen.routeName: (ctx) =>
                        ProductDetailScreen(),
                    CartScreen.routeName: (ctx) => CartScreen(),
                    OrdersScreen.routeName: (ctx) => OrdersScreen(),
                    UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
                    EditProductScreen.routeName: (ctx) => EditProductScreen(),
                  })),
    );
  }
}
