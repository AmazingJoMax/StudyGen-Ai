import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});
  final String about = """
**Welcome to StudyCraft Ai,** your personal textbook generator! StudyCraft Ai is designed to revolutionize the way you learn and study. By harnessing the power of generative AI, our app allows you to create custom textbooks on any topic, tailored to your preferences for detail and complexity.

#### Key Features:

- **Custom Textbook Generation:** Simply input your desired topic, and StudyCraft Ai will generate a comprehensive textbook for you. From history to quantum physics, our AI has got you covered.
- **Personalized Learning:** Adjust the level of detail and the complexity of the content through the settings page, making it perfect for learners at any stage.
- **Save and Access Later:** Once your textbook is generated, save it to your library for easy access anytime, anywhere. Your personalized library grows with you.
- **Settings Customization:** Tailor the generative AI model used for your textbooks in the settings page. Choose from various AI models to find the one that suits your learning style best.
- **Easy Navigation:** Use the intuitive navigation drawer to switch between generating a new textbook, accessing your library, and customizing your settings.

#### How to Use StudyCraft Ai:

1. **Start Generating:** Open the app and use the navigation drawer to select 'Generate Textbook'. Enter your topic and let our AI do the rest.
2. **Customize Your Experience:** Head to the settings page from the navigation drawer to adjust the detail level, choose the AI model, and more.
3. **Build Your Library:** Save your generated textbooks for future reference. Access them anytime from the 'Library' section in the navigation drawer.

4. **Explore and Learn:** Dive into your custom textbooks. StudyCraft Ai makes learning about new topics easy and fun.
""";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('StudyCraft Ai'),
      ),
      body: Markdown(
        data: about,
      ),
    );
  }
}
