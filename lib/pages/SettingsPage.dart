import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../shared.dart';
import '../settingsService.dart';

const String markdownContent = '## Special thanks:\n'
    '- [Karl Hammond\'s Compendium of Wheel of Time Characters](https://hammondkd.github.io/WoT-compendium/)\n'
    '- [The /r/wot Subreddit](https://reddit.com/r/wot)\n'
    '- Everyone who has reported a spoiler\n'
    '\n'
    '## Found a spoiler?\n'
    'If you find a spoiler, I\'d love to know! Please report it to [wot-spoilers@silvermast.io](mailto:wot-spoilers@silvermast.io).\n';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {
  final SettingsService settings = SettingsService();
  bool _rememberLastSelectedBook = false;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Information'),
        centerTitle: true,
      ),
      body: ListView(
        padding: bodyPadding,
        children: [
          // TODO: Add markdown or richtext formatting
          MarkdownBody(
            data: markdownContent,
            onTapLink: (text, href, title) => openLink(href),
          ),
          // TODO cleanup
          const Divider(height: 32),
          MarkdownBody(
            data: '## Settings'
          ),
          CheckboxListTile(
            title: const Text('Remember last selected book'),
            subtitle: const Text('When opening the app you will automatically jump to the last book you selected.'),
            value: _rememberLastSelectedBook,
            onChanged: (bool? rememberLastBook) {
              setState(() {
                _rememberLastSelectedBook = rememberLastBook ?? false;
              });

              settings.setRememberLastSelectedBook(rememberLastBook ?? false);
            },
          ),
        ]
      ),
    );
  }
  Future<void> _loadSettings() async {
    bool remember = await settings.getRememberLastSelectedBook();
    setState(() {
      _rememberLastSelectedBook = remember;
    });
  }

  void openLink(String? href) {
    if (href == null) {
      return null;
    }
    launchUrlString(href);
  }
}
