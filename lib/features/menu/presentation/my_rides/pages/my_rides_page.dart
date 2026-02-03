import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/my_rides_bloc.dart';
import '../bloc/my_rides_event.dart';
import '../bloc/my_rides_state.dart';
import '../widgets/ride_card_widget.dart';
import 'ride_details_page.dart';

class MyRidesPage extends StatelessWidget {
  const MyRidesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MyRidesBloc()..add(LoadMyRidesEvent()),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  size: 16,
                  color: Colors.black,
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ),
          centerTitle: true,
          title: const Text(
            'My Rides',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
        body: BlocConsumer<MyRidesBloc, MyRidesState>(
          listener: (context, state) {
            if (state is RideSelected) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      RideDetailsPage(ride: state.selectedRide),
                ),
              ).then((_) {
                // Reset or Reload when coming back if needed
                context.read<MyRidesBloc>().add(LoadMyRidesEvent());
              });
            }
          },
          buildWhen: (previous, current) => current is MyRidesLoaded,
          builder: (context, state) {
            if (state is MyRidesLoaded) {
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: state.rides.length,
                itemBuilder: (context, index) {
                  return RideCardWidget(
                    ride: state.rides[index],
                    onTap: () {
                      context.read<MyRidesBloc>().add(
                        SelectRideEvent(state.rides[index]),
                      );
                    },
                  );
                },
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
