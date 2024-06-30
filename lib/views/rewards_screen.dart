import 'package:flutter/material.dart';

class RewardsScreen extends StatelessWidget {
  const RewardsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rewards',
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.indigo, // Distinct app bar color
      ),
      body: Container(
        color: Colors.indigo[800], // Background color of the entire screen
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white, // White background for the rewards section
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  RewardCard(
                    icon: Icons.card_giftcard,
                    title: 'Amazon Gift Card worth 5000 INR',
                    points: 1800,
                    onClaim: () {
                      // Claim reward functionality
                    },
                  ),
                  RewardCard(
                    icon: Icons.subscriptions,
                    title: 'Buy Prime Subscription for 800 points',
                    points: 800,
                    onClaim: () {
                      // Claim reward functionality
                    },
                  ),
                  RewardCard(
                    icon: Icons.fastfood,
                    title: 'Buy Coupon Code worth \$25',
                    points: 200,
                    onClaim: () {
                      // Claim reward functionality
                    },
                  ),
                  RewardCard(
                    icon: Icons.local_pizza,
                    title: 'Get 50 INR back to wallet',
                    points: 300,
                    onClaim: () {
                      // Claim reward functionality
                    },
                  ),
                  RewardCard(
                    icon: Icons.sports_soccer,
                    title: 'Redeem 10000 points to get Adidas Sneakers',
                    points: 10000,
                    onClaim: () {
                      // Claim reward functionality
                    },
                  ),
                  // Add more RewardCard widgets as needed
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class RewardCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final int points;
  final VoidCallback onClaim;

  const RewardCard({
    Key? key,
    required this.icon,
    required this.title,
    required this.points,
    required this.onClaim,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [
              Icon(icon, size: 40),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // Additional information if needed
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: onClaim,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Claim'),
              ),
            ],
          ),
        ),
        const Divider(), // Divider between reward cards
      ],
    );
  }
}
