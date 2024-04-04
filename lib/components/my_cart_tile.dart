import 'package:enjoy_food/components/my_quantity_selected.dart';
import 'package:enjoy_food/models/cart_item.dart';
import 'package:enjoy_food/models/restaurant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyCartTile extends StatelessWidget {
  final CartItem cartItem;

  const MyCartTile({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    return Consumer<Restaurant>(
      builder: (context, restaurant, child) => Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // food image
                ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      cartItem.food.imagepath,
                      height: 120,
                      width: 120,
                    )),

                const SizedBox(
                  width: 10,
                ),

                // name and price
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // food name
                    Text(cartItem.food.name),

                    // food price
                    Text('\$' + cartItem.food.price.toString()),
                    const SizedBox(
                      height: 10,
                    ),
                    // increment or decrement quantity
                    QuantitySelector(
                        quantity: cartItem.quantity,
                        food: cartItem.food,
                        onDecrement: () {
                          restaurant.removeFromCart(cartItem);
                        },
                        onIncrement: () {
                          restaurant.addToCart(
                              cartItem.food, cartItem.selectedAddons);
                        })
                  ],
                ),
              ],
            ),

            // addons
            SizedBox(
              height: cartItem.selectedAddons.isEmpty ? 0 : 50,
              child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding:
                      const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  children: cartItem.selectedAddons
                      .map(
                        (addon) => Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: FilterChip(
                            label: Row(
                              children: [
                                // addon name
                                Text(addon.name),

                                // addon price
                                Text('(\$${addon.price})'),
                              ],
                            ),
                            shape: StadiumBorder(
                              side: BorderSide(
                                  color: Theme.of(context).colorScheme.primary),
                            ),
                            onSelected: (value) {},
                            backgroundColor:
                                Theme.of(context).colorScheme.secondary,
                            labelStyle: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: 12),
                          ),
                        ),
                      )
                      .toList()),
            )
          ],
        ),
      ),
    );
  }
}
