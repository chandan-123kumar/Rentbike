import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:rentbike/screen/item_detail.dart';
import 'package:rentbike/screen/login.dart';
import 'package:rentbike/screen/search.dart';

void main() {
  runApp(const MainApp());
}

const filters = ["All", "Scooty", "Sports", "Dirt", "New", "General"];

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rent Bike',
      theme: ThemeData(),
      home: const Home(),
      routes: {
        Login.routeName: (_) => const Login(),
        Search.routeName: (_) => const Search(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == ItemDetails.routeName) {
          final args = settings.arguments as ItemDetailsArgs;
          return MaterialPageRoute(
            builder: (context) {
              return ItemDetails(
                args: args,
              );
            },
          );
        }

        assert(false, 'Need to implement ${settings.name}');
        return null;
      },
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(slivers: [
          SliverAppBar(
            title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(Icons.menu),
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(Login.routeName);
                      },
                      icon: const Icon(Iconsax.user))
                ]),
            automaticallyImplyLeading: false,
            pinned: false,
          ),
          const SliverToBoxAdapter(
            child: Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  "Find your favorite\nmotorcycle!",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                )),
          ),
          SliverAppBar(
            automaticallyImplyLeading: false,
            title: GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(Search.routeName);
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
                child: const Text(
                  "Search",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            pinned: true,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
          ),
          SliverAppBar(
            titleSpacing: 0,
            automaticallyImplyLeading: false,
            title: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  const SizedBox(
                    width: 12,
                  ),
                  ...filters.map((title) => _buildFilter(title, false)).toList()
                ],
              ),
            ),
            pinned: true,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverGrid.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: MediaQuery.of(context).size.width > 640 ? 3 : 2,
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
                              const Row(
                                children: [
                                  Price(
                                    amount: "₹ 799",
                                    unit: "/d",
                                  ),
                                  SizedBox(width: 8),
                                  Price(
                                    amount: "₹ 89",
                                    unit: "/h",
                                  ),
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
              itemCount: 20,
            ),
          ),
        ]),
      ),
    );
  }
}

class Price extends StatelessWidget {
  final String amount;
  final String unit;
  const Price({super.key, required this.amount, required this.unit});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: amount,
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
          TextSpan(
            text: unit,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildFilter(String title, bool isActive) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
    decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(100)),
        color: Colors.grey.shade200,
        border: Border.all(
          color: isActive ? Colors.green : Colors.grey.shade300,
          width: 2,
        )),
    child: Text(
      title,
      style: const TextStyle(
        fontSize: 16,
      ),
    ),
  );
}
