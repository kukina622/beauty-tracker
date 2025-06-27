// ignore_for_file: avoid_types_on_closure_parameters

import 'dart:async';

import 'package:beauty_tracker/models/product.dart';
import 'package:beauty_tracker/widgets/product/animated_product_card_wrapper.dart';
import 'package:beauty_tracker/widgets/product/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class AnimatedProductListController {
  AnimatedProductListController({
    required this.listKey,
    required this.products,
    required this.updateProducts,
  });
  final GlobalKey<SliverAnimatedListState> listKey;
  final List<Product> products;
  final void Function(List<Product>) updateProducts;
}

AnimatedProductListController useAnimatedProductList() {
  final listKey = useMemoized(() => GlobalKey<SliverAnimatedListState>(), []);
  final products = useState<List<Product>>([]);
  final isFirstUpdate = useRef(true);

  final updateProducts = useCallback((List<Product> newProducts) {
    // If the new products list is empty, just skip the animation
    if (isFirstUpdate.value) {
      isFirstUpdate.value = false;
      products.value = newProducts;
    } else {
      _updateAnimatedList(listKey, products.value, newProducts, products);
    }
  }, []);

  return AnimatedProductListController(
    listKey: listKey,
    products: products.value,
    updateProducts: updateProducts,
  );
}

Future<void> _updateAnimatedList(
  GlobalKey<SliverAnimatedListState> listKey,
  List<Product> oldProducts,
  List<Product> newProducts,
  ValueNotifier<List<Product>> productsNotifier,
) async {
  final listState = listKey.currentState;
  if (listState == null) {
    return;
  }

  const animationDuration = Duration(milliseconds: 350);

  final removeCompleter = Completer<void>();
  int removedCount = 0;
  final totalToRemove = oldProducts.length;

  if (totalToRemove == 0) {
    removeCompleter.complete();
  }

  for (int i = oldProducts.length - 1; i >= 0; i--) {
    final removedProduct = oldProducts[i];

    listState.removeItem(
      i,
      (context, animation) {
        animation.addStatusListener((status) {
          if (status == AnimationStatus.dismissed) {
            removedCount++;
            if (removedCount == totalToRemove) {
              removeCompleter.complete();
            }
          }
        });

        return AnimatedProductCardWrapper(
          animation: animation,
          isRemoving: true,
          child: ProductCard(
            product: removedProduct,
            isEditStatusMode: false,
          ),
        );
      },
      duration: animationDuration,
    );
  }

  productsNotifier.value = [];

  await removeCompleter.future;

  for (int i = 0; i < newProducts.length; i++) {
    listState.insertItem(i, duration: animationDuration);
  }

  productsNotifier.value = newProducts;
}
