import 'package:coffee_shop/page/detial_page.dart';
import 'package:coffee_shop/page/order_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

final Map coffeeData = {
  'Espresso': [
    {
      'name': 'Caramel Macchiato',
      'description':
          'Rich espresso with steamed milk and a sweet caramel drizzle.',
      'price': 4.75,
      'image':
          'https://images.unsplash.com/photo-1572442388796-11668a67e53d?w=400',
    },
    {
      'name': 'Americano',
      'description':
          'Espresso shots topped with hot water create a light layer of crema.',
      'price': 3.25,
      'image':
          'https://images.unsplash.com/photo-1532004491497-ba35c367d634?w=400',
    },
    {
      'name': 'Cappuccino',
      'description':
          'Dark, rich espresso under a smoothed and stretched layer of thick milk foam.',
      'price': 4.25,
      'image':
          'https://images.unsplash.com/photo-1572442388796-11668a67e53d?w=400',
    },
  ],
  'Brewed Coffee': [
    {
      'name': 'Cold Brew',
      'description':
          'Coffee grounds steeped in cold water for 12-24 hours, resulting in a smooth brew.',
      'price': 4.25,
      'image':
          'https://images.unsplash.com/photo-1517487881594-2787fef5ebf7?w=400',
    },
    {
      'name': 'Pike Place Roast',
      'description': 'Our signature medium roast coffee with balanced flavor.',
      'price': 2.95,
      'image':
          'https://images.unsplash.com/photo-1509042239860-f550ce710b93?w=400',
    },
  ],
  'Signature': [
    {
      'name': 'Mocha',
      'description':
          'A chocolate-flavored variant of a caffè latte with espresso and chocolate.',
      'price': 5.00,
      'image':
          'https://images.unsplash.com/photo-1578314675249-a6910f80cc4e?w=400',
    },
    {
      'name': 'Caramel Frappuccino',
      'description':
          'Blended coffee with caramel and topped with whipped cream.',
      'price': 5.50,
      'image':
          'https://images.unsplash.com/photo-1572490122747-3968b75cc699?w=400',
    },
  ],
  'Pastries': [
    {
      'name': 'Classic Croissant',
      'description': 'Flaky, buttery, perfect with any coffee.',
      'price': 3.25,
      'image':
          'https://images.unsplash.com/photo-1555507036-ab1f4038808a?w=400',
    },
    {
      'name': 'Blueberry Muffin',
      'description': 'Moist muffin packed with fresh blueberries.',
      'price': 3.50,
      'image':
          'https://images.unsplash.com/photo-1607958996333-41aef7caefaa?w=400',
    },
  ],
};

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
    );
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          SizedBox(height: 50),
          _buildAppBar(),
          Expanded(child: _buildTabBar()),
          _buildCard(),
          SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildCard() => InkWell(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => OrderPage()),
      );
    },
    child: Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.symmetric(horizontal: 16),
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Color(0xFFC2692E),
      ),
      child: Row(
        children: [
          Text(
            "View Cart",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          Spacer(),
          Text(
            "\$ 8.25",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ],
      ),
    ),
  );
  Widget _buildAppBar() => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Column(
      children: [
        Row(
          children: [
            Text(
              "Menu",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            Stack(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                Positioned(
                  right: 4,
                  top: 4,
                  child: Container(
                    height: 25,
                    width: 25,
                    decoration: BoxDecoration(
                      color: Color(0xFFC1692E),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        "2",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        TextField(
          cursorColor: Colors.white,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.search, color: Colors.white, size: 30),
            hintText: 'Search for Coffee, Pattries....',
            hintStyle: TextStyle(color: Colors.white70, fontSize: 16),
            filled: true,
            fillColor: Color(0xFF27272A),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
          ),
        ),
      ],
    ),
  );
  final coffeeDataKey = coffeeData.keys.toList();
  Widget _buildTabBar() {
    return DefaultTabController(
      length: coffeeDataKey.length,
      child: Column(
        children: [
          TabBar(
            unselectedLabelColor: Colors.white,
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            labelColor: Color(0xFFC1692E),
            indicatorColor: Color(0xFFC1692E),
            tabs: List.generate(coffeeDataKey.length, (coffeeDataKeyindex) {
              return Tab(text: coffeeDataKey[coffeeDataKeyindex]);
            }),
          ),
          Expanded(
            child: TabBarView(
              children: List.generate(coffeeDataKey.length, (
                coffeeDataKeyViewIndex,
              ) {
                final coffeeDatacoffeeData =
                    coffeeDataKey[coffeeDataKeyViewIndex];
                final itemIndex = coffeeData[coffeeDatacoffeeData];
                return ListView.builder(
                  padding: EdgeInsets.only(top: 16),
                  itemCount: itemIndex.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        leading: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetialPage(
                                  imageUrl: itemIndex[index]['image']
                                      .toString(),
                                  title: itemIndex[index]['name'].toString(),
                                ),
                              ),
                            );
                          },
                          child: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: NetworkImage(
                                  itemIndex[index]['image'].toString(),
                                ),
                              ),
                            ),
                          ),
                        ),
                        subtitle: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetialPage(
                                  imageUrl: itemIndex[index]['image']
                                      .toString(),
                                  title: itemIndex[index]['name'].toString(),
                                ),
                              ),
                            );
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                itemIndex[index]['name'].toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                itemIndex[index]['description'].toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                "\$ ${itemIndex[index]['price'].toString()}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                        trailing: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFF3F2816),
                          ),
                          child: Icon(
                            Icons.add,
                            color: Color(0xFFC1692E),
                            size: 20,
                          ),
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
