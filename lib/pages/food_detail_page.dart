import 'package:enjoy_food/components/my_button.dart';
import 'package:enjoy_food/models/food.dart';
import 'package:enjoy_food/models/restaurant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FoodDetailPage extends StatefulWidget {
  final Food food;
  final Map<Addon, bool> selectedAddons = {};
  FoodDetailPage({super.key, required this.food}) {
    // initialise selected addons to be false
    for (Addon addon in food.availableAddons) {
      selectedAddons[addon] = false;
    }
  }

  @override
  State<FoodDetailPage> createState() => _FoodDetailPageState();
}

class _FoodDetailPageState extends State<FoodDetailPage> {
  // method to add to cart
  void addToCart(Food food, Map<Addon, bool> selectedAddons) {
    // close the current food page to go back to menu
    Navigator.pop(context);

    // format the selected addons
    List<Addon> currentlySelectedAddons = [];
    for (Addon addon in widget.food.availableAddons) {
      if (widget.selectedAddons[addon] == true) {
        currentlySelectedAddons.add(addon);
      }
    }

    // add to cart
    context.read<Restaurant>().addToCart(food, currentlySelectedAddons);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      // scaffold UI
      Scaffold(
        appBar: AppBar(),
        body: Container(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Column(
                children: [
                  //food image

                  Image.asset(
                    widget.food.imagepath,
                  ),

                  // food name
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20.0,
                      top: 20,
                      right: 20,
                    ),
                    child: Column(
                      children: [
                        Text(
                          widget.food.name,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),

                        // food price

                        Text(
                          '\$' + widget.food.price.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.green,
                          ),
                        ),

                        SizedBox(
                          height: 10,
                        ),

                        // food description
                        Text(
                          widget.food.description,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Theme.of(context).colorScheme.primary),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Divider(color: Theme.of(context).colorScheme.secondary),
                        const SizedBox(
                          height: 10,
                        ),

                        // addons

                        Text(
                          "Add-Ons",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.green),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                              borderRadius: BorderRadius.circular(8)),
                          child: ListView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            itemCount: widget.food.availableAddons.length,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              // get individual addon
                              Addon addon = widget.food.availableAddons[index];

                              // return check box UI
                              return CheckboxListTile(
                                  title: Text(addon.name),
                                  subtitle: Text(
                                    '\$' + addon.price.toString(),
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary),
                                  ),
                                  value: widget.selectedAddons[addon],
                                  onChanged: (bool? value) {
                                    setState(() {
                                      widget.selectedAddons[addon] = value!;
                                    });
                                  });
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  // button add to cart
                  MyButton(
                      text: "Add to cart",
                      onTap: () =>
                          addToCart(widget.food, widget.selectedAddons))
                ],
              ),
            ),
          ),
        ),
      ),

      // back button
      SafeArea(
        child: Container(
          margin: EdgeInsets.only(left: 18),
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              shape: BoxShape.circle),
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios_rounded),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      )
    ]);
  }
}
