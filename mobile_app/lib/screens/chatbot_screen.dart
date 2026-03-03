import 'package:flutter/material.dart';
import 'dart:ui';
import '../l10n/app_localizations.dart';

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({super.key});

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, dynamic>> _messages = [
    {
      'text': 'Hello! I am your Leaf AI Assistant. How can I help you with your crops today? 🌿',
      'isUser': false,
    },
  ];
  bool _isTyping = false;

  void _handleSend() async {
    if (_controller.text.trim().isEmpty) return;

    final userMessage = _controller.text;
    setState(() {
      _messages.add({'text': userMessage, 'isUser': true});
      _controller.clear();
      _isTyping = true;
    });

    // Simulate AI response based on keywords
    await Future.delayed(const Duration(seconds: 1));

    String aiResponse = _getAIResponse(userMessage);

    if (mounted) {
      setState(() {
        _isTyping = false;
        _messages.add({'text': aiResponse, 'isUser': false});
      });
    }
  }

  String _getAIResponse(String query) {
    query = query.toLowerCase();
    if (query.contains('maize') || query.contains('corn')) {
      if (query.contains('streak')) {
        return "Maize Streak Virus is spread by leafhoppers. You should plant resistant hybrids and remove volunteer plants between seasons. 🌽";
      }
      return "For healthy maize, ensure proper spacing and rotate crops with legumes to maintain soil nitrogen. 🌽";
    } else if (query.contains('cabbage')) {
      if (query.contains('black rot')) {
        return "Black Rot in cabbage is serious. Use certified seeds and rotate crops for 3 years. Remove any infected debris immediately. 🥬";
      }
      return "Cabbages love cool weather and lots of organic matter. Watch out for loopers! 🥬";
    } else if (query.contains('sukuma') || query.contains('kale')) {
      if (query.contains('aphids')) {
        return "Aphids can be controlled by blasting them with a strong stream of water or using neem oil sprays. 🥬";
      }
      return "Sukuma Wiki is very hardy, but needs consistent watering and nitrogen-rich soil for best yields. 🥬";
    } else if (query.contains('tomato')) {
      return "Tomato Early Blight causes dark spots with rings. Improve airflow, stake your plants, and mulch the soil. 🍅";
    } else if (query.contains('hello') || query.contains('hi')) {
      return "Hello! I can help with Maize, Cabbage, Sukuma Wiki, Tomato, and Potato diseases. What are you growing?";
    }
    
    return "I'm still learning! You can ask me about symptoms and prevention for Maize, Cabbage, or Sukuma Wiki. Try asking about 'Black Rot' or 'Maize Streak'.";
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFF0D4F2B),
              const Color(0xFF1A7A4A),
              colorScheme.surface,
            ],
            stops: const [0.0, 0.2, 0.4],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Custom Header
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 20, 0),
                child: Row(
                  children: [
                    IconButton(
                      icon: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.15),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.arrow_back, color: Colors.white, size: 20),
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const Icon(Icons.smart_toy_rounded, color: Colors.white, size: 28),
                    const SizedBox(width: 12),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Leaf AI Assistant',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Online Expert Advice',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Chat Messages
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: colorScheme.surface,
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
                    child: ListView.builder(
                      padding: const EdgeInsets.all(20),
                      itemCount: _messages.length + (_isTyping ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index == _messages.length) {
                          return _buildTypingIndicator();
                        }
                        final msg = _messages[index];
                        return _buildMessage(msg['text'], msg['isUser']);
                      },
                    ),
                  ),
                ),
              ),

              // Input Area
              Container(
                color: colorScheme.surface,
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: colorScheme.surfaceContainerHighest.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(color: colorScheme.outline.withOpacity(0.1)),
                        ),
                        child: TextField(
                          controller: _controller,
                          decoration: const InputDecoration(
                            hintText: 'Ask about plant diseases...',
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          ),
                          onSubmitted: (_) => _handleSend(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    GestureDetector(
                      onTap: _handleSend,
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: const BoxDecoration(
                          color: Color(0xFF2E7D32),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.send_rounded, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMessage(String text, bool isUser) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
        decoration: BoxDecoration(
          color: isUser 
              ? const Color(0xFF2E7D32) 
              : Theme.of(context).colorScheme.surfaceContainerHighest.withOpacity(0.8),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(20),
            topRight: const Radius.circular(20),
            bottomLeft: Radius.circular(isUser ? 20 : 0),
            bottomRight: Radius.circular(isUser ? 0 : 20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isUser ? Colors.white : Theme.of(context).colorScheme.onSurface,
            fontSize: 15,
            height: 1.4,
          ),
        ),
      ),
    );
  }

  Widget _buildTypingIndicator() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHighest.withOpacity(0.8),
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Text('Typing...', style: TextStyle(fontStyle: FontStyle.italic, color: Colors.black54)),
      ),
    );
  }
}
