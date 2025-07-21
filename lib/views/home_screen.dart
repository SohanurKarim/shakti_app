import 'package:flutter/material.dart';
import 'package:shakti_contact/views/erp_page/erp_site.dart';
import 'package:shakti_contact/views/small_ui/contacts_screen.dart' show ContactsScreen;

class HomeScreen extends StatefulWidget {
  final VoidCallback onToggleTheme;
  final bool isDarkMode;

  HomeScreen({required this.onToggleTheme, required this.isDarkMode});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  late List<GridItem> items;

  @override
  void initState() {
    super.initState();
    items = [
      GridItem(
        icon: Icons.contacts,
        title: 'Contacts',
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ContactsScreen()),
          );
        },
      ),
      GridItem(
        icon: Icons.business,
        title: 'ERP',
        onTap: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ERPSite()),
          );
        },
      ),
      GridItem(
        icon: Icons.play_arrow,
        title: 'Play',
        onTap: () => print('Play'),
      ),
      GridItem(
        icon: Icons.settings,
        title: 'Settings',
        onTap: () {
          // Navigation logic
        },
      ),
      GridItem(
        icon: Icons.person,
        title: 'Profile',
        onTap: () => print('Profile'),
      ),
      GridItem(
        icon: Icons.info,
        title: 'About',
        onTap: () => print('About'),
      ),
    ];
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue, // or any other full background color
              ),
              margin: EdgeInsets.zero, // Important: removes default margin
              padding:
                  EdgeInsets
                      .zero, // Optional: removes inner padding for full bleed
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.person, size: 30, color: Colors.blue),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'John Doe',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    Text(
                      'john.doe@example.com',
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  /// 🔽 Expandable Settings section
                  ExpansionTile(
                    leading: Icon(Icons.settings),
                    title: Text('Settings'),
                    children: [
                      SwitchListTile(
                        secondary: Icon(
                          widget.isDarkMode
                              ? Icons.dark_mode
                              : Icons.light_mode,
                        ),
                        title: Text('Dark Mode'),
                        value: widget.isDarkMode,
                        onChanged: (value) {
                          Navigator.pop(context); // optional
                          widget.onToggleTheme();
                        },
                      ),
                    ],
                  ),

                  ListTile(
                    leading: Icon(Icons.account_circle),
                    title: Text('Profile'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/profile');
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.info),
                    title: Text('About'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/about');
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.logout),
                    title: Text('Logout'),
                    onTap: () {
                      Navigator.pop(context);
                      // Handle logout logic
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'App version 1.0.0',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ],
        ),
      ),

      appBar: AppBar(
        leading: Builder(
          builder:
              (context) => IconButton(
                icon: Icon(Icons.menu),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
        ),
        title: Row(
          children: [
            Text('John Doe', style: TextStyle(fontSize: 16)),
            SizedBox(width: 8),
          ],
        ),
        actions: [
          // You can optionally remove this if theme is toggled via drawer
          // IconButton(
          //   icon: Icon(widget.isDarkMode ? Icons.light_mode : Icons.dark_mode),
          //   onPressed: widget.onToggleTheme,
          // ),
          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert),
            onSelected: (value) {
              if (value == 'logout') {
                // Handle logout
              }
            },
            itemBuilder:
                (BuildContext context) => [
                  PopupMenuItem<String>(value: 'logout', child: Text('Logout')),
                ],
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          itemCount: items.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1,
          ),
          itemBuilder: (context, index) {
            final item = items[index];
            return InkWell(
              onTap: item.onTap,
              borderRadius: BorderRadius.circular(16),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.teal.shade100,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(item.icon, size: 40, color: Colors.teal[800]),
                    SizedBox(height: 12),
                    Text(
                      item.title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.teal[900],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      // bottomNavigationBar: BottomBar(),
    );
  }
}

class GridItem {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  GridItem({required this.icon, required this.title, required this.onTap});
}
