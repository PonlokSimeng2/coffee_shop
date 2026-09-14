import 'package:coffee_shop/page/detial_page.dart';
import 'package:coffee_shop/page/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

List coffeeShop = [
  {
    'name': 'Cappuccino',
    'price': 4.99,
    'description': 'Latte with coffee',
    'image':
        'https://d2lswn7b0fl4u2.cloudfront.net/photos/pg-recipes-cappuccino-1571757594559.jpg',
  },
  {
    'name': 'Latte',
    'price': 3.99,
    'description': 'Latte with coffee',
    'image':
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQCmWX1LO7HnhFs0nstyXRejpkzz12mwGFcGA&s',
  },
  {
    'name': 'Espresso',
    'price': 2.99,
    'description': 'Latte with coffee',
    'image':
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR3z2C8sKukKnAb5bM7UwNrrUWM0TXTyam-AQ&s',
  },
];

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    // ✅ Set once here, not inside build()
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness:
            Brightness.dark, // ✅ dark icons for white screen
        statusBarBrightness:
            Brightness.light, // ✅ dark icons for iOS white screen
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 25),
          _buildAppBar(),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [_buildBanner(), _buildList(), _buildCard()],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.brown[100],
      ),
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "Loyalty Point",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Spacer(),
              Text(
                "120/200",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.brown,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "80 point until you next cofee",
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 10),
          FractionallySizedBox(
            widthFactor: 1,
            child: LinearProgressIndicator(
              value: 0.6,
              backgroundColor: Colors.brown[200],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.brown),
              minHeight: 10,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildList() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Editor's Picks",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: coffeeShop.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetialPage(
                        imageUrl: coffeeShop[index]['image'],
                        title: coffeeShop[index]['name'],
                      ),
                    ),
                  );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Container(
                      margin: EdgeInsets.only(right: 10),
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        image: DecorationImage(
                          image: NetworkImage(coffeeShop[index]['image']),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Text(
                      "${coffeeShop[index]['name']}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "${coffeeShop[index]['description']}",
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildAppBar() {
    return SizedBox(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfilePage()),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.all(20),
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Colors.brown,
                    shape: BoxShape.circle,
                    image: const DecorationImage(
                      image: NetworkImage(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT7nstASo8BdadWs3X-ji8e1O0hd5AMByZdGQ&s',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.notification_add),
                onPressed: () {},
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Good Morning, Jane",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBanner() {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.brown,
        image: DecorationImage(
          image: NetworkImage(
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQjM0WY6xSUz8LuXD4rg002zPgZUHyWAKgeow&s',
          ),
          fit: BoxFit.cover,
        ),
      ),
      height: 300,
      width: double.infinity,
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Signatue Caramel Bliss",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "A perfect blend of smooth Expresso",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "A perfect blend of smooth Expresso",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 134, 81, 81),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text("Order Now", style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
