import 'package:flutter/material.dart';

class CoffeeLocation {
  final String id;
  final String name;
  final String address;
  final String city;
  final String state;
  final String zipCode;
  final String phone;
  final double distance;
  final String hours;
  final bool isOpen;
  final String imageUrl;
  final double latitude;
  final double longitude;
  final List<String> features;

  CoffeeLocation({
    required this.id,
    required this.name,
    required this.address,
    required this.city,
    required this.state,
    required this.zipCode,
    required this.phone,
    required this.distance,
    required this.hours,
    required this.isOpen,
    required this.imageUrl,
    required this.latitude,
    required this.longitude,
    this.features = const [],
  });

  String get fullAddress => '$address, $city, $state $zipCode';

  String get distanceText => '${distance.toStringAsFixed(1)} mi';

  String get statusText => isOpen ? 'Open Now' : 'Closed';

  Color get statusColor => isOpen ? Colors.green : Colors.red;
}

class LocationsPage extends StatefulWidget {
  const LocationsPage({super.key});

  @override
  State<LocationsPage> createState() => _LocationsPageState();
}

class _LocationsPageState extends State<LocationsPage> {
  final List<CoffeeLocation> _locations = [
    CoffeeLocation(
      id: '1',
      name: 'Downtown Coffee House',
      address: '123 Main Street',
      city: 'San Francisco',
      state: 'CA',
      zipCode: '94102',
      phone: '(415) 555-0123',
      distance: 0.8,
      hours: '6:00 AM - 9:00 PM',
      isOpen: true,
      imageUrl: 'https://images.unsplash.com/photo-1554118811-1e0d58224f24?w=400&h=300&fit=crop',
      latitude: 37.7749,
      longitude: -122.4194,
      features: ['WiFi', 'Drive-thru', 'Outdoor Seating'],
    ),
    CoffeeLocation(
      id: '2',
      name: 'Riverside Café',
      address: '456 Market Street',
      city: 'San Francisco',
      state: 'CA',
      zipCode: '94105',
      phone: '(415) 555-0456',
      distance: 1.2,
      hours: '7:00 AM - 8:00 PM',
      isOpen: true,
      imageUrl: 'https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?w=400&h=300&fit=crop',
      latitude: 37.7898,
      longitude: -122.3942,
      features: ['WiFi', 'Pet-friendly'],
    ),
    CoffeeLocation(
      id: '3',
      name: 'Hilltop Brew',
      address: '789 Pine Street',
      city: 'San Francisco',
      state: 'CA',
      zipCode: '94108',
      phone: '(415) 555-0789',
      distance: 2.3,
      hours: '6:30 AM - 7:00 PM',
      isOpen: false,
      imageUrl: 'https://images.unsplash.com/photo-1511920180054-f5e7e6b6c5a7?w=400&h=300&fit=crop',
      latitude: 37.7909,
      longitude: -122.4085,
      features: ['WiFi', 'Study Space', 'Pastries'],
    ),
    CoffeeLocation(
      id: '4',
      name: 'Harbor View Coffee',
      address: '321 Embarcadero',
      city: 'San Francisco',
      state: 'CA',
      zipCode: '94105',
      phone: '(415) 555-0321',
      distance: 3.1,
      hours: '5:30 AM - 10:00 PM',
      isOpen: true,
      imageUrl: 'https://images.unsplash.com/photo-1497515114629-f71d768fd14c?w=400&h=300&fit=crop',
      latitude: 37.7989,
      longitude: -122.3974,
      features: ['Drive-thru', '24-hour', 'Parking'],
    ),
  ];

  String _searchQuery = '';
  bool _showOnlyOpen = false;

  List<CoffeeLocation> get _filteredLocations {
    var filtered = _locations.where((location) {
      final matchesSearch = location.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
                           location.address.toLowerCase().contains(_searchQuery.toLowerCase()) ||
                           location.city.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesOpen = !_showOnlyOpen || location.isOpen;
      return matchesSearch && matchesOpen;
    }).toList();

    // Sort by distance
    filtered.sort((a, b) => a.distance.compareTo(b.distance));
    return filtered;
  }

