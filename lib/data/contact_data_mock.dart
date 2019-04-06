import 'contact_data.dart';
import 'dart:async';

class ContactDataMock implements ContactRepository{

  @override
  Future<List<Contact>> fetch() {
    return Future.value(kContact);
  }

}

const kContact = const <Contact>[
  const Contact(
    fullname: 'Romain Hoogmed',
    email: 'Zuhdan Nur Ihsan'
  ),
  const Contact(
    fullname: 'Lala',
    email: 'Lal@mail.com'
  )
];