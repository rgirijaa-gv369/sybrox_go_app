import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PickupDropPage extends StatefulWidget {
  const PickupDropPage({super.key});

  @override
  State<PickupDropPage> createState() => _PickupDropPageState();
}

class _PickupDropPageState extends State<PickupDropPage> {
  TextEditingController pickupController = TextEditingController();
  String selectedValue = "For me";

  @override
  void initState() {
    super.initState();
    pickupController = TextEditingController();
  }

  @override
  void dispose() {
    pickupController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(
            children: [
              _appBar(context),
              const SizedBox(height: 16),
              _pickupCard(),
              const SizedBox(height: 16),
              _quickActions(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _appBar(BuildContext context) {
    return Container(
      height: 72,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20)),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 6,
                  ),
                ],
              ),
              child: const Icon(Icons.arrow_back_ios_new, size: 18),
            ),
          ),
          const SizedBox(width: 100),
          Center(
            child: const Text(
              "Pickup",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }

  Widget _pickupCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.12),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          children: [
            _forMeDropdown(),
            const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _locationIndicators(),
                const SizedBox(width: 12),
                Expanded(child: _locationFields()),
                const SizedBox(width: 10),
                Align(alignment: Alignment.center, child: _swapButton()),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _forMeDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      height: 32,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedValue,
          icon: const Icon(Icons.keyboard_arrow_down, size: 18),
          elevation: 0,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
          items: const [
            DropdownMenuItem(value: "For me", child: Text("For me")),
            DropdownMenuItem(
              value: "For someone else",
              child: Text("For someone else"),
            ),
          ],
          onChanged: (value) {
            setState(() => selectedValue = value!);
          },
        ),
      ),
    );
  }

  Widget _locationFields() {
    return Column(
      children: [
        _inputField(hint: "Enter the pickup location", filled: true),
        const SizedBox(height: 12),
        _inputField(hint: "Enter the Destination Location"),
      ],
    );
  }

  Widget _swapButton() {
    return Container(
      height: 42,
      width: 42,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey.shade200,
      ),
      child: const Icon(Icons.swap_vert, size: 22),
    );
  }

  Widget _inputField({required String hint, bool filled = false}) {
    return Container(
      height: 46,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color:  Colors.white,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: TextField(
        controller: pickupController,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.grey),
          border: InputBorder.none,
          isDense: true,
        ),
      ),
    );
  }
}

Widget _locationIndicators() {
  return Column(
    children: [
      _circleIcon(Icons.location_on, Colors.green),
      Container( height: 36, width: 2,
        decoration: const BoxDecoration(
          border: Border( left: BorderSide(
            color: Colors.black54, width: 1,
            style: BorderStyle.solid,
          ), ), ), ),
      _circleIcon(Icons.location_on, Colors.red), ], ); }

  Widget _circleIcon(IconData icon, Color color) {
    return Container(
      height: 36,
      width: 36,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: color, width: 2),
      ),
      child: Icon(icon, size: 18, color: color),
    );
  }

  Widget _quickActions() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.none,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _quickActionItem(
              icon: Icons.my_location,
              label: "Current Location",
              iconBg: Colors.blue.shade100,
              iconColor: Colors.blue,
            ),
            const SizedBox(width: 6),
            _quickActionItem(
              icon: Icons.map,
              label: "select on Map",
              iconBg: Colors.green.shade100,
              iconColor: Colors.green,
            ),
            const SizedBox(width: 6),
            _quickActionItem(
              icon: Icons.favorite,
              label: "Saved location",
              iconBg: Colors.red.shade100,
              iconColor: Colors.red,
            ),
          ],
        ),
      ),
    );
  }

  Widget _quickActionItem({
    required IconData icon,
    required String label,
    required Color iconBg,
    required Color iconColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 10,
            backgroundColor: iconBg,
            child: Icon(icon, size: 12, color: iconColor),
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

