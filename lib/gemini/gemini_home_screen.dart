import 'package:chat_bot/gemini/gemini_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GeminiScreen extends StatefulWidget {
  const GeminiScreen({super.key});

  @override
  State<GeminiScreen> createState() => _GeminiScreenState();
}

class _GeminiScreenState extends State<GeminiScreen> {
  TextEditingController prompt = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GeminiProvider(),
      child: Consumer<GeminiProvider>(
        builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            title: const Text('Gemini'),
            centerTitle: true,
            backgroundColor: Colors.tealAccent,
          ),
          body: Column(
            children: [
              const SizedBox(height: 30),
              const Padding(
                padding:  EdgeInsets.only(left:8.0),
                child:  Text(
                  'Chat to start writing, planning, learning and more with Google AI',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w300),
                  //textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: model.message.length,
                  itemBuilder: (context, index) {
                    // Differentiate user and AI messages for better readability
                    bool isUser = index % 2 == 0; // user messages
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 16.0),
                      child: Align(
                        alignment: isUser
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: isUser
                                ? Colors.teal[200]
                                : Colors.grey[300],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            model.message[index],
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: prompt,
                        decoration: const InputDecoration(
                          hintText: 'Enter text',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        if (prompt.text.trim().isNotEmpty) {
                          model.geminiresponse(prompt.text.trim());
                          prompt.clear();
                        }
                      },
                      icon: const Icon(
                        Icons.send,
                        color: Colors.teal,
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
}
