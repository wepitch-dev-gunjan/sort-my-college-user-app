import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:myapp/shared/colors_const.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() {
    return _HelpScreenState();
  }
}

class _HelpScreenState extends State<HelpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController subjectController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  List<String> attachments = [];
  String? platformResponse;

  @override
  void dispose() {
    subjectController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsConst.whiteColor,
      appBar: AppBar(
        surfaceTintColor: ColorsConst.whiteColor,
        backgroundColor: ColorsConst.whiteColor,
        leading: Padding(
          padding: const EdgeInsets.only(left: 0, top: 18, bottom: 18),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Image.asset(
              'assets/page-1/images/back.png',
              color: const Color(0xff1F0A68),
            ),
          ),
        ),
        titleSpacing: -1,
        title: const Text(
          "Help",
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Color(0xff1F0A68),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Submit a query',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Love something or facing an issue? Share your feedback or report a problem. Your insights help shape our future updates!',
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 30),
                TextFormField(
                  controller: subjectController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a subject';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Subject',
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: descriptionController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Description',
                  ),
                  maxLines: 4,
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      String subject = subjectController.text;
                      String description = descriptionController.text;
                      final Email email = Email(
                        body: description,
                        subject: subject,
                        recipients: ['help@sortmycollege.com'],
                        isHTML: false,
                      );
                      await FlutterEmailSender.send(email);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(8),
                      backgroundColor: const Color(0xff1F0A68),
                    ),
                    child: const Text(
                      'Submit Query',
                      style: TextStyle(
                          color: ColorsConst.whiteColor, fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
