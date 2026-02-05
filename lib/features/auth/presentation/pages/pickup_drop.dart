import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';



import '../../../../core/utils/location_service.dart';
import '../bloc/location_bloc.dart';
import '../widget/custom_divider.dart';
import 'map_ride_page.dart';

class PickupDropPage extends StatelessWidget {
  const PickupDropPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LocationBloc()..add(const LoadCurrentLocation()),
      child: const PickupDropView(),
    );
  }
}

class PickupDropView extends StatefulWidget {
  const PickupDropView({super.key});

  @override
  State<PickupDropView> createState() => _PickupDropViewState();
}

class _PickupDropViewState extends State<PickupDropView> {
  final pickupController = TextEditingController();
  final dropController = TextEditingController();
  final LocationService locationService = LocationService();
  String selectedValue = "For me";


  List<String> predictions = [];

  @override
  void initState() {
    super.initState();
    _setCurrentLocation();
  }

  @override
  void dispose() {
    pickupController.dispose();
    dropController.dispose();
    super.dispose();
  }

  Future<void> _setCurrentLocation() async {
    try {
      final position = await locationService.getCurrentLocation();
      final address = await locationService.convertPositionToAddress(
        position.latitude,
        position.longitude,
      );

      pickupController.text = address;
      context.read<LocationBloc>().add(SetPickupLocation(address));
      setState(() {});
    } catch (e) {
      debugPrint("Error fetching location: $e");
    }
  }


