// import 'package:flutter/material.dart';
// import '../models/helpline.dart';
// import '../services/firestore.dart';

// class HelplineScreen extends StatefulWidget {
//   const HelplineScreen({super.key});

//   @override
//   _HelplineScreenState createState() => _HelplineScreenState();
// }

// class _HelplineScreenState extends State<HelplineScreen> {
//   Map<String, CountryHelpline>? helplines;
//   String? selectedCountry;
//   CountryHelpline? selectedHelpline;

//   @override
//   void initState() {
//     super.initState();
//     FirestoreService().loadHelplines().then((data) {
//       setState(() {
//         helplines = data;
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Wellness Resources')),
//       body: helplines == null
//           ? Center(child: CircularProgressIndicator())
//           : Column(
//               children: [
//                 DropdownButton<String>(
//                   hint: Text('Select Country'),
//                   value: selectedCountry,
//                   items: helplines!.keys.map((String country) {
//                     return DropdownMenuItem<String>(
//                       value: country,
//                       child: Text(country),
//                     );
//                   }).toList(),
//                   onChanged: (newValue) {
//                     setState(() {
//                       selectedCountry = newValue;
//                       selectedHelpline = helplines![newValue!];
//                     });
//                   },
//                 ),
//                 Expanded(
//                   child: selectedHelpline == null
//                       ? Center(child: Text('Select a country to see helplines'))
//                       : ListView.builder(
//                           itemCount: selectedHelpline!.parsedBatches.length,
//                           itemBuilder: (context, index) {
//                             final helpline =
//                                 selectedHelpline!.parsedBatches[index];
//                             return ListTile(
//                               title: Text(helpline.description),
//                               subtitle: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: helpline.phones
//                                     .map((phone) => Text(phone))
//                                     .toList(),
//                               ),
//                             );
//                           },
//                         ),
//                 ),
//               ],
//             ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:mental_wellness_app/models/helpline.dart';
// import 'package:mental_wellness_app/services/firestore.dart';
// import 'package:mental_wellness_app/widgets/help_article_card.dart';

// class WellnessResourcesScreen extends StatefulWidget {
//   @override
//   _WellnessResourcesScreenState createState() =>
//       _WellnessResourcesScreenState();
// }

// class _WellnessResourcesScreenState extends State<WellnessResourcesScreen> {
//   Map<String, CountryHelpline>? helplines;
//   String? selectedCountry;
//   CountryHelpline? selectedHelpline;
//   bool showHelplines = false;

