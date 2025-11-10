import 'package:flutter/material.dart';
import 'detail.dart';

class CoffeeShopHome extends StatefulWidget {
  const CoffeeShopHome({super.key});

  @override
  State<CoffeeShopHome> createState() => _CoffeeShopHomeState();
}

class _CoffeeShopHomeState extends State<CoffeeShopHome> {
  final List<MenuItem> _editorPicks = [
    MenuItem(
      name: 'Matcha Latte',
      description: 'Smooth & Creamy',
      price: 4.25,
      imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuCiY571vILUMB5vqk2CeRCg05bToJiOnnUzPAFn-Dl2ya3Atge6X1LUfapBWN3mc1xBU9-V2HzFIQ7-7tVW7N2v1pNYfMR-X0ya1yst1RTVj7znG1GIhbMcK8U-yB5irqljkM3lBc9IQCSLEM6zWkxctnS5PMKX4BWIC-f8RYt6iTNlOGjUwjRfLe46QCF3jhmvv4xl5AmgKm2bYeOUpxUCObBUOR96HtvZAenYGUeNiUoMyTLSGZB75kLW8fOPyXYkUTk8Ewpj2sv-',
      category: 'Teas',
    ),
    MenuItem(
      name: 'Butter Croissant',
      description: 'Freshly Baked',
      price: 3.50,
      imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuDJH_FAClN3xIpDNJe79horkmnZfP86XO_hukCpzli23vjKDO-9daMgarquM_NrJYJ0VLo86HN-h-byrzt7hwnf3IOXsoIQY7sQJ7d1njCkJUSPczVXl88Vmmm6oq_mFMWXbv_CTuBso9ptc2EuVYRNg-gCPktPgGFvqpdDgk7-nDQ_TGLppTb2JxfaPrbhuhyaAFsJ6Xk_AyO-3vz0x1s3qSFBjTch4wFLHqGldyd4Kip2CCsOBG2wQ5Et9rZ0_MULcV5cxJkwlAi8',
      category: 'Pastries',
    ),
    MenuItem(
      name: 'Iced Macchiato',
      description: 'Sweet & Bold',
      price: 5.25,
      imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuCOUS06D2BR3-acT_gOXn4dTyrvr9a_Yz9YJiR9a-M5JhX8UAaSjEaSMFKGYEcOC2y-2baxMrR-yaWojt0dGnb8FLz9dPoIM0c_xOkz2HL9Yo2gZPPMeUdEn_NpH1lzw5V5jxOCN90EeTAVNVUT1ILJZn8iC0ly0g6bH_8J-L036Sdi6ePhIthRx0BOHTZiXV7jy9bCUbY6uYA9jJv4qnaddNFwL-cF-HtvXzlSNdBSXYupXwe1q_fzJTLOlYe9B0S1Gjo_FCz-l9JI',
      category: 'Espresso',
    ),
    MenuItem(
      name: 'Chocolate Cake',
      description: 'Decadent & Rich',
      price: 5.75,
      imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuAuyZV1EtU50efri4JnaOaX6HlR3BCuIGL_gsWZKONYKysrtJNLUmVgZ0QrJR19DsV-falsoXVG_Hacz_oA-2jEPVnsE0uRTzLmW4X6U1RYG_N58n48bwpnoSlUz7PS5n5kbQnjC2cngXypTGU7NhE6sBhvVJF6ETOidmJIKsaLkCqzZFjW_rUDA0sspT739vJrbb0_YLDCJgpZ_UXom7x7r6x33Pq6zKWiUpTlBAwPHvhXKgKeLgxFV-qnTJWvpR1MIUX-xmdqmKCk',
      category: 'Pastries',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Top App Bar
            _buildAppBar(),

            // Main Content
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeroBanner(),
                    _buildEditorPicksSection(),
                    _buildLoyaltyCard(),
                    const SizedBox(height: 100), // Space for bottom nav
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigation(context),
    );
  }

