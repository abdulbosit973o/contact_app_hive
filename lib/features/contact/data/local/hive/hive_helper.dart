import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import '../../model/contact_data.dart';

class HiveHelper {
  static const String boxName = 'contacts_box';

  static Future<void> initializeHive() async {
    await Hive.initFlutter();
    Hive.registerAdapter(ContactDataAdapter());
    await Hive.openBox<ContactData>(boxName);
  }

  Future<void> addContactData(ContactData contact) async {
    final box = Hive.box<ContactData>(boxName);
    await box.add(contact);
  }

  Future<ContactData?> getContactData(int id) async {
    final box = Hive.box<ContactData>(boxName);
    return box.get(id);
  }

  Future<void> updateContactData(ContactData contact) async {
    await contact.save();
  }

  Future<void> deleteContactData(int id) async {
    final box = Hive.box<ContactData>(boxName);
    await box.delete(id);
  }

  Future<List<ContactData>> getAllContactData() async {
    final box = Hive.box<ContactData>(boxName);
    return box.values.toList().cast<ContactData>();
  }
}
