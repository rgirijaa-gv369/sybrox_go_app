import 'package:flutter/material.dart';

class HelpSupportPage extends StatefulWidget {
  const HelpSupportPage({super.key});

  @override
  State<HelpSupportPage> createState() => _HelpSupportPageState();
}

class _HelpSupportPageState extends State<HelpSupportPage> {
  int _selectedTabIndex = 0;
  String _selectedFilter = 'ALL';
  int? _expandedIndex;
  int? _expandedContactIndex;

  final List<String> _filters = [
    'ALL',
    'Services',
    'Login',
    'Booking',
    'Payments',
    'Claims',
  ];

  final List<Map<String, String>> _faqItems = [
    {
      'question': 'What if i need to cancel booking',
      'answer':
          'To cancel a GO booking, go to the "My Rides" section in the app, select the ride, tap "Cancel Ride," and confirm. A cancellation fee may apply if a Rider is assigned. For help, contact support through the app.',
    },
    {
      'question': 'How do i receive booking',
      'answer': 'You will receive a booking notification in the app.',
    },
    {
      'question': 'How can i edit my profile information',
      'answer': 'Go to Profile settings to edit your information.',
    },
    {
      'question': 'Will I be charged a cancellation fee?',
      'answer': 'Yes, cancellation fees may apply depending on the timing.',
    },
    {
      'question': 'What payment methods does Go accept?',
      'answer': 'We accept credit cards, debit cards, and digital wallets.',
    },
    {
      'question': 'Can i pay in cash for my ride?',
      'answer': 'Yes, cash payments are accepted for rides.',
    },
  ];

