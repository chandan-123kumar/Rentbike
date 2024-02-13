import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:rentbike/main.dart';
import 'package:rentbike/screen/item_detail.dart';

class Search extends StatefulWidget {
  static const String routeName = "/search";
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final _search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                children: [
                  TextField(
                    decoration: InputDecoration(
                        hintText: "Search",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey.shade50,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: const EdgeInsets.only(left: 44)),
                    controller: _search,
                    autofocus: true,
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(Icons.arrow_back),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      onPressed: () {
                        _search.clear();
                      },
                      icon: Icon(Icons.close),
                    ),
                  )
                ],
              ),
            ),
            Flexible(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount:
                      MediaQuery.of(context).size.width > 640 ? 3 : 2,
                  //   maxCrossAxisExtent:
                  //       _size.height > _size.width ? _size.width / 2 : _size.height / 2,
                  childAspectRatio: 1 / 1.5,
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 4,
                ),
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      ItemDetails.routeName,
                      arguments: ItemDetailsArgs(
                        id: "ItemImage$index",
                      ),
                    );
                  },
                  child: Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(8),
                      ),
                      side: BorderSide(
                        width: 1,
                        color: Colors.grey.shade300,
                      ),
                    ),
                    child: Stack(alignment: Alignment.topRight, children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Iconsax.heart),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Hero(
                              tag: "ItemImage$index",
                              child: Image.network(
                                "https://static.vecteezy.com/system/resources/previews/027/232/253/original/sports-motorbike-sports-bike-sports-motorbike-transparent-background-ai-generated-free-png.png",
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "BMW R7 800 CC",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Price(amount: "₹ 899", unit: "/d"),
                                    const SizedBox(width: 8),
                                    Price(amount: "₹ 89", unit: "/h"),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ]),
                  ),
                ),
                itemCount: 30,
              ),
            )
          ],
        ),
      ),
    );
  }
}