  Future<void> _calculateDistance() async {
    if (pickupController.text.isEmpty || dropController.text.isEmpty) return;

    try {
      final coords = await Future.wait([
        locationService.getLatLngFromAddress(pickupController.text),
        locationService.getLatLngFromAddress(dropController.text),
      ]);

      final distance = LocationService.calculateDistanceKm(
        pickupLat: coords[0].latitude,
        pickupLng: coords[0].longitude,
        dropLat: coords[1].latitude,
        dropLng: coords[1].longitude,
      );

      debugPrint("Distance between pickup and drop: ${distance.toStringAsFixed(2)} km");
    } catch (e) {
      debugPrint("Error calculating distance: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      body: SafeArea(
        child: Stack(
          children:[
            SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 20),
            child: Column(
              children: [
                _appBar(context),
                const SizedBox(height: 16),
                _pickupCard(),
                const SizedBox(height: 16),
                _quickActions(),
                const Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14,vertical: 14),
                  child: DashedDivider(
                    color: Colors.grey,
                    dashWidth: 10,
                    dashSpace: 8,
                  ),
                ),
                const SizedBox(height: 16),
                _suggestionsList(),
                const SizedBox(height: 16),
                _nextButton(context),
              ],
            ),
          ),
          ],
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
          const Center(
            child: Text(
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _locationIndicators(),
                const SizedBox(width: 12),
                Expanded(child: _locationFields(context)),
                const SizedBox(width: 10),
                Align(
                  alignment: Alignment.center,
                  child: _swapButton(),)

              ],
            ),

          ],
        ),
      ),
    );
  }


  Widget _suggestionsOverlay() {
    return Material(
      elevation: 10,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        constraints: const BoxConstraints(maxHeight: 220),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListView.separated(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          itemCount: predictions.length,
          separatorBuilder: (_, __) => Divider(height: 1),
          itemBuilder: (_, i) {
            final suggestion = predictions[i];
            return ListTile(
              dense: true,
              title: Text(
                suggestion,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 14),
              ),
              onTap: () {
                dropController.text = suggestion;
                context.read<LocationBloc>().add(
                  SetDropLocation(suggestion),
                );
                setState(() => predictions.clear());
                _calculateDistance();
              },
            );
          },
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

  Widget _locationFields(BuildContext context) {
    return BlocListener<LocationBloc, LocationState>(
      listenWhen: (previous, current) =>
      previous.pickupAddress != current.pickupAddress,
      listener: (context, state) {
        pickupController.text = state.pickupAddress;
      },
      child: Column(
        children: [
          _inputField(
            controller: pickupController,
            hint: "Current location",
            enabled: false,
          ),
          const SizedBox(height: 12),
          _dropLocationField(context),
        ],
      ),
    );
  }

  Widget _dropLocationField(BuildContext context) {
    return Column(
      children: [
        _inputField(
          controller: dropController,
          hint: "Enter destination",
          onChanged: _onDropTextChanged,
        ),
      ],
    );
  }
  Future<void> _onDropTextChanged(String value) async {
    if (value.length < 3) {
      setState(() => predictions.clear());
      return;
    }

    final results = await OpenStreetMapService.searchPlace(value);

    if (!mounted) return;
    if (value == dropController.text) {
      setState(() => predictions = results);
    }
  }

  Widget _swapButton() {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();

        final pickup = pickupController.text;
        final drop = dropController.text;

        if (pickup.isEmpty || drop.isEmpty) return;


        pickupController.text = drop;
        dropController.text = pickup;


        context.read<LocationBloc>().add(
          SetPickupLocation(drop),
        );

        context.read<LocationBloc>().add(
          SetDropLocation(pickup),
        );
      },
      child: Container(
        height: 42,
        width: 42,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey.shade200,
        ),
        child: const Icon(Icons.swap_vert, size: 22),
      ),
    );
  }

  Widget _locationIndicators() {
    return Column(
      children: [
        _circleIcon(Icons.location_on, Colors.green),
        Container(
          height: 36,
          width: 2,
          decoration: const BoxDecoration(
            border: Border(
              left: BorderSide(
                color: Colors.black54,
                width: 1,
                style: BorderStyle.solid,
              ),
            ),
          ),
        ),
        _circleIcon(Icons.location_on, Colors.red),
      ],
    );
  }

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
              label: "Select on Map",
              iconBg: Colors.green.shade100,
              iconColor: Colors.green,
            ),
            const SizedBox(width: 6),
            _quickActionItem(
              icon: Icons.favorite,
              label: "Saved Location",
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

  Widget _suggestionsList() {
    return Container(
      margin: const EdgeInsets.only(top: 6),
      constraints: const BoxConstraints(maxHeight: 220),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListView.separated(
        padding: EdgeInsets.zero,
        itemCount: predictions.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (_, index) {
          final suggestion = predictions[index];
          return InkWell(
              onTap: () {
                dropController.text = suggestion;
                context.read<LocationBloc>().add(SetDropLocation(suggestion));
                setState(() => predictions.clear());
                _calculateDistance();
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  /// Location Icon
                  const Icon(
                  Icons.location_on,
                  color: Colors.red,
                  size: 20,
                ),
                  const SizedBox(width: 12),

                  /// Text Section
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      Text(
                      suggestion,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ), const SizedBox(height: 4),
                        Text(
                          "Chennai, Tamil Nadu", // optional subtitle
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],  ),
                  ),

                    const SizedBox(width: 8),

                    /// Distance (optional)
                    const Text(
                      "7.8 km",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),

                    const SizedBox(width: 6),

                    /// Favourite Icon (optional)
                    const Icon(
                      Icons.favorite_border,
                      size: 18,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
          );
        },
      ),
    );
  }

  Widget _inputField({
    required TextEditingController controller,
    required String hint,
    bool enabled = true,
    Function(String)? onChanged,
  }) {
    return Container(
      height: 46,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: TextField(
        controller: controller,
        enabled: enabled,
        onChanged: onChanged,
        style: TextStyle(
          color: Colors.black
        ),
        decoration: InputDecoration(
          hintText: hint,
          border: InputBorder.none,
        ),
      ),
    );
  }


  Widget _nextButton(BuildContext context) {
    final isEnabled =
        pickupController.text.isNotEmpty &&
            dropController.text.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor:
            isEnabled ? Colors.orange : Colors.grey.shade400,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
          onPressed: isEnabled
              ? () async {
            try{
            final pickupLatLng =
            await locationService.getLatLngFromAddress(
                pickupController.text);

            final dropLatLng =
            await locationService.getLatLngFromAddress(
                dropController.text);

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => RideMapScreen(
                  pickup: LatLng(
                    pickupLatLng.latitude,
                    pickupLatLng.longitude,
                  ),
                  drop: LatLng(
                    dropLatLng.latitude,
                    dropLatLng.longitude,
                  ),
                ),
              ),
            );
          }catch (e) {
              debugPrint("Navigation error: $e");

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Unable to load map. Try again."),
                ),
              );
            }
          }
              : null,
          child: const Text(
            "Next",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }


}
