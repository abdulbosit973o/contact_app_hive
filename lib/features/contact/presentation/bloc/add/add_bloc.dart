import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/local/hive/hive_helper.dart';
import '../../../data/model/contact_data.dart';

part 'add_event.dart';

part 'add_state.dart';

class AddBloc extends Bloc<AddEvent, AddState> {
  final HiveHelper _hiveHelper;

  AddBloc(this._hiveHelper) : super(AddInitial()) {
    on<AddContact>((event, emit) {
      _addContact(event.contactData);
      emit(AddSuccess());
    });
  }

  void _addContact(ContactData contactData) async {
    await _hiveHelper.addContactData(contactData);
  }
}
