import 'package:flutter/material.dart';

class OrderItem {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final String size;
  final String milk;
  final int sugarPumps;
  int quantity;
  final List<String> customizations;

  OrderItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.size = 'M',
    this.milk = 'Dairy',
    this.sugarPumps = 0,
    this.quantity = 1,
    this.customizations = const [],
  });

  double get totalPrice => price * quantity;

  OrderItem copyWith({
    String? id,
    String? name,
    String? description,
    double? price,
    String? imageUrl,
    String? size,
    String? milk,
    int? sugarPumps,
    int? quantity,
    List<String>? customizations,
  }) {
    return OrderItem(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      size: size ?? this.size,
      milk: milk ?? this.milk,
      sugarPumps: sugarPumps ?? this.sugarPumps,
      quantity: quantity ?? this.quantity,
      customizations: customizations ?? this.customizations,
    );
  }

  String get customizationsText {
    final parts = <String>[];
    if (size.isNotEmpty) parts.add(size);
    if (milk != 'Dairy') parts.add(milk);
    if (sugarPumps > 0) parts.add('$sugarPumps Pump${sugarPumps > 1 ? 's' : ''} Vanilla');
    if (customizations.isNotEmpty) parts.addAll(customizations);

    return parts.isNotEmpty ? parts.join(', ') : 'No customizations';
  }
}

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  List<OrderItem> _orderItems = [
    OrderItem(
      id: '1',
      name: 'Iced Latte',
      description: 'Rich espresso with steamed milk and a sweet caramel drizzle.',
      price: 5.50,
      imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuB-nC8VU74zR_Zdviq3uEw9o20221xnTGEYBI7PPBlwsiYN87DuN4U-qu75YlPpmfpqNdkCYuDhVhjvz3EstIhAN9lSLBT_7F3_13Fn5eXCF1uBPwUx9Q1uyUGjn0RmvATpwnfnJoghl1brUDMORQanKZxe0Lv79zolpxNKcgiB9bLsW9nq5Jwj2y5UMCt5xYiFmIuoJL36ptSBYDWm_wOFTkdzG6IelXykO0vpKiebu7LWmL3PovKO12w_RASkJPkPOGNmyQFtXT_0',
      size: 'Large',
      milk: 'Oat Milk',
      sugarPumps: 1,
      quantity: 1,
    ),
    OrderItem(
      id: '2',
      name: 'Almond Croissant',
      description: 'A flaky, buttery pastry, perfect with any coffee.',
      price: 3.75,
      imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuAp0nxMxNn4sjUdPHS47kbMdyapalCg5lkUh96Z16J4P2QyM9B1k8pugoe7S2NE6kHBSLgvIBd-IXwIQc58C0EfS8Xm68qqK_qHOqN-HDbefcP5HnjNqrHPmAUAhKkm2I0pMvozOXjLMnXDJYinN3jxQRZYn79MPV__3Ih5ibN-EokXSNaxdMrBW5G2sYu8Cp20WaacNzmZxYVl-m1yEB0ZmufQmYNJbOFSNDQlKVkfn0nM0nQbILPXjSJF2_sIXPXZBXbvzu1U0dmW',
      quantity: 2,
    ),
  ];

  double get subtotal {
    return _orderItems.fold(0, (sum, item) => sum + item.totalPrice);
  }

  double get taxesAndFees => subtotal * 0.0885; // 8.85% tax rate

  double get total => subtotal + taxesAndFees;

  void _updateQuantity(String itemId, int newQuantity) {
    setState(() {
      final index = _orderItems.indexWhere((item) => item.id == itemId);
      if (index != -1) {
        if (newQuantity <= 0) {
          _orderItems.removeAt(index);
        } else {
          _orderItems[index] = _orderItems[index].copyWith(quantity: newQuantity);
        }
      }
    });
  }

  void _removeItem(String itemId) {
    setState(() {
      _orderItems.removeWhere((item) => item.id == itemId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).scaffoldBackgroundColor,
              Theme.of(context).scaffoldBackgroundColor.withValues(alpha: 0.95),
            ],
          ),
        ),
        child: Column(
          children: [
            // Top App Bar
            _buildAppBar(),

            // Main Content
            Expanded(
              child: _orderItems.isEmpty ? _buildEmptyOrder() : _buildOrderContent(),
            ),
          ],
        ),
      ),
      // Fixed Footer
      bottomNavigationBar: _orderItems.isEmpty ? null : _buildCheckoutFooter(),
    );
  }

  Widget _buildAppBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(
              Icons.arrow_back,
              color: Theme.of(context).colorScheme.onSurface,
              size: 28,
            ),
          ),
          Expanded(
            child: Text(
              'Your Order',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
          const SizedBox(width: 48), // Balance the back button
        ],
      ),
    );
  }

  Widget _buildEmptyOrder() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_cart_outlined,
            size: 80,
            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.3),
          ),
          const SizedBox(height: 16),
          Text(
            'Your order is empty',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Add items from the menu to get started',
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pushReplacementNamed('/menu'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            child: const Text(
              'Browse Menu',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 160),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Order Items List
          _buildOrderItemsList(),

          const SizedBox(height: 32),

          // Cost Summary
          _buildCostSummary(),
        ],
      ),
    );
  }

  Widget _buildOrderItemsList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Order Items',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 16),
        ..._orderItems.map((item) => _buildOrderItemCard(item)),
      ],
    );
  }

  Widget _buildOrderItemCard(OrderItem item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Main item row
            Row(
              children: [
                // Item Image
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: NetworkImage(item.imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 16),

                // Item Details
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
                        item.customizationsText,
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '\$${item.price.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                ),

                // Quantity Controls
                _buildQuantityControls(item),
              ],
            ),

            // Action Buttons
            if (item.name.contains('Latte')) _buildItemActions(item),
          ],
        ),
      ),
    );
  }

  Widget _buildQuantityControls(OrderItem item) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Decrease button
        GestureDetector(
          onTap: () => _updateQuantity(item.id, item.quantity - 1),
          child: Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.dark
                  ? const Color(0xFF374151)
                  : const Color(0xFFF5F5F5),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.remove,
              size: 18,
              color: item.quantity > 1
                  ? Theme.of(context).colorScheme.onSurface
                  : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.4),
            ),
          ),
        ),

        // Quantity display
        SizedBox(
          width: 32,
          child: Center(
            child: Text(
              item.quantity.toString(),
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
        ),

        // Increase button
        GestureDetector(
          onTap: () => _updateQuantity(item.id, item.quantity + 1),
          child: Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.add,
              size: 18,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildItemActions(OrderItem item) {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.only(top: 12),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (item.name.contains('Latte')) ...[
            _buildActionButton(
              icon: Icons.edit,
              label: 'Edit',
              onPressed: () {
                // TODO: Navigate to edit screen
              },
              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
            ),
            const SizedBox(width: 24),
          ],
          _buildActionButton(
            icon: Icons.delete,
            label: 'Remove',
            onPressed: () => _removeItem(item.id),
            color: Colors.red,
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
    required Color color,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 18,
            color: color,
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCostSummary() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Cost Summary',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              _buildCostRow('Subtotal', '\$${subtotal.toStringAsFixed(2)}'),
              const SizedBox(height: 12),
              _buildCostRow('Taxes & Fees', '\$${taxesAndFees.toStringAsFixed(2)}'),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 16),
                height: 1,
                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.1),
              ),
              _buildCostRow('Total', '\$${total.toStringAsFixed(2)}', isBold: true),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCostRow(String label, String value, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            color: isBold
                ? Theme.of(context).colorScheme.onSurface
                : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
          ),
        ),
        Text(
          value,
          textAlign: TextAlign.right,
          style: TextStyle(
            fontSize: 14,
            fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ],
    );
  }

  Widget _buildCheckoutFooter() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.9),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SizedBox(
        height: 56,
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            // TODO: Navigate to checkout
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Proceeding to checkout...'),
                duration: Duration(seconds: 2),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(28),
            ),
            elevation: 8,
            shadowColor: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
          ),
          child: const Text(
            'Proceed to Checkout',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}