//   @override
//   void initState() {
//     super.initState();
//     FirestoreService().loadHelplines().then((data) {
//       setState(() {
//         helplines = data;
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final List<Map<String, String>> articles = [
//       {
//         'title': 'Building Better Mental Health',
//         'url':
//             'https://www.helpguide.org/articles/mental-health/building-better-mental-health.htm',
//         'website': 'HelpGuide'
//       },
//       {
//         'title': 'More Than Moody. Could It Be Depression?',
//         'url': 'https://mentalhealth.com.my',
//         'website': 'Relate Mental Health Malaysia'
//       },
//       {
//         'title': 'All in My Head: OCD and Mental Health Anxiety',
//         'url':
//             'https://www.sheppardpratt.org/news-views/story/all-in-my-head-ocd-and-mental-health-anxiety/',
//         'website': 'Sheppard Pratt'
//       },
//       // Add more articles
//     ];

//     return Scaffold(
//       appBar: AppBar(title: Text('Help Resources')),
//       body: helplines == null
//           ? Center(child: CircularProgressIndicator())
//           : SingleChildScrollView(
//               child: Column(
//                 children: [
//                   Container(
//                     padding: EdgeInsets.all(8.0),
//                     child: DropdownButton<String>(
//                       isExpanded: true,
//                       hint: Text('Select Country',
//                           style: TextStyle(color: Colors.white)),
//                       value: selectedCountry,
//                       items: helplines!.keys.map((String country) {
//                         return DropdownMenuItem<String>(
//                           value: country,
//                           child: Text(country,
//                               style: TextStyle(color: Colors.white)),
//                         );
//                       }).toList(),
//                       onChanged: (newValue) {
//                         setState(() {
//                           selectedCountry = newValue;
//                           selectedHelpline = helplines![newValue!];
//                           showHelplines = true;
//                         });
//                       },
//                       dropdownColor: Colors.indigo[700],
//                     ),
//                   ),
//                   if (showHelplines && selectedHelpline != null)
//                     Column(
//                       children: [
//                         Divider(color: Colors.white),
//                         ExpansionTile(
//                           title: Text(
//                             'Helplines for $selectedCountry',
//                             style: TextStyle(color: Colors.white),
//                           ),
//                           initiallyExpanded: true,
//                           children:
//                               selectedHelpline!.parsedBatches.map((helpline) {
//                             return ListTile(
//                               title: Text(
//                                 helpline.description,
//                                 style: TextStyle(color: Colors.white),
//                               ),
//                               subtitle: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: helpline.phones
//                                     .map((phone) => Text(
//                                           phone,
//                                           style: TextStyle(
//                                               color: Colors.blueAccent),
//                                         ))
//                                     .toList(),
//                               ),
//                               contentPadding: EdgeInsets.symmetric(
//                                   horizontal: 16, vertical: 8),
//                               tileColor: Colors.indigo[800],
//                             );
//                           }).toList(),
//                           tilePadding:
//                               EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                           collapsedBackgroundColor: Colors.indigo[800],
//                           backgroundColor: Colors.indigo[800],
//                           iconColor: Colors.white,
//                         ),
//                         Divider(color: Colors.white),
//                       ],
//                     ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Text(
//                       'Mental Health Articles',
//                       style: TextStyle(fontSize: 18, color: Colors.white),
//                     ),
//                   ),
//                   ListView.builder(
//                     shrinkWrap: true,
//                     physics: NeverScrollableScrollPhysics(),
//                     itemCount: articles.length,
//                     itemBuilder: (context, index) {
//                       return ArticleCard(
//                         title: articles[index]['title']!,
//                         url: articles[index]['url']!,
//                         website: articles[index]['website']!,
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             ),
//       backgroundColor: Colors.indigo[900],
//     );
//   }
// }

// better visual design
import 'package:flutter/material.dart';
import 'package:mental_wellness_app/models/helpline.dart';
import 'package:mental_wellness_app/services/firestore.dart';
import 'package:mental_wellness_app/widgets/help_article_card.dart';

class WellnessResourcesScreen extends StatefulWidget {
  @override
  _WellnessResourcesScreenState createState() =>
      _WellnessResourcesScreenState();
}

class _WellnessResourcesScreenState extends State<WellnessResourcesScreen> {
  Map<String, CountryHelpline>? helplines;
  String? selectedCountry;
  CountryHelpline? selectedHelpline;
  bool showHelplines = false;

  @override
  void initState() {
    super.initState();
    FirestoreService().loadHelplines().then((data) {
      setState(() {
        helplines = data;
      });
    });
  }

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
      body: helplines == null
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
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
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: DropdownButton<String>(
                              isExpanded: true,
                              hint: Text('Select Country',
                                  style: TextStyle(color: Colors.black)),
                              value: selectedCountry,
                              items: helplines!.keys.map((String country) {
                                return DropdownMenuItem<String>(
                                  value: country,
                                  child: Text(country,
                                      style: TextStyle(color: Colors.black)),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                setState(() {
                                  selectedCountry = newValue;
                                  selectedHelpline = helplines![newValue!];
                                  showHelplines = true;
                                });
                              },
                              dropdownColor: Colors.white,
                            ),
                          ),
                          if (showHelplines && selectedHelpline != null)
                            Column(
                              children: [
                                Column(
                                  children: selectedHelpline!.parsedBatches
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
                                      showHelplines
                                          ? Icons.expand_less
                                          : Icons.expand_more,
                                      color: Colors.black,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        showHelplines = !showHelplines;
                                      });
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
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black),
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
            ),
      backgroundColor: Colors.indigo[900],
    );
  }
}