  Widget _buildAppBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              // Profile Picture
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(
                      'https://lh3.googleusercontent.com/aida-public/AB6AXuBx5jHB83qfnd88lAX8AriM3tNZ2xUpg6YkACI2Ii-mVYyB__oGVewXTL9e9TN1rF7Dx_7XjJQScqlnMO7l460y2dw1lhT31jFydN6Cap15Ll3inK7vtqhdBFxcerfNqYP95-YcJZGNJps5BwUjnQ7l4LKud3kYNzyhESkv9Zh9gtFw3T6lHrP-LOdxupalqbaTJqQx2sQnmFFlOQDGNXgU92cu7CJJL5GsxDgKki9kgcVJIEY9E97EVGpK8HxeTp7xAGuIckH5gpK1',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const Spacer(),
              // Notifications
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.notifications_outlined),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Good morning, Jane',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4A2C2A),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroBanner() {
    return Container(
      margin: const EdgeInsets.all(16),
      height: 320,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          image: NetworkImage(
            'https://lh3.googleusercontent.com/aida-public/AB6AXuBfzAMytHIhQbkUj4Nsb6Rq5kEYH1pBOfrQZIO9aHr_4YRCTll8_CRplaHDUUDy2EMTm0m_AdSdEOY7hH5g4o_p7ZiMOE5mlrdVjGV5pyOQY6cd_U4VqmDqBMxS8dwdnPh_36xQiMhgK0ZRg1JTQZd-nxMMNF189nZjBRnr2L9bz-xAYQ-CwlBpfe0ZAYDM8syB1bT3djtkVue-QZLUNd_WSqfW55MjVSv8s1DKRIyUjDGaY7XN2iIpzdMAou1g60uG5jqVtBWGfbfM',
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          // Gradient Overlay
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withValues(alpha: 0.6),
                ],
              ),
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Signature Caramel Bliss',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'A perfect blend of smooth espresso, creamy milk, and rich caramel.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: 120,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFC69F74),
                      foregroundColor: const Color(0xFF4A2C2A),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Order Now',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEditorPicksSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            "Editor's Picks",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF4A2C2A),
            ),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 220,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: _editorPicks.length,
            itemBuilder: (context, index) {
              final item = _editorPicks[index];
              return Container(
                width: 160,
                margin: const EdgeInsets.only(right: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                            image: NetworkImage(item.imageUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      item.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF4A2C2A),
                      ),
                    ),
                    Text(
                      item.description,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF755957),
                      ),
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

  Widget _buildLoyaltyCard() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? const Color(0xFF2E2317)
            : Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Loyalty Points',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4A2C2A),
                ),
              ),
              Text(
                '120 / 200',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFC69F74),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            '80 points until your next free coffee!',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF755957),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            height: 10,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Theme.of(context).brightness == Brightness.dark
                  ? const Color(0xFF221a10)
                  : const Color(0xFFF5F0E6),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: 0.6,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: const Color(0xFFC69F74),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigation(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? const Color(0xFF2E2317).withValues(alpha: 0.8)
            : Colors.white.withValues(alpha: 0.8),
        border: Border(
          top: BorderSide(
            color: Colors.black.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(context, Icons.home, 'Home', 0, () {
            // Already on home
          }),
          _buildNavItem(context, Icons.menu_book, 'Menu', 1, () {
            Navigator.pushNamed(context, '/menu');
          }),
          _buildNavItem(context, Icons.shopping_bag, 'Order', 2, () {
            // TODO: Navigate to order page
          }),
          _buildNavItem(context, Icons.location_on, 'Locations', 3, () {
            Navigator.pushNamed(context, '/locations');
          }),
        ],
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, IconData icon, String label, int index, VoidCallback onTap) {
    final isSelected = index == 0; // Always select Home when on home page
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 28,
            color: isSelected
                ? const Color(0xFFC69F74)
                : const Color(0xFF755957),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: isSelected
                  ? const Color(0xFFC69F74)
                  : const Color(0xFF755957),
            ),
          ),
        ],
      ),
    );
  }
}