import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../models/contact.dart';

class ContactDetailsPage extends StatefulWidget {
  final Contact contact;
  final VoidCallback? onToggleFavorite; // Optional callback

  const ContactDetailsPage({
    required this.contact,
    this.onToggleFavorite,
    Key? key,
  }) : super(key: key);

  @override
  State<ContactDetailsPage> createState() => _ContactDetailsPageState();
}

class _ContactDetailsPageState extends State<ContactDetailsPage> {
  late bool isFavorite;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.contact.isFavorite;
  }

  Future<void> _makePhoneCall(BuildContext ctx) async {
    final uri = Uri(scheme: 'tel', path: widget.contact.phone);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(content: Text('Could not launch phone app')),
      );
    }
  }

  Future<void> _sendEmail(BuildContext ctx) async {
    final uri = Uri(
      scheme: 'mailto',
      path: widget.contact.email,
      query: 'subject=Hello&body=Hi ${widget.contact.name},',
    );
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(content: Text('Could not open email app')),
      );
    }
  }

  void _toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
      widget.contact.isFavorite = isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Contact Details")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Top Image
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/user.png'),
            ),
            SizedBox(height: 12),

            //  User Name
            Text(
              widget.contact.name,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 24),

            //  Phone Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.contact.phone, style: TextStyle(fontSize: 16)),
                IconButton(
                  icon: Icon(Icons.call, color: Colors.green),
                  onPressed: () => _makePhoneCall(context),
                ),
              ],
            ),
            SizedBox(height: 12),

            //  Email Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.contact.email, style: TextStyle(fontSize: 16)),
                IconButton(
                  icon: Icon(Icons.email, color: Colors.blue),
                  onPressed: () => _sendEmail(context),
                ),
              ],
            ),
            SizedBox(height: 16),

            //  Description
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                widget.contact.description,
                style: TextStyle(fontSize: 14, color: Colors.grey[700]),
              ),
            ),
            Spacer(),

            //  Favorite Button
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton.icon(
                  onPressed: _toggleFavorite,
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: Colors.white,
                  ),
                  label: Text('Favorite'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isFavorite ? Colors.red : Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
