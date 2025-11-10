import 'package:flutter/material.dart';

class CoffeeDetailPage extends StatefulWidget {
  final MenuItem menuItem;

  const CoffeeDetailPage({
    super.key,
    required this.menuItem,
  });

  @override
  State<CoffeeDetailPage> createState() => _CoffeeDetailPageState();
}

class _CoffeeDetailPageState extends State<CoffeeDetailPage> {
  String _selectedSize = 'S';
  String _selectedMilk = 'Dairy';
  int _sugarCount = 2;

  final List<String> _sizes = ['S', 'M', 'L'];
  final List<String> _milkOptions = ['Dairy', 'Almond', 'Oat'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
        children: [
          // Main Content
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Image
                _buildHeaderImage(),
                // Main Content Area
                Container(
                  padding: const EdgeInsets.fromLTRB(16, 24, 16, 120), // Extra bottom padding for fixed button
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Headline and Price
                      _buildHeadlineAndPrice(),

                      // Description
                      _buildDescription(),

                      const SizedBox(height: 24),

                      // Customization Section
                      _buildCustomizationSection(),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Top App Bar with Back and Favorite buttons
          

          // Fixed Bottom Bar with Add to Order button
          _buildBottomActionBar(),
        ],
      ),
    );
  }

  Widget _buildHeaderImage() {
    return Container(
      width: double.infinity,
      height: 384, // h-96 = 24rem = 384px
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(widget.menuItem.imageUrl),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildTopAppBar() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Back Button
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.4),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ),

            // Favorite Button
            GestureDetector(
              onTap: () {
                // TODO: Add to favorites functionality
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Added to favorites!'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.4),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.favorite_border,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeadlineAndPrice() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              widget.menuItem.name,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface,
                letterSpacing: -0.5,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Text(
            '\$${widget.menuItem.price.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
              letterSpacing: -0.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescription() {
    return Text(
      'A perfect blend of rich espresso, steamed milk, and a sweet caramel drizzle. Our signature espresso is layered with creamy milk and topped with a buttery caramel sauce for a deliciously smooth finish.',
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
        height: 1.5,
      ),
    );
  }

  Widget _buildCustomizationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),

        // Size Options
        _buildSizeOptions(),

        const SizedBox(height: 24),

        // Milk Options
        _buildMilkOptions(),

        const SizedBox(height: 24),

        // Sweeteners
        _buildSweeteners(),
      ],
    );
  }

  Widget _buildSizeOptions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Size',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: _sizes.map((size) {
            final isSelected = size == _selectedSize;
            return Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  right: size != _sizes.last ? 12 : 0,
                ),
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _selectedSize = size;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isSelected
                        ? Theme.of(context).colorScheme.primary.withValues(alpha: 0.2)
                        : Colors.transparent,
                    foregroundColor: isSelected
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
                    side: BorderSide(
                      color: isSelected
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.3),
                      width: 2,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    elevation: 0,
                  ),
                  child: Text(
                    size,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildMilkOptions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Milk',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: _milkOptions.map((milk) {
            final isSelected = milk == _selectedMilk;
            return Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  right: milk != _milkOptions.last ? 12 : 0,
                ),
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _selectedMilk = milk;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isSelected
                        ? Theme.of(context).colorScheme.primary.withValues(alpha: 0.2)
                        : Colors.transparent,
                    foregroundColor: isSelected
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
                    side: BorderSide(
                      color: isSelected
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.3),
                      width: 2,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    elevation: 0,
                  ),
                  child: Text(
                    milk,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildSweeteners() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Sweeteners',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.dark
                ? const Color(0xFF1F2937)
                : const Color(0xFFF3F4F6),
            borderRadius: BorderRadius.circular(50),
          ),
          child: Row(
            children: [
              // Sugar label
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Text(
                    'Sugar',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ),
              ),

              // Quantity Controls
              Row(
                children: [
                  // Minus Button
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? const Color(0xFF374151)
                          : Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () {
                          setState(() {
                            if (_sugarCount > 0) _sugarCount--;
                          });
                        },
                        child: Icon(
                          Icons.remove,
                          color: _sugarCount > 0
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
                          size: 24,
                        ),
                      ),
                    ),
                  ),

                  // Count Display
                  SizedBox(
                    width: 32,
                    child: Center(
                      child: Text(
                        _sugarCount.toString(),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    ),
                  ),

                  // Plus Button
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? const Color(0xFF374151)
                          : Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () {
                          setState(() {
                            _sugarCount++;
                          });
                        },
                        child: const Icon(
                          Icons.add,
                          color: Color(0xFFd47311),
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBottomActionBar() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor.withValues(alpha: 0.8),
          border: Border(
            top: BorderSide(
              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.1),
              width: 1,
            ),
          ),
        ),
        child: SizedBox(
          width: double.infinity,
          height: 64,
          child: ElevatedButton(
            onPressed: () {
              // Show confirmation and navigate back
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Added to order!'),
                  duration: Duration(seconds: 2),
                ),
              );
              // Navigate back after a short delay to show the snackbar
              Future.delayed(const Duration(milliseconds: 500), () {
                if (mounted) {
                  Navigator.of(context).pop();
                }
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFd47311),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              elevation: 8,
              shadowColor: const Color(0xFFd47311).withValues(alpha: 0.3),
            ),
            child: const Text(
              'Add to Order',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MenuItem {
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final String category;

  MenuItem({
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.category,
  });
}