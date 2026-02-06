import 'package:equatable/equatable.dart';

class Message extends Equatable {
  final String text;

  const Message({required this.text});

  @override
  List<Object?> get props => [text];
}
