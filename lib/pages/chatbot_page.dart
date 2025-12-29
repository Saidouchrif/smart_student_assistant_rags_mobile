import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import '../services/chatbot_client.dart';
import '../services/api_config.dart';
import '../models/chat_request.dart';
import '../models/chat_response.dart';

class ChatbotPage extends StatefulWidget {
  const ChatbotPage({super.key});

  @override
  State<ChatbotPage> createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage> {
  late final ChatbotClient api;
  final TextEditingController controller = TextEditingController();
  final ScrollController scrollController = ScrollController();

  bool loading = false;

  // 📌 Liste des messages (user + bot)
  final List<_Message> messages = [];

  @override
  void initState() {
    super.initState();

    api = ChatbotClient(
      Dio(
        BaseOptions(
          baseUrl: ApiConfig.baseUrl,
          headers: {"Content-Type": "application/json"},
        ),
      ),
    );
  }

  Future<void> send() async {
    final question = controller.text.trim();
    if (question.isEmpty) return;

    setState(() {
      messages.add(
        _Message(text: question, isUser: true),
      );
      loading = true;
    });

    controller.clear();
    _scrollToBottom();

    try {
      final ChatResponse response = await api.sendQuestion(
        ChatRequest(question: question),
      );

      setState(() {
        messages.add(
          _Message(text: response.answer, isUser: false),
        );
      });
    } catch (e) {
      setState(() {
        messages.add(
          _Message(
            text: "❌ Erreur lors de la communication avec le serveur.",
            isUser: false,
          ),
        );
      });
    }

    setState(() {
      loading = false;
    });

    _scrollToBottom();
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 200), () {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Assistant IA"),
        centerTitle: true,
      ),

      body: Column(
        children: [

          // ===== LISTE DES MESSAGES =====
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              padding: const EdgeInsets.all(12),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                return _ChatBubble(message: message);
              },
            ),
          ),

          if (loading)
            const Padding(
              padding: EdgeInsets.all(8),
              child: CircularProgressIndicator(),
            ),

          // ===== INPUT =====
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 4,
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    maxLines: 2,
                    decoration: const InputDecoration(
                      hintText: "Posez votre question...",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: loading ? null : send,
                  icon: const Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

//////////////////////////////////////////////////
/// MODELE MESSAGE
//////////////////////////////////////////////////
class _Message {
  final String text;
  final bool isUser;

  _Message({required this.text, required this.isUser});
}

//////////////////////////////////////////////////
/// BULLE DE CONVERSATION
//////////////////////////////////////////////////
class _ChatBubble extends StatelessWidget {
  final _Message message;

  const _ChatBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    final alignment =
        message.isUser ? Alignment.centerRight : Alignment.centerLeft;
    final color = message.isUser
        ? Theme.of(context).colorScheme.primary
        : Colors.grey.shade200;
    final textColor = message.isUser ? Colors.white : Colors.black87;

    return Align(
      alignment: alignment,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.all(12),
        constraints: const BoxConstraints(maxWidth: 300),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          message.text,
          style: TextStyle(color: textColor, fontSize: 15),
        ),
      ),
    );
  }
}
