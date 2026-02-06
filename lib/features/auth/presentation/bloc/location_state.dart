part of 'location_bloc.dart';

class LocationState extends Equatable {
  final String pickupAddress;
  final String dropAddress;
  final List<String> suggestions;
  final bool isLoading;

  const LocationState({
    this.pickupAddress = '',
    this.dropAddress = '',
    this.suggestions = const [],
    this.isLoading = false,
  });

  LocationState copyWith({
    String? pickupAddress,
    String? dropAddress,
    List<String>? suggestions,
    bool? isLoading,
  }) {
    return LocationState(
      pickupAddress: pickupAddress ?? this.pickupAddress,
      dropAddress: dropAddress ?? this.dropAddress,
      suggestions: suggestions ?? this.suggestions,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [pickupAddress, dropAddress, isLoading];
}
