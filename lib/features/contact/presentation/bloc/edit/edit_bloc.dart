import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../data/local/hive/hive_helper.dart';
import '../../../data/model/contact_data.dart';
import '../../widgets/custom_toast.dart';

part 'edit_event.dart';

part 'edit_state.dart';

class EditBloc extends Bloc<EditEvent, EditState> {
  final HiveHelper _database;

  EditBloc(this._database) : super(EditInitial()) {
    on<EditContact>((event, emit) async {
      emit(EditLoading());
      try {
        await _database.updateContactData(event.contactData);
        emit(EditSuccess());
      } catch (e) {
        emit(EditFailure(message: e.toString()));
      }
    });
  }
}

