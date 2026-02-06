import 'package:flutter/material.dart';

class SavedLocationPage extends StatefulWidget {
  const SavedLocationPage({super.key});

  @override
  State<SavedLocationPage> createState() => _SavedLocationPageState();
}

class _SavedLocationPageState extends State<SavedLocationPage> {
  // Toggle this to switch states for testing
  final bool _hasLocations = true;

  final List<Map<String, String>> _dummyLocations = [
    {
      'type': 'Home',
      'address': 'Sardar patel road chennai,\nTamilNadu.',
      'icon': 'assets/images/home_icon_placeholder.png',
    },
    {
      'type': 'Work',
      'address': 'Pachaiyamman Nagar,\nPallavaram, Chennai.',
      'icon': 'assets/images/work_icon_placeholder.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5), // Light grey background
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Center(
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  size: 18,
                  color: Colors.black,
                ),
                onPressed: () => Navigator.pop(context),
                padding: EdgeInsets.zero,
              ),
            ),
          ),
        ),
        title: const Text(
          'Saved Location',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
        shadowColor: Colors.black.withOpacity(0.5),
      ),
      body: _hasLocations ? _buildListState() : _buildEmptyState(),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Illustration Placeholder
          Container(
            width: 250,
            height: 250,
            alignment: Alignment.center,
            child: Image.asset(
              'assets/images/no_location_illustration.png', // Placeholder
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFE0B2), // Light orange placeholder
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.image_not_supported,
                    size: 50,
                    color: Colors.orange,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'No saved location',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 16),
          _buildAddLocationButton(isCenter: true),
        ],
      ),
    );
  }

  Widget _buildListState() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          ..._dummyLocations.map((location) => _buildLocationCard(location)),
          const SizedBox(height: 20),
          _buildAddLocationButton(isCenter: false),
        ],
      ),
    );
  }

  Widget _buildLocationCard(Map<String, String> location) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Leading Icon
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: const Color(0xFFE8EAF6), // Light Indigo/Blue bg
              shape: BoxShape.circle,
            ),
            padding: const EdgeInsets.all(10),
            child: Image.asset(
              location['icon']!,
              errorBuilder: (context, error, stackTrace) => Icon(
                location['type'] == 'Home' ? Icons.home : Icons.work,
                color: const Color(0xFF1A237E),
              ),
            ),
          ),
          const SizedBox(width: 16),
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  location['type']!,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  location['address']!,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          // Actions
          Row(
            children: [
              InkWell(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Image.asset(
                    'assets/images/edit_icon.png', // Placeholder
                    width: 20,
                    height: 20,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.edit, size: 20, color: Colors.blue),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              InkWell(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Image.asset(
                    'assets/images/delete_icon.png', // Placeholder
                    width: 20,
                    height: 20,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.delete, size: 20, color: Colors.red),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAddLocationButton({required bool isCenter}) {
    return GestureDetector(
      onTap: () {
        // Placeholder action
        print('Add Location Tapped');
      },
      child: Row(
        mainAxisAlignment: isCenter
            ? MainAxisAlignment.center
            : MainAxisAlignment.start,
        mainAxisSize: isCenter ? MainAxisSize.max : MainAxisSize.min,
        children: [
          Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFF2196F3), // Blue
            ),
            padding: const EdgeInsets.all(2),
            child: const Icon(Icons.add, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 8),
          const Text(
            'Add Location',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF2196F3), // Blue text
            ),
          ),
        ],
      ),
    );
  }
}
