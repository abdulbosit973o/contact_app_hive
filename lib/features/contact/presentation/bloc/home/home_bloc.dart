import 'package:bloc/bloc.dart';
import 'package:contact_app_hive/features/contact/presentation/screens/login/login_screen.dart';
import 'package:contact_app_hive/features/contact/presentation/widgets/custom_navigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../core/constants/constant.dart';
import '../../../data/local/hive/hive_helper.dart';
import '../../../data/local/shared_pref.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final BuildContext context;
  final SharedPreferencesHelper _pref;
  final HiveHelper _database;

  HomeBloc(this._pref, this._database, this.context) : super(HomeInitial()) {
    on<LoadContacts>(_onLoadContacts);
    on<DeleteContact>(_onDeleteContact);
    on<LogoutUser>(_onLogoutUser);
    on<UnregisterUser>(_onUnregisterUser);
  }

  void _onLoadContacts(LoadContacts event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    try {
      final contacts = await _database.getAllContactData();
      print('HomeBloc->LoadContacts->  ${contacts}');
      emit(HomeLoaded(contacts));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  void _onDeleteContact(DeleteContact event, Emitter<HomeState> emit) async {
    try {
      await event.contactId.delete();
      add(LoadContacts());
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  void _onLogoutUser(LogoutUser event, Emitter<HomeState> emit) async {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
          (Route<dynamic> route) => false,
    );
    await _pref.setBool(Constants.isVerified, false);

    //CustomNavigation.pushAndRemoveUntil(context, const LoginScreen());
    // Navigate to login screen
  }

  void _onUnregisterUser(UnregisterUser event, Emitter<HomeState> emit) async {
    await _pref.delete();
    // Navigate to login screen
  }
}
