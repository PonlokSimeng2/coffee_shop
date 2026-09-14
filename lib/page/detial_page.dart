import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DetialPage extends StatefulWidget {
  final String imageUrl;
  final String title;
  const DetialPage({super.key, required this.imageUrl, required this.title});

  @override
  State<DetialPage> createState() => _DetialPageState();
}

class _DetialPageState extends State<DetialPage> {
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
          SizedBox(height: 40),
          _buildAppBar(),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  _buildBannerImage(),
                  SizedBox(height: 20),
                  _buildSize(),
                  SizedBox(height: 20),
                  _buildMilk(),
                  SizedBox(height: 20),
                  _buildSweettensers(),
                  SizedBox(height: 20),
                  Divider(thickness: 2, color: Colors.white30),
                  SizedBox(height: 20),
                  _buildButtonOrder(),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButtonOrder() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      margin: EdgeInsets.symmetric(horizontal: 16),
      height: 70,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xFFC6782F),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Center(
        child: Text(
          "Add to Order",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar() => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Row(
      children: [
        InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        Spacer(),
        Icon(Icons.favorite_border, color: Colors.white, size: 30),
      ],
    ),
  );
  Widget _buildBannerImage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 350,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(widget.imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Row(
          children: [
            Text(
              widget.title,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            Spacer(),
            Text(
              "\$ 4.75",
              style: TextStyle(
                color: Color(0xFFC2692E),
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
          ],
        ),
        Text(
          "Moist muffin packed with fresh blueberries. Moist muffin packed with fresh blueberries.Moist muffin packed with fresh blueberries.",
          style: TextStyle(color: Colors.white, fontSize: 15),
        ),
      ],
    );
  }

  Widget _buildSize() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Size",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildSizeButton('S', true),
              _buildSizeButton('M', false),
              _buildSizeButton('L', false),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMilk() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Milk",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildSizeButton('Diary', true),
              _buildSizeButton('Almond', false),
              _buildSizeButton('Oat', false),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSweettensers() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Sweeteners",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            height: 60,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color(0xFF323947),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Text(
                    "Sugar",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Spacer(),
                  Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                      color: Color(0xFF364154),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Icon(Icons.remove, color: Colors.white),
                    ),
                  ),
                  SizedBox(width: 8),
                  Text(
                    "2",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(width: 8),
                  Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                      color: Color(0xFF364154),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Icon(Icons.add, color: Color(0xFFC2692E)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSizeButton(String text, bool isSelected) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      height: 55,
      width: 130,
      decoration: BoxDecoration(
        color: isSelected ? Color(0xFF412C14) : Colors.black12,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          width: 2,
          color: isSelected ? Color(0xFFC2692E) : Color(0xFF323947),
        ),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isSelected ? Color(0xFFC2692E) : Colors.white54,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
