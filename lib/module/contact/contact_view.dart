import 'package:flutter/material.dart';
import '../../data/contact_data.dart';
import 'contact_presenter.dart';

class ContactPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Contacts'),
      ),
      body: ContactList(),
    );
  }
}

class ContactList extends StatefulWidget {
  ContactList({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ContactListState();
  }
}

class _ContactListState extends State<ContactList>
    implements ContactListViewContact {
  ContactListPresenter _presenter;
  List<Contact> _contacts;
  bool _isSearching;

  _ContactListState() {
    _presenter = ContactListPresenter(this);
  }

  @override
  void initState() {
    super.initState();
    _isSearching = true;
    _presenter = ContactListPresenter(this);
    _presenter.loadContact();
  }

  @override
  Widget build(BuildContext context) {
    var widget;
    if (_isSearching) {
      widget = Center(
        child: Padding(
          padding: EdgeInsets.only(left: 16.0, right: 16.0),
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      widget = ListView(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        children: _buildContactList(),
      );
    }
    return widget;
  }

  @override
  void onLoadContactErros() {
    // TODO: implement onLoadContactErros
  }

  @override
  void onLoadContactsComplete(List<Contact> items) {
    if (items != null) {
      setState(() {
        _contacts = items;
        _isSearching = false;
      });
    }
  }

  List<_ContactListItem> _buildContactList() {
    return _contacts.map((contact) => _ContactListItem(contact)).toList();
  }
}

class _ContactListItem extends ListTile {
  _ContactListItem(Contact contact)
      : super(
            title: Text(contact.fullname),
            subtitle: Text(contact.email),
            leading: CircleAvatar(child: Text(contact.fullname[0])));
}