  void _showLocationDetails(CoffeeLocation location) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(location.name),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Address: ${location.fullAddress}'),
            const SizedBox(height: 8),
            Text('Phone: ${location.phone}'),
            const SizedBox(height: 8),
            Text('Hours: ${location.hours}'),
            const SizedBox(height: 8),
            Text('Status: ${location.statusText}'),
            const SizedBox(height: 8),
            Text('Distance: ${location.distanceText}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showPhoneInfo(String phone) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Call $phone'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showDirectionsInfo(CoffeeLocation location) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Get directions to ${location.name}'),
        duration: const Duration(seconds: 2),
      ),
    );
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

            // Search and Filter Section
            _buildSearchAndFilter(),

            // Main Content
            Expanded(
              child: _filteredLocations.isEmpty
                  ? _buildEmptyState()
                  : _buildLocationsList(),
            ),
          ],
        ),
      ),
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
              'Locations',
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

  Widget _buildSearchAndFilter() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Search Bar
          Container(
            height: 56,
            decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.dark
                  ? const Color(0xFF374151)
                  : const Color(0xFFF3F4F6),
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
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Search locations...',
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

          const SizedBox(height: 12),

          // Filter Toggle
          Row(
            children: [
              Expanded(
                child: FilterChip(
                  label: const Text('Open Now Only'),
                  selected: _showOnlyOpen,
                  onSelected: (selected) {
                    setState(() {
                      _showOnlyOpen = selected;
                    });
                  },
                  backgroundColor: Theme.of(context).colorScheme.surface,
                  selectedColor: Theme.of(context).colorScheme.primary.withValues(alpha: 0.2),
                  checkmarkColor: Theme.of(context).colorScheme.primary,
                  labelStyle: TextStyle(
                    color: _showOnlyOpen
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.location_off_outlined,
            size: 80,
            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.3),
          ),
          const SizedBox(height: 16),
          Text(
            'No locations found',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try adjusting your search or filters',
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
            ),
          ),
          const SizedBox(height: 24),
          TextButton(
            onPressed: () {
              setState(() {
                _searchQuery = '';
                _showOnlyOpen = false;
              });
            },
            child: Text(
              'Clear filters',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationsList() {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      itemCount: _filteredLocations.length,
      itemBuilder: (context, index) {
        final location = _filteredLocations[index];
        return _buildLocationCard(location);
      },
    );
  }

  Widget _buildLocationCard(CoffeeLocation location) {
    return GestureDetector(
      onTap: () => _showLocationDetails(location),
      child: Container(
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Location Image
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Container(
              width: double.infinity,
              height: 180,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(location.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  // Status Badge
                  Positioned(
                    top: 12,
                    right: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: location.statusColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        location.statusText,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  // Distance Badge
                  Positioned(
                    bottom: 12,
                    right: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.7),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        location.distanceText,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Location Details
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name and Hours
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        location.name,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        location.hours,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                // Address
                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: 16,
                      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        location.fullAddress,
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 4),

                // Phone
                Row(
                  children: [
                    Icon(
                      Icons.phone_outlined,
                      size: 16,
                      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      location.phone,
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                      ),
                    ),
                  ],
                ),

                // Features
                if (location.features.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 4,
                    children: location.features.map((feature) {
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          feature,
                          style: TextStyle(
                            fontSize: 12,
                            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.8),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],

                const SizedBox(height: 16),

                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () => _showPhoneInfo(location.phone),
                        icon: const Icon(Icons.phone, size: 18),
                        label: const Text('Call'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.primary,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () => _showDirectionsInfo(location),
                        icon: const Icon(Icons.directions, size: 18),
                        label: const Text('Directions'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Theme.of(context).colorScheme.primary,
                          side: BorderSide(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
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
      ),
      ),
    );
  }
}