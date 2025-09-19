import 'package:flutter/material.dart';
import 'package:meditation_app/pages/sign_in_page.dart';
import 'package:meditation_app/pages/start_page.dart';
import 'package:meditation_app/providers/user_provider.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({
    super.key,
  });

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final List<String> availableGoals = [
    "Reduce Stress",
    "Increase Happiness",
    "Personal Growth", 
    "Improve Performance",
    "Reduce Anxiety",
    "Better Sleep"
  ];

  final List<String> availableDays = [
    "Monday", "Tuesday", "Wednesday", "Thursday", 
    "Friday", "Saturday", "Sunday"
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<UserProvider>(
        builder: (context, userProvider, child) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildProfileHeader(context, userProvider),
                const SizedBox(height: 24),
                
                _buildUserInfoCard(userProvider),
                const SizedBox(height: 24),
                
                _buildGoalsSection(userProvider),
                const SizedBox(height: 24),
                
                _buildRemindersSection(userProvider),
                const SizedBox(height: 32),
                
                OwnTextButton(
                  text: "LOG OUT", 
                  backgroundColor: Color(0xff8E97FD),
                  callback: () {
                    userProvider.clearAll();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => StartPage()),
                      (route) => false,
                    );
                  }
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context, UserProvider userProvider) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Color(0xff8E97FD),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.white,
            child: Icon(
              Icons.person,
              size: 40,
              color: Color(0xff8E97FD),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            userProvider.username,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          if (userProvider.email.isNotEmpty)
            Text(
              userProvider.email,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white.withOpacity(0.8),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildUserInfoCard(UserProvider userProvider) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Profile Information',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff3F414E),
                  ),
                ),
                IconButton(
                  onPressed: () => _showEditProfileDialog(userProvider),
                  icon: Icon(Icons.edit, color: Color(0xff8E97FD)),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildInfoRow(Icons.person, 'Username', userProvider.username),
            const SizedBox(height: 12),
            _buildInfoRow(Icons.email, 'Email', userProvider.email.isNotEmpty ? userProvider.email : 'Not provided'),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Color(0xff8E97FD)),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: 16,
                color: Color(0xff3F414E),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildGoalsSection(UserProvider userProvider) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Meditation Goals',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff3F414E),
                  ),
                ),
                IconButton(
                  onPressed: () => _showGoalsDialog(userProvider),
                  icon: Icon(Icons.add, color: Color(0xff8E97FD)),
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (userProvider.selectedGoals.isEmpty)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: Text(
                    'No goals selected yet.\nTap + to add your meditation goals.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 16,
                    ),
                  ),
                ),
              )
            else
              ...userProvider.selectedGoals.map((goal) => _buildGoalTile(goal, userProvider)),
          ],
        ),
      ),
    );
  }

  Widget _buildGoalTile(String goal, UserProvider userProvider) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Color(0xff8E97FD).withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: Icon(Icons.track_changes, color: Color(0xff8E97FD)),
        title: Text(
          goal,
          style: TextStyle(
            color: Color(0xff3F414E),
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: IconButton(
          onPressed: () => userProvider.removeGoal(goal),
          icon: Icon(Icons.delete, color: Colors.red[400]),
        ),
      ),
    );
  }

  Widget _buildRemindersSection(UserProvider userProvider) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Meditation Reminders',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff3F414E),
                  ),
                ),
                IconButton(
                  onPressed: () => _showReminderDialog(userProvider),
                  icon: Icon(Icons.add, color: Color(0xff8E97FD)),
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (userProvider.reminders.isEmpty)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: Text(
                    'No reminders set yet.\nTap + to add meditation reminders.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 16,
                    ),
                  ),
                ),
              )
            else
              ...userProvider.reminders.map((reminder) => _buildReminderTile(reminder, userProvider)),
          ],
        ),
      ),
    );
  }

  Widget _buildReminderTile(String reminder, UserProvider userProvider) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Color(0xff8E97FD).withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: Icon(Icons.notifications, color: Color(0xff8E97FD)),
        title: Text(
          reminder,
          style: TextStyle(
            color: Color(0xff3F414E),
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: IconButton(
          onPressed: () => userProvider.removeReminder(reminder),
          icon: Icon(Icons.delete, color: Colors.red[400]),
        ),
      ),
    );
  }

  void _showEditProfileDialog(UserProvider userProvider) {
    final usernameController = TextEditingController(text: userProvider.username);
    final emailController = TextEditingController(text: userProvider.email);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Edit Profile',
          style: TextStyle(color: Color(0xff3F414E), fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
                labelStyle: TextStyle(color: Color(0xff8E97FD)),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Color(0xff8E97FD)),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(color: Color(0xff8E97FD)),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Color(0xff8E97FD)),
                ),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xff8E97FD),
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              userProvider.changeUserName(usernameController.text);
              userProvider.changeEmail(emailController.text);
              Navigator.pop(context);
            },
            child: Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showGoalsDialog(UserProvider userProvider) {
    final selectedGoals = Set<String>.from(userProvider.selectedGoals);

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text(
            'Select Meditation Goals',
            style: TextStyle(color: Color(0xff3F414E), fontWeight: FontWeight.bold),
          ),
          content: SizedBox(
            width: double.maxFinite,
            height: 300,
            child: ListView(
              children: availableGoals.map((goal) => CheckboxListTile(
                title: Text(goal),
                value: selectedGoals.contains(goal),
                activeColor: Color(0xff8E97FD),
                onChanged: (bool? value) {
                  setState(() {
                    if (value == true) {
                      selectedGoals.add(goal);
                    } else {
                      selectedGoals.remove(goal);
                    }
                  });
                },
              )).toList(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel', style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xff8E97FD),
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                userProvider.updateSelectedGoals(selectedGoals.toList());
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  void _showReminderDialog(UserProvider userProvider) {
    TimeOfDay selectedTime = TimeOfDay(hour: 10, minute: 0);
    final selectedDays = <String>{};

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text(
            'Add Meditation Reminder',
            style: TextStyle(color: Color(0xff3F414E), fontWeight: FontWeight.bold),
          ),
          content: SizedBox(
            width: double.maxFinite,
            height: 400,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Time',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff3F414E),
                  ),
                ),
                const SizedBox(height: 8),
                InkWell(
                  onTap: () async {
                    final time = await showTimePicker(
                      context: context,
                      initialTime: selectedTime,
                    );
                    if (time != null) {
                      setState(() {
                        selectedTime = time;
                      });
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xff8E97FD)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      selectedTime.format(context),
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Days',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff3F414E),
                  ),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: ListView(
                    children: availableDays.map((day) => CheckboxListTile(
                      title: Text(day),
                      value: selectedDays.contains(day),
                      activeColor: Color(0xff8E97FD),
                      onChanged: (bool? value) {
                        setState(() {
                          if (value == true) {
                            selectedDays.add(day);
                          } else {
                            selectedDays.remove(day);
                          }
                        });
                      },
                    )).toList(),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel', style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xff8E97FD),
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                if (selectedDays.isNotEmpty) {
                  final timeString = selectedTime.format(context);
                  for (final day in selectedDays) {
                    userProvider.addReminder('$day at $timeString');
                  }
                }
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}