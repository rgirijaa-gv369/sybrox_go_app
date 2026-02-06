import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();
  final List<ChatMessage> _messages = [];
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    // Listen to focus changes - when keyboard opens/closes
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  String _getCurrentTime() {
    final now = DateTime.now();
    final hour = now.hour > 12
        ? now.hour - 12
        : (now.hour == 0 ? 12 : now.hour);
    final minute = now.minute.toString().padLeft(2, '0');
    final period = now.hour >= 12 ? 'pm' : 'am';
    return '$hour:$minute $period';
  }

  void _sendMessage() {
    if (_messageController.text.trim().isNotEmpty) {
      setState(() {
        _messages.add(
          ChatMessage(
            text: _messageController.text.trim(),
            isSentByMe: true,
            time: _getCurrentTime(),
          ),
        );
        _messageController.clear();
      });

      // Auto scroll to bottom
      Future.delayed(const Duration(milliseconds: 100), () {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });

      // Simulate receiving a reply after 2 seconds
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          setState(() {
            _messages.add(
              ChatMessage(
                text:
                    "Hello sir, I am  near to your location.Reaching in 5 mins",
                isSentByMe: false,
                time: _getCurrentTime(),
              ),
            );
          });

          // Auto scroll to the new message
          Future.delayed(const Duration(milliseconds: 100), () {
            if (_scrollController.hasClients) {
              _scrollController.animateTo(
                _scrollController.position.maxScrollExtent,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
              );
            }
          });
        }
      });
    }
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
        title: Column(
          children: [
            Text(
              _messages.isEmpty ? 'Chat' : 'Vikash',
              style: TextStyle(
                color: Colors.black,
                fontSize: _messages.isEmpty ? 18 : 20,
                fontWeight: _messages.isEmpty
                    ? FontWeight.w600
                    : FontWeight.w700,
                letterSpacing: 0.3,
              ),
            ),
            if (_messages.isNotEmpty)
              Text(
                'Chat',
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
          ],
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // Background
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: const AssetImage('assets/images/chat-BG.jpg'),
                fit: BoxFit.cover,
                onError: (error, stackTrace) {},
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.grey[50]!, Colors.grey[100]!],
                ),
              ),
            ),
          ),
          // Main content
          Column(
            children: [
              // Messages area
              Expanded(
                child: _messages.isEmpty
                    ? _buildEmptyState()
                    : _buildMessagesList(),
              ),
              // Input area
              _buildMessageInput(),
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
          // Profile image
          Container(
            width: 110,
            height: 110,
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
                      size: 55,
                      color: Color(0xFF9E9E9E),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 20),
          // Name
          const Text(
            'Vikash',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 16),
          // Note
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: TextStyle(
                  fontSize: 13.5,
                  color: Colors.grey[600],
                  height: 1.5,
                ),
                children: [
                  TextSpan(
                    text: 'Note: ',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[700],
                    ),
                  ),
                  const TextSpan(
                    text:
                        'Reply to your message can be delayed as drivers don\'t reply while driving',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessagesList() {
    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      itemCount: _messages.length,
      itemBuilder: (context, index) {
        final message = _messages[index];
        return _buildMessageBubble(message);
      },
    );
  }

  Widget _buildMessageBubble(ChatMessage message) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Align(
        alignment: message.isSentByMe
            ? Alignment.centerRight
            : Alignment.centerLeft,
        child: Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.75,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            gradient: message.isSentByMe
                ? const LinearGradient(
                    colors: [Color(0xFFFFA75F), Color(0xFFFF3B30)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  )
                : null,
            color: message.isSentByMe ? null : const Color(0xFFD9D9D9),
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(18),
              topRight: const Radius.circular(18),
              bottomLeft: message.isSentByMe
                  ? const Radius.circular(18)
                  : const Radius.circular(4),
              bottomRight: message.isSentByMe
                  ? const Radius.circular(4)
                  : const Radius.circular(18),
            ),
            boxShadow: [
              BoxShadow(
                color: message.isSentByMe
                    ? const Color(0xFFFFA75F).withOpacity(0.3)
                    : Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                message.text,
                style: TextStyle(
                  color: message.isSentByMe ? Colors.white : Colors.black87,
                  fontSize: 14.5,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 4),
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  message.time,
                  style: TextStyle(
                    color: message.isSentByMe
                        ? Colors.white.withOpacity(0.85)
                        : Colors.grey[500],
                    fontSize: 10,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
      color: Colors.transparent,
      child: SafeArea(
        top: false,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // Input field with send button inside
            Expanded(
              child: Container(
                constraints: const BoxConstraints(
                  minHeight: 48,
                  maxHeight: 120,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(28),
                  // When keyboard is CLOSED - gray border
                  border: !_isFocused
                      ? Border.all(color: const Color(0xFFE0E0E0), width: 1)
                      : null,
                  // White background always
                  color: Colors.white,
                ),
                // Wrap with gradient border container when focused
                foregroundDecoration: _isFocused
                    ? BoxDecoration(
                        borderRadius: BorderRadius.circular(28),
                        border: Border.all(color: Colors.transparent, width: 0),
                      )
                    : null,
                child: Container(
                  decoration: _isFocused
                      ? BoxDecoration(
                          borderRadius: BorderRadius.circular(28),
                          gradient: const LinearGradient(
                            colors: [Color(0xFFFFAA2B), Color(0xFFFF3B30)],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                        )
                      : null,
                  child: Container(
                    // Inner white container with smaller radius to show gradient border
                    margin: _isFocused
                        ? const EdgeInsets.all(1.5)
                        : EdgeInsets.zero,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(
                        _isFocused ? 26.5 : 28,
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // Text input
                        Expanded(
                          child: TextField(
                            controller: _messageController,
                            focusNode: _focusNode,
                            maxLines: null,
                            textInputAction: TextInputAction.newline,
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.black87,
                            ),
                            decoration: const InputDecoration(
                              hintText: 'Type your message',
                              hintStyle: TextStyle(
                                color: Color(0xFFBDBDBD),
                                fontSize: 15,
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 14,
                              ),
                            ),
                            onChanged: (value) => setState(() {}),
                          ),
                        ),

                        // Send button inside the input box
                        Padding(
                          padding: const EdgeInsets.only(right: 4, bottom: 4),
                          child: GestureDetector(
                            onTap: _sendMessage,
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xFFFFAA2B),
                                    Color(0xFFFF3B30),
                                  ],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                              ),
                              child: const Icon(
                                Icons.send_rounded,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    _focusNode.dispose();
    super.dispose();
  }
}

class ChatMessage {
  final String text;
  final bool isSentByMe;
  final String time;

  ChatMessage({
    required this.text,
    required this.isSentByMe,
    required this.time,
  });
}
