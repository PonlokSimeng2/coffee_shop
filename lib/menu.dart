import 'package:flutter/material.dart';
import 'detail.dart';

class CoffeeShopMenu extends StatefulWidget {
  const CoffeeShopMenu({super.key});

  @override
  State<CoffeeShopMenu> createState() => _CoffeeShopMenuState();
}

class _CoffeeShopMenuState extends State<CoffeeShopMenu> {
  int _selectedCategoryIndex = 0;
  int _cartItemCount = 2;
  double _cartTotal = 8.25;

  final List<String> _categories = [
    'Espresso',
    'Brewed Coffee',
    'Signature',
    'Pastries',
    'Teas'
  ];

  final List<MenuItem> _menuItems = [
    MenuItem(
      name: 'Caramel Macchiato',
      description: 'Rich espresso with steamed milk and a sweet caramel drizzle.',
      price: 4.75,
      imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuCxr44u5TDL1Fafh7QcLAk6sbc24qz4teA_Y3Px_bdQI_3sx2DVVephe-RijllH3fA--z2nOLS4BDd08MtOVYXnIGqcosn05tJ9b5elwVprUnmim3PPqX2Myxe_q1pYrC4nPLyxdwxHBQ-z5PzqYMLnsMIZLE5SRGDYmMGhSj6kl3hnDVm_JDI6uMYyRLoVaC3KKU6S9Lhp9618sXLFPJb1njR1LZu1kq-4k0Tgl_ltqkPap4Lu5bxcoTtdw5jtPfbfVPtphFLhBkxX',
      category: 'Espresso',
    ),
    MenuItem(
      name: 'Americano',
      description: 'Espresso shots topped with hot water create a light layer of crema.',
      price: 3.25,
      imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuAuI0ZhEu312mZJkDdZtgA0hqcyOvJ1t7eiRlGiYn63WI2OLJqZvtTcFST9CybWR9qWNQZ56UB-0vMmN4grJFiqd1z-K3D6q5PX2FC02le-n48Pt89H-SMGHnDftqdyws9zdEYf_aXGEdblO73JpAwm3pKMcB17ZL3XF62n-eHMQy8qCrZIp6_kxG2sHWHAVkMSCNvlj1XJNL1hcs1DKVdCLwG44Pe8mk_TxRQXgOqsMj5ijMtpRZl-hS0f-DbgJYS4qPgy5EjRlbpx',
      category: 'Espresso',
    ),
    MenuItem(
      name: 'Cappuccino',
      description: 'Dark, rich espresso under a smoothed and stretched layer of thick milk foam.',
      price: 4.25,
      imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuBgyhLf7w5eBxyvxCzmSaxEyuoIzO7gH7Il-32g03J2mU0tLQanorLJDfvYhBihvYHb-PkF9nE3mTRXc9LcOUAh3sopxbA7SU3TZdMOO9CRZI6i2LiC3_i_PzaVBWSk_rtHfcvejpzm2vqpz1HRh6Snrn24UAdf_vtrHPhI9ejy2ErQ7NkMFzEvWbHTk0Sp1r3u3dNpEMcSBOKpcXzF5JFR0-fp8wTWA0wMWDbe5rUADgXN2xPTKw4PztTi_wvdDvu-gsfanGq7I-a4',
      category: 'Espresso',
    ),
    MenuItem(
      name: 'Classic Croissant',
      description: 'A flaky, buttery pastry, perfect with any coffee.',
      price: 3.50,
      imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuBWcW3eQLvgD0JcYaG6pOc3gKDfFSMj3352lpnm7VyE9yniseMEbTDgxs6wOCqbQ2zP83yy4bvkdEe1J3nwZbpmkD-HtiyajwM7VIV9InRfWjaC1Z17Hh0WvZy05Y9AlWFWWu98TPLWQ_BinnDog0hBftStbwfH9hWOvrX7aeMIDR4Q8xC6l-cLKQmFiZG1Pn2IxaXdFomooC6PgbIGPSqBVp8eg99QbQkkvnpMHwvO0ImIkT8b_mzgs-Z4rpDIEIEbmcng_SstIeGh',
      category: 'Pastries',
    ),
  ];

  List<MenuItem> get _filteredItems {
    return _menuItems.where((item) => item.category == _categories[_selectedCategoryIndex]).toList();
  }

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
              child: Column(
                children: [
                  // Search Bar
                  _buildSearchBar(),

                  // Category Tabs
                  _buildCategoryTabs(),

                  // Menu Items List
                  Expanded(
                    child: _buildMenuItemsList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // Bottom Navigation
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildCartFooter(),
          _buildBottomNavigation(),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.8),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              'Menu',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
          // Shopping Cart with Badge
          Stack(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/order');
                },
                icon: Icon(
                  Icons.shopping_cart,
                  size: 28,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              if (_cartItemCount > 0)
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        _cartItemCount.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark
              ? const Color(0xFF374151)
              : const Color(0xFFE5E7EB),
          borderRadius: BorderRadius.circular(28),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 8),
              child: Icon(
                Icons.search,
                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                size: 24,
              ),
            ),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search for coffee, pastries...',
                  hintStyle: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryTabs() {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).brightness == Brightness.dark
                ? const Color(0xFF374151)
                : const Color(0xFFE5E7EB),
            width: 1,
          ),
        ),
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final isSelected = index == _selectedCategoryIndex;
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedCategoryIndex = index;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              margin: const EdgeInsets.only(right: 24),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: isSelected
                        ? Theme.of(context).colorScheme.primary
                        : Colors.transparent,
                    width: 3,
                  ),
                ),
              ),
              child: Center(
                child: Text(
                  _categories[index],
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: isSelected
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMenuItemsList() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: _filteredItems.length,
      itemBuilder: (context, index) {
        final item = _filteredItems[index];
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CoffeeDetailPage(menuItem: item),
                    settings: const RouteSettings(name: '/detail'),
                  ),
                );
              },
              child: Row(
                children: [
              // Menu Item Image
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: NetworkImage(item.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 16),

              // Menu Item Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.description,
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '\$${item.price.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),

              // Add Button
              GestureDetector(
                onTap: () {
                  setState(() {
                    _cartItemCount++;
                    _cartTotal += item.price;
                  });
                },
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.add,
                    color: Theme.of(context).colorScheme.primary,
                    size: 24,
                  ),
                ),
              ),
              ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCartFooter() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            Theme.of(context).scaffoldBackgroundColor,
            Theme.of(context).scaffoldBackgroundColor.withValues(alpha: 0.8),
            Colors.transparent,
          ],
        ),
      ),
      child: SizedBox(
        height: 56,
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/order');
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(28),
            ),
            elevation: 8,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'View Cart',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '\$${_cartTotal.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavigation() {
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
          _buildNavItem(Icons.home, 'Home', 0, () {
            Navigator.pushReplacementNamed(context, '/');
          }),
          _buildNavItem(Icons.menu_book, 'Menu', 1, () {
            // Already on menu
          }),
          _buildNavItem(Icons.shopping_bag, 'Order', 2, () {
            Navigator.pushNamed(context, '/order');
          }),
          _buildNavItem(Icons.location_on, 'Locations', 3, () {
            Navigator.pushNamed(context, '/locations');
          }),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index, VoidCallback onTap) {
    final isSelected = index == 1; // Always select Menu when on menu page
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 28,
            color: isSelected
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: isSelected
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
            ),
          ),
        ],
      ),
    );
  }
}