// help_resources_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mental_wellness_app/controllers/help_resources_controller.dart';
import 'package:mental_wellness_app/widgets/help_article_card.dart';

class WellnessResourcesScreen extends StatelessWidget {
  final HelpResourcesController _controller =
      Get.put(HelpResourcesController());

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> articles = [
      {
        'title': 'Building Better Mental Health',
        'url':
            'https://www.helpguide.org/articles/mental-health/building-better-mental-health.htm',
        'website': 'HelpGuide'
      },
      {
        'title': 'More Than Moody. Could It Be Depression?',
        'url': 'https://mentalhealth.com.my',
        'website': 'Relate Mental Health Malaysia'
      },
      {
        'title': 'All in My Head: OCD and Mental Health Anxiety',
        'url':
            'https://www.sheppardpratt.org/news-views/story/all-in-my-head-ocd-and-mental-health-anxiety/',
        'website': 'Sheppard Pratt'
      },
      // Add more articles
    ];

    return Scaffold(
      appBar: AppBar(title: Text('Help Resources')),
      body: Obx(() {
        if (_controller.helplines.value == null) {
          return Center(child: CircularProgressIndicator());
        } else {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Helplines',
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: DropdownButton<String>(
                            isExpanded: true,
                            hint: Text('Select Country',
                                style: TextStyle(color: Colors.black)),
                            value: _controller.selectedCountry.value,
                            items: _controller.helplines.value!.keys
                                .map((String country) {
                              return DropdownMenuItem<String>(
                                value: country,
                                child: Text(country,
                                    style: TextStyle(color: Colors.black)),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              _controller.setSelectedCountry(newValue);
                            },
                            dropdownColor: Colors.white,
                          ),
                        ),
                        if (_controller.showHelplines.value &&
                            _controller.selectedHelpline.value != null)
                          Column(
                            children: [
                              Column(
                                children: _controller
                                    .selectedHelpline.value!.parsedBatches
                                    .map((helpline) {
                                  return ListTile(
                                    title: Text(
                                      helpline.description,
                                      style: TextStyle(color: Colors.black),
                                      textAlign: TextAlign.justify,
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: helpline.phones
                                          .map((phone) => Text(
                                                phone,
                                                style: TextStyle(
                                                    color: Colors.blueAccent),
                                              ))
                                          .toList(),
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 8),
                                  );
                                }).toList(),
                              ),
                              Center(
                                child: IconButton(
                                  icon: Icon(
                                    _controller.showHelplines.value
                                        ? Icons.expand_less
                                        : Icons.expand_more,
                                    color: Colors.black,
                                  ),
                                  onPressed: () {
                                    _controller.showHelplines.value =
                                        !_controller.showHelplines.value;
                                  },
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Mental Health Articles',
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: articles.length,
                          itemBuilder: (context, index) {
                            return ArticleCard(
                              title: articles[index]['title']!,
                              url: articles[index]['url']!,
                              website: articles[index]['website']!,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      }),
      backgroundColor: Colors.indigo[900],
    );
  }
}
