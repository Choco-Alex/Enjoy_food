import 'package:enjoy_food/models/food.dart';
import 'package:flutter/material.dart';

class FoodTile extends StatelessWidget {
  final Food food;
  final void Function()? onTap;
  const FoodTile({super.key, required this.food, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                // text food details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        food.name,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '\$' + food.price.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.green),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(food.description),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                // food image
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    food.imagepath,
                    height: 120,
                    width: 120,
                  ),
                ),
              ],
            ),
          ),
        ),
        Divider(
          color: Theme.of(context).colorScheme.tertiary,
          indent: 25,
          endIndent: 25,
        ),
      ],
    );
  }
}
