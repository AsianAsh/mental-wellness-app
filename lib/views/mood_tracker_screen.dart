import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mental_wellness_app/widgets/emote_face.dart';
import 'package:mental_wellness_app/controllers/mood_tracker_controller.dart';

class MoodTrackerScreen extends StatefulWidget {
  const MoodTrackerScreen({Key? key}) : super(key: key);

  @override
  _MoodTrackerScreenState createState() => _MoodTrackerScreenState();
}

class _MoodTrackerScreenState extends State<MoodTrackerScreen> {
  late MoodTrackerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = MoodTrackerController();
    _controller.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MoodTrackerController>(
      create: (_) => _controller,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Mood Tracker'),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTodayCheckInCard(context),
                const SizedBox(height: 20),
                _buildTrackerHistoryCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTodayCheckInCard(BuildContext context) {
    return Consumer<MoodTrackerController>(
      builder: (context, controller, child) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.indigo[600],
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.cloud, color: Colors.purple[300]),
                  const SizedBox(width: 8),
                  Text(
                    "Today's check-in",
                    style: TextStyle(
                      color: Colors.purple[300],
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    controller.selectedMood == null
                        ? 'How you feeling today?'
                        : "You're feeling ${controller.selectedMood}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (controller.selectedMood != null)
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.white),
                      onPressed: () {
                        controller.showMoodSelectionModal(context);
                      },
                    ),
                ],
              ),
              if (controller.selectedMood == null)
                Column(
                  children: [
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: controller.moods.map((mood) {
                        return GestureDetector(
                          onTap: () {
                            controller.selectMood(
                                mood['emoticon']!, mood['text']!, context);
                          },
                          child: Column(
                            children: [
                              EmoticonFace(emoticonFace: mood['emoticon']!),
                              const SizedBox(height: 5),
                              Text(
                                mood['text']!,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              if (controller.selectedMoodText != null)
                Text(
                  controller.selectedMoodText!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              const SizedBox(height: 20),
              if (controller.selectedMood != null)
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        controller.showAddNoteBottomSheet(context);
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Text(
                          controller.isNoteFilled ? 'Edit Note' : 'Add Note'),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTrackerHistoryCard() {
    return Consumer<MoodTrackerController>(
      builder: (context, controller, child) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.indigo[600],
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ChoiceChip(
                    label: const Text('Week',
                        style: TextStyle(color: Colors.white)),
                    selected: controller.isWeeklyView,
                    backgroundColor: Colors.indigo,
                    selectedColor: Colors.purple,
                    onSelected: (bool selected) {
                      if (selected) {
                        controller.setView(true);
                      }
                    },
                  ),
                  ChoiceChip(
                    label: const Text('Month',
                        style: TextStyle(color: Colors.white)),
                    selected: !controller.isWeeklyView,
                    backgroundColor: Colors.indigo,
                    selectedColor: Colors.purple,
                    onSelected: (bool selected) {
                      if (selected) {
                        controller.setView(false);
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Text(
                'Mood Check-ins',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              _buildMoodEntriesList(controller),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16.0),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.indigo[800],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    controller.moodEntries.length < 7
                        ? Text(
                            '${controller.remainingCheckIns} check-ins left',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : Column(
                            children: [
                              const Text(
                                'Mood Score',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                width: 120,
                                height: 120,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: controller.moodScoreColor,
                                    width: 10,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    '${controller.moodScorePercentage.round()}%',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              _buildMoodMessage(controller.moodScorePercentage),
                            ],
                          ),
                    if (controller.moodEntries.length < 7)
                      const Text(
                        'Track your moods a bit longer to unlock the mood score',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMoodEntriesList(MoodTrackerController controller) {
    if (controller.isWeeklyView) {
      return Container(
        height: 90,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: controller.moodEntries.length,
          itemBuilder: (context, index) {
            Map<String, dynamic> moodEntry = controller.moodEntries[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: GestureDetector(
                onTap: () =>
                    controller.showMoodDetailsModal(context, moodEntry),
                child: Container(
                  width: 40,
                  decoration: BoxDecoration(
                    color: controller.getMoodColor(moodEntry['mood']),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            );
          },
        ),
      );
    } else {
      return Container(
        height: 90,
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 10,
            mainAxisSpacing: 2,
            crossAxisSpacing: 2,
          ),
          itemCount: controller.moodEntries.length,
          itemBuilder: (context, index) {
            Map<String, dynamic> moodEntry = controller.moodEntries[index];
            return GestureDetector(
              onTap: () => controller.showMoodDetailsModal(context, moodEntry),
              child: Container(
                decoration: BoxDecoration(
                  color: controller.getMoodColor(moodEntry['mood']),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            );
          },
        ),
      );
    }
  }

  Widget _buildMoodMessage(double moodScorePercentage) {
    if (moodScorePercentage < 25) {
      return const Text(
        'It seems like you have been feeling down lately. Consider booking a counseling appointment.',
        style: TextStyle(
          color: Colors.white70,
          fontSize: 14,
        ),
        textAlign: TextAlign.center,
      );
    } else if (moodScorePercentage < 50) {
      return const Text(
        'You have been feeling a bit low. Take some time for self-care and reach out to friends and family.',
        style: TextStyle(
          color: Colors.white70,
          fontSize: 14,
        ),
        textAlign: TextAlign.center,
      );
    } else if (moodScorePercentage < 75) {
      return const Text(
        'You have been doing okay. Keep maintaining your well-being and stay positive!',
        style: TextStyle(
          color: Colors.white70,
          fontSize: 14,
        ),
        textAlign: TextAlign.center,
      );
    } else {
      return const Text(
        'Looks like you\'re doing great! Keep up the good work and continue to take care of yourself.',
        style: TextStyle(
          color: Colors.white70,
          fontSize: 14,
        ),
        textAlign: TextAlign.center,
      );
    }
  }
}
