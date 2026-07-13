import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController promptController = TextEditingController();

  String imageUrl = "";

  bool loading = false;

  Future<void> generateImage() async {
    if (promptController.text.trim().isEmpty) return;

    setState(() {
      loading = true;
    });

    final prompt =
        Uri.encodeComponent(promptController.text.trim());

    imageUrl =
        "https://image.pollinations.ai/prompt/$prompt?width=1024&height=1024&nologo=true";

    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      loading = false;
    });
  }

  @override
  void dispose() {
    promptController.dispose();
    super.dispose();
  }

  Widget buildImage() {
    if (loading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (imageUrl.isEmpty) {
      return Container(
        height: 350,
        decoration: BoxDecoration(
          color: Colors.white10,
          borderRadius: BorderRadius.circular(24),
        ),
        child: const Center(
          child: Icon(
            Icons.image_outlined,
            size: 100,
            color: Colors.white24,
          ),
        ),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: Image.network(
        imageUrl,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, progress) {
          if (progress == null) return child;

          return SizedBox(
            height: 350,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("AI Photo Generator"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            children: [

              TextField(
                controller: promptController,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: "Describe your imagination...",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),

              const SizedBox(height: 18),

              SizedBox(
                width: double.infinity,
                height: 55,
                child: FilledButton(
                  onPressed: generateImage,
                  child: const Text(
                    "Generate Image",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Expanded(
                child: buildImage(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}