  // Helper method to safely load images with fallback
  Widget _buildContactIcon(String imageName) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey.shade100,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.asset(
          'assets/images/helpand-support/$imageName',
          width: 36,
          height: 36,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            // Fallback to a colored container with initial letter
            return Center(
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: _getColorForService(imageName),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    imageName.substring(0, 1).toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Color _getColorForService(String service) {
    switch (service) {
      case 'customerservice1.png':
        return Colors.blue;
      case 'customerservice2.png':
        return Colors.green;
      case 'website.png':
        return Colors.orange;
      case 'facbook.png':
        return Colors.blue[800]!;
      case 'twitter.png':
        return Colors.blue[400]!;
      case 'insta.png':
        return Colors.pink;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: _buildAppBar(context, 'Help and Support'),
      body: Column(
        children: [
          // Gradient section with search bar
          _buildGradientSection(),

          Expanded(
            child: Column(
              children: [
                _buildTabs(),

                const SizedBox(height: 12),

                if (_selectedTabIndex == 0) _buildFilterChips(),

                if (_selectedTabIndex == 0) const SizedBox(height: 8),

                Expanded(
                  child: _selectedTabIndex == 0
                      ? _buildFAQList()
                      : _buildContactUs(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context, String title) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      leadingWidth: 56,
      leading: Container(
        margin: const EdgeInsets.only(left: 16),
        child: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
            size: 20,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w700,
          color: Colors.black,
          letterSpacing: 0.07,
        ),
      ),
      centerTitle: true,
      actions: const [SizedBox(width: 56)],
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
        ),
      ),
    );
  }

  Widget _buildGradientSection() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Column(
          children: [
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 16),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFFFFBD5B), Color(0xFFFFC46B)],
                ),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(30),
                ),
              ),
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 50),
              child: _selectedTabIndex == 0
                  ? const Text(
                      'FAQ',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    )
                  : const SizedBox.shrink(),
            ),

            const SizedBox(height: 24),
          ],
        ),

        Positioned(
          left: 20,
          right: 20,
          bottom: 0,
          child: Container(
            height: 48,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.grey.shade400,
                  size: 20,
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTabs() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedTabIndex = 0;
                  _expandedIndex = null;
                  _expandedContactIndex = null;
                });
              },
              child: Container(
                padding: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: _selectedTabIndex == 0
                          ? const Color(0xFF2196F3)
                          : Colors.transparent,
                      width: 2.5,
                    ),
                  ),
                ),
                child: Text(
                  'FAQ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: _selectedTabIndex == 0
                        ? const Color(0xFF2196F3)
                        : Colors.grey.shade400,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedTabIndex = 1;
                  _expandedContactIndex = null;
                });
              },
              child: Container(
                padding: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: _selectedTabIndex == 1
                          ? const Color(0xFF2196F3)
                          : Colors.transparent,
                      width: 2.5,
                    ),
                  ),
                ),
                child: Text(
                  'Contact Us',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: _selectedTabIndex == 1
                        ? const Color(0xFF2196F3)
                        : Colors.grey.shade400,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChips() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: _filters.map((filter) {
          final isSelected = _selectedFilter == filter;
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedFilter = filter;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected ? Colors.black : Colors.grey.shade300,
                  width: 1,
                ),
              ),
              child: Text(
                filter,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  color: isSelected ? Colors.black : Colors.grey.shade600,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildFAQList() {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      physics: const BouncingScrollPhysics(),
      itemCount: _faqItems.length,
      separatorBuilder: (context, index) =>
          Divider(color: Colors.grey.shade200, thickness: 1, height: 1),
      itemBuilder: (context, index) {
        final item = _faqItems[index];
        final isExpanded = _expandedIndex == index;
        return _buildFAQItem(
          item['question']!,
          item['answer']!,
          index,
          isExpanded,
        );
      },
    );
  }

  Widget _buildFAQItem(
    String question,
    String answer,
    int index,
    bool isExpanded,
  ) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        setState(() {
          _expandedIndex = isExpanded ? null : index;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    question,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ),
                Icon(
                  isExpanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: Colors.black,
                  size: 20,
                ),
              ],
            ),
            if (isExpanded) ...[
              const SizedBox(height: 8),
              Text(
                answer,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade600,
                  height: 1.5,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildContactUs() {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      physics: const BouncingScrollPhysics(),
      itemCount: 6,
      separatorBuilder: (context, index) =>
          Divider(color: Colors.grey.shade200, thickness: 1, height: 1),
      itemBuilder: (context, index) {
        switch (index) {
          case 0:
            return _buildContactItem(
              icon: _buildContactIcon('customerservice1.png'),
              title: 'Customer Service',
              index: 0,
              content: '+91 8829100000',
              contentColor: Colors.red,
            );
          case 1:
            return _buildContactItem(
              icon: _buildContactIcon('customerservice2.png'),
              title: 'Customer Service',
              index: 1,
            );
          case 2:
            return _buildContactItem(
              icon: _buildContactIcon('website.png'),
              title: 'Website',
              index: 2,
            );
          case 3:
            return _buildContactItem(
              icon: _buildContactIcon('facebook.png'),
              title: 'Facebook',
              index: 3,
            );
          case 4:
            return _buildContactItem(
              icon: _buildContactIcon('twitter.png'),
              title: 'Twitter',
              index: 4,
            );
          case 5:
            return _buildContactItem(
              icon: _buildContactIcon('insta.png'),
              title: 'Instagram',
              index: 5,
            );
          default:
            return const SizedBox.shrink();
        }
      },
    );
  }

  Widget _buildContactItem({
    required Widget icon,
    required String title,
    required int index,
    String? content,
    Color? contentColor,
  }) {
    final isExpanded = _expandedContactIndex == index;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        setState(() {
          _expandedContactIndex = isExpanded ? null : index;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                icon,
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ),
                Icon(
                  isExpanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: Colors.black,
                  size: 20,
                ),
              ],
            ),
            if (isExpanded && content != null) ...[
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.only(left: 48),
                child: Row(
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: contentColor ?? Colors.grey.shade600,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      content,
                      style: TextStyle(
                        fontSize: 13,
                        color: contentColor ?? Colors.grey.shade600,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
