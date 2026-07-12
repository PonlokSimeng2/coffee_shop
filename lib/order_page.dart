import 'package:coffee_shop/checkout_screen.dart';
import 'package:flutter/material.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
        title: Text(
          "Your Order",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(child: _buildCardItem()),
          _buildCostSamary(),
          SizedBox(height: 10),
          _buildButton(),
          SizedBox(height: 15),
        ],
      ),
    );
  }

  _buildButton() {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CheckoutScreen()),
        );
      },
      child: Container(
        margin: EdgeInsets.all(13),
        height: 70,
        decoration: BoxDecoration(
          color: Color(0xFF462E2B),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: Text(
            "Proceed to Checkout",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCardItem() {
    return ListView.builder(
      itemCount: 2,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 210,
            decoration: BoxDecoration(
              color: Color(0xFF1C242E),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 16),
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: NetworkImage(
                              "https://images.unsplash.com/photo-1572442388796-11668a67e53d?w=400",
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Ice Latte",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Larg, Oat Milk,1 Pump Valatine",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                // fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "\$ 5.50",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              _buildIcon(Color(0xFF2A3038), Icons.remove),
                              SizedBox(width: 10),
                              Text(
                                "1",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: 10),
                              _buildIcon(Color(0xFF462E2B), Icons.add),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  height: 70,
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        width: 1,
                        color: const Color.fromARGB(255, 89, 85, 85),
                      ),
                    ),
                    color: Color(0xFF1C242E),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.edit, size: 20, color: Colors.white),
                          SizedBox(width: 5),
                          Text(
                            "Edit",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              // fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 20),
                      Row(
                        children: [
                          Icon(Icons.delete, size: 20, color: Colors.redAccent),
                          SizedBox(width: 5),
                          Text(
                            "Delete",
                            style: TextStyle(
                              color: Colors.redAccent,
                              fontSize: 20,
                              // fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCostSamary() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Text(
            "Cost Summary",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(20),
          height: 150,
          decoration: BoxDecoration(
            color: Color(0xFF1C242E),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              _buildRow("Subtitle", "\$13.00"),
              _buildRow("Taxes & Fees", "\$13.00"),
              Divider(height: 1, color: Colors.grey),
              _buildRow("Total", "\$13.00"),
            ],
          ),
        ),
      ],
    );
  }

  Row _buildRow(String title1, title2) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title1, style: TextStyle(color: Colors.white, fontSize: 20)),
        Text(title2, style: TextStyle(color: Colors.white, fontSize: 20)),
      ],
    );
  }

  Container _buildIcon(Color color, IconData icon) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      child: Icon(icon, size: 30, color: Colors.white),
    );
  }
}
