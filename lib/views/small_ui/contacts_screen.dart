import 'package:flutter/material.dart';
import 'package:shakti_contact/views/small_ui/contacts_details_page.dart';
import '../../models/contact.dart';

class ContactsScreen extends StatefulWidget {
  @override
  _ContactsScreenState createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  late TextEditingController _searchController;
  late List<Contact> allContacts;
  late List<Contact> filtered;
  List<Contact> favourites = [];

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    allContacts = [
      Contact(
        name: 'Mehdi Hasan',
        email: 'mehdi@example.com',
        phone: '1234567890',
        post: 'ICT support Engineer',
        location: 'Bogura',
        description: 'Mehdi is a software engineer with 5 years of Flutter experience. Mehdi is a software engineer with 5 years of Flutter experience.Mehdi is a software engineer with 5 years of Flutter experience.Mehdi is a software engineer with 5 years of Flutter experience.Mehdi is a software engineer with 5 years of Flutter experience.',
      ),
      Contact(
        name: 'Rokey Sheik',
        email: 'roky@example.com',
        phone: '2345678901',
        post: 'ICT support Engineer',
        location: 'Gazipur',
        description: 'Roky is a UI/UX designer with a passion for user-centered design. Roky is a UI/UX designer with a passion for user-centered design.Roky is a UI/UX designer with a passion for user-centered design.Roky is a UI/UX designer with a passion for user-centered design.Roky is a UI/UX designer with a passion for user-centered design.',
      ),
      Contact(
        name: 'Sohel Rana',
        email: 'sohel@example.com',
        phone: '3456789012',
        post: 'ICT support Engineer',
        location: 'Rangpur',
        description: 'Sohel is a backend developer specializing in Node.js and APIs. Sohel is a backend developer specializing in Node.js and APIs.',
      ),
      Contact(
        name: 'Shamim Hossain',
        email: 'Shamim@example.com',
        phone: '3456789012',
        post: 'ICT support Engineer',
        location: 'Sirajgonj',
        description: 'Shamim is a backend developer specializing in Node.js and APIs. Shamim is a backend developer specializing in Node.js and APIs.Shamim is a backend developer specializing in Node.js and APIs.Shamim is a backend developer specializing in Node.js and APIs.',
      ),
    ];
    filtered = List.from(allContacts);
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    final q = _searchController.text.toLowerCase();
    setState(() {
      filtered = allContacts.where((c) =>
      c.name.toLowerCase().contains(q) || c.email.toLowerCase().contains(q)).toList();
    });
  }

  void _toggleFav(Contact c) {
    setState(() {
      if (favourites.contains(c)) {
        favourites.remove(c);
      } else {
        favourites.add(c);
      }
    });
  }

  bool _isFav(Contact c) => favourites.contains(c);

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Widget _contactCard(Contact c) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => ContactDetailsPage(contact: c)),
        );
      },
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: ListTile(
          leading: CircleAvatar(child: Icon(Icons.person)),
          title: Text(c.name),
          subtitle: Text(c.email),
          trailing: Wrap(
            spacing: 4,
            children: [
              IconButton(
                icon: Icon(Icons.call, color: Colors.green),
                onPressed: () {
                  // Implement call functionality if needed
                },
              ),
              IconButton(
                icon: Icon(
                  _isFav(c) ? Icons.favorite : Icons.favorite_border,
                  color: Colors.red,
                ),
                onPressed: () => _toggleFav(c),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNestedZones() {
    return SingleChildScrollView(
      child: Card(
        margin: EdgeInsets.all(8),
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            ExpansionTile(
              title: Text('Bogura Zoon'),
              children: [
                ExpansionTile(
                  title: Text('Mymensingh Region'),
                  children: [
                    ExpansionTile(
                      title: Text('Sadar Mymensingh'),
                      children: [
                        ExpansionTile(
                          title: Text('Sadar Mymensingh-0134'),
                          children: filtered.map((contact) => _contactCard(contact)).toList(),
                        ),
                        ExpansionTile(
                          title: Text('Muktagacha Mymensingh-0171'),
                        ),
                        ExpansionTile(
                          title: Text('Valuka Mymensingh-0169'),
                        ),
                        ExpansionTile(
                          title: Text('Fulbaria Mymensingh-0227'),
                        ),
                        ExpansionTile(
                          title: Text('Trishal Mymensingh-0339'),
                        ),
                      ],
                      // children: filtered.map((contact) => _contactCard(contact)).toList(),
                    ),
                    ExpansionTile(title: Text('Gouripur Mymensingh'), children: []),
                    ExpansionTile(title: Text('Jamalpur'), children: []),
                    ExpansionTile(title: Text('Sherpur'), children: []),
                  ],
                ),
              ],
            ),
            ExpansionTile(
              title: Text('Dhaka Zoon'),
              children: [
                ExpansionTile(
                  title: Text('Mymensingh Region'),
                  children: [
                    ExpansionTile(
                      title: Text('Sadar Mymensingh'),
                      children: [
                        ExpansionTile(
                          title: Text('Sadar Mymensingh-0134'),
                          children: filtered.map((contact) => _contactCard(contact)).toList(),
                        ),
                        ExpansionTile(
                          title: Text('Muktagacha Mymensingh-0171'),
                        ),
                        ExpansionTile(
                          title: Text('Valuka Mymensingh-0169'),
                        ),
                        ExpansionTile(
                          title: Text('Fulbaria Mymensingh-0227'),
                        ),
                        ExpansionTile(
                          title: Text('Trishal Mymensingh-0339'),
                        ),
                      ],
                      // children: filtered.map((contact) => _contactCard(contact)).toList(),
                    ),
                    ExpansionTile(title: Text('Gouripur Mymensingh'), children: []),
                    ExpansionTile(title: Text('Jamalpur'), children: []),
                    ExpansionTile(title: Text('Sherpur'), children: []),
                  ],
                ),
              ],
            ),
            ExpansionTile(
              title: Text('Cumilla Zoon'),
              children: [
                ExpansionTile(
                  title: Text('Mymensingh Region'),
                  children: [
                    ExpansionTile(
                      title: Text('Sadar Mymensingh'),
                      children: [
                        ExpansionTile(
                          title: Text('Sadar Mymensingh-0134'),
                          children: filtered.map((contact) => _contactCard(contact)).toList(),
                        ),
                        ExpansionTile(
                          title: Text('Muktagacha Mymensingh-0171'),
                        ),
                        ExpansionTile(
                          title: Text('Valuka Mymensingh-0169'),
                        ),
                        ExpansionTile(
                          title: Text('Fulbaria Mymensingh-0227'),
                        ),
                        ExpansionTile(
                          title: Text('Trishal Mymensingh-0339'),
                        ),
                      ],
                      // children: filtered.map((contact) => _contactCard(contact)).toList(),
                    ),
                    ExpansionTile(title: Text('Gouripur Mymensingh'), children: []),
                    ExpansionTile(title: Text('Jamalpur'), children: []),
                    ExpansionTile(title: Text('Sherpur'), children: []),
                  ],
                ),
              ],
            ),
            ExpansionTile(
              title: Text('Jassor Zoon'),
              children: [
                ExpansionTile(
                  title: Text('Mymensingh Region'),
                  children: [
                    ExpansionTile(
                      title: Text('Sadar Mymensingh'),
                      children: [
                        ExpansionTile(
                          title: Text('Sadar Mymensingh-0134'),
                          children: filtered.map((contact) => _contactCard(contact)).toList(),
                        ),
                        ExpansionTile(
                          title: Text('Muktagacha Mymensingh-0171'),
                        ),
                        ExpansionTile(
                          title: Text('Valuka Mymensingh-0169'),
                        ),
                        ExpansionTile(
                          title: Text('Fulbaria Mymensingh-0227'),
                        ),
                        ExpansionTile(
                          title: Text('Trishal Mymensingh-0339'),
                        ),
                      ],
                      // children: filtered.map((contact) => _contactCard(contact)).toList(),
                    ),
                    ExpansionTile(title: Text('Gouripur Mymensingh'), children: []),
                    ExpansionTile(title: Text('Jamalpur'), children: []),
                    ExpansionTile(title: Text('Sherpur'), children: []),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext ctx) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Contacts'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Contacts', icon: Icon(Icons.contacts)),
              Tab(text: 'Favourite', icon: Icon(Icons.favorite)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search contacts...',
                      prefixIcon: Icon(Icons.search),
                      border: UnderlineInputBorder(),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 2),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Expanded(
                    child: _searchController.text.isNotEmpty
                        ? (filtered.isEmpty
                        ? Center(child: Text('No contacts found.'))
                        : ListView.builder(
                      itemCount: filtered.length,
                      itemBuilder: (_, i) => _contactCard(filtered[i]),
                    ))
                        : _buildNestedZones(),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: favourites.isEmpty
                  ? Center(child: Text('No favourites yet.'))
                  : ListView.builder(
                itemCount: favourites.length,
                itemBuilder: (_, i) => _contactCard(favourites[i]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
