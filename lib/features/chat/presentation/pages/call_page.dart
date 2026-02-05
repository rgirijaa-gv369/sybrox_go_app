import 'package:flutter/material.dart';

enum CallState { ringing, ongoing }

class CallPage extends StatefulWidget {
  const CallPage({super.key});

  @override
  State<CallPage> createState() => _CallPageState();
}

class _CallPageState extends State<CallPage> {
  CallState _callState = CallState.ringing;
  int _callDurationSeconds = 0;
  bool _isSpeakerOn = false;

  // Timer for call duration
  void _startCallTimer() {
    Future.delayed(const Duration(seconds: 1), () {
      if (_callState == CallState.ongoing && mounted) {
        setState(() {
          _callDurationSeconds++;
        });
        _startCallTimer();
      }
    });
  }

  // Format seconds to MM:SS format
  String _formatDuration(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final remainingSeconds = (seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$remainingSeconds';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8),
            ],
          ),
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
              size: 18,
            ),
            onPressed: () => Navigator.maybePop(context),
            padding: EdgeInsets.zero,
          ),
        ),
        title: const Text(
          'Call',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.3,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 60),
          // Profile Image
          Container(
            width: 140,
            height: 140,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFE8E8E8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 20,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ClipOval(
              child: Image.asset(
                'assets/images/chat-BG.jpg',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: const Color(0xFFE8E8E8),
                    child: const Icon(
                      Icons.person,
                      size: 70,
                      color: Color(0xFF9E9E9E),
                    ),
                  );
                },
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Name
          const Text(
            'Vikash',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w600,
              color: Colors.black,
              letterSpacing: 0.5,
            ),
          ),

          const SizedBox(height: 8),

          // Status text (Ringing or Duration)
          Text(
            _callState == CallState.ringing
                ? 'Ringing...'
                : _formatDuration(_callDurationSeconds),
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: Color(0xFF757575),
            ),
          ),

          const Spacer(),

          // Call control buttons
          Padding(
            padding: const EdgeInsets.only(bottom: 60),
            child: _callState == CallState.ringing
                ? _buildRingingButtons()
                : _buildOngoingButtons(),
          ),
        ],
      ),
    );
  }

  // Ringing state buttons
  Widget _buildRingingButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: const Color(0xFFE50027).withOpacity(0.3),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.call_end_rounded,
              size: 32,
              color: Color(0xFFE50027),
            ),
          ),
        ),

        const SizedBox(width: 80),

        GestureDetector(
          onTap: () {
            setState(() {
              _callState = CallState.ongoing;
            });
            _startCallTimer();
          },
          child: Container(
            width: 70,
            height: 70,
            decoration: const BoxDecoration(
              color: Color(0xFF1A8013),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.call_rounded,
              size: 32,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  // Ongoing call state buttons
  Widget _buildOngoingButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Speaker button
        GestureDetector(
          onTap: () {
            setState(() {
              _isSpeakerOn = !_isSpeakerOn;
            });
          },
          child: Container(
            width: 60,
            height: 60,
            decoration: const BoxDecoration(
              color: Color(0xFF111F4C),
              shape: BoxShape.circle,
            ),
            child: Icon(
              _isSpeakerOn ? Icons.volume_up_rounded : Icons.volume_up_rounded,
              size: 28,
              color: Colors.white,
            ),
          ),
        ),

        const SizedBox(width: 50),

        // Hang up button (Red)
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: const Color(0xFFE50027).withOpacity(0.3),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.call_end_rounded,
              size: 32,
              color: Color(0xFFE50027),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
