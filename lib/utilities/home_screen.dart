import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sdapk_app/appointments/screens/appointments_screen.dart';
import 'package:sdapk_app/patients/providers/patient_provider.dart';
import 'package:sdapk_app/patients/screens/list_patients_screen.dart';
import 'package:sdapk_app/users/users_screen.dart';

import '../authentication/services/auth_service.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>  with SingleTickerProviderStateMixin {

  // we need a tab controller to control the selected tab programmatically
  late final TabController _tabController;

  @override
  void initState() {
    ref.read(patientsProvider.notifier).addPatients();
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                  onPressed: () => ref.read(authProvider).signOut(),
                  icon: const Icon(Icons.logout)),
            ],
            bottom:  TabBar(
              controller: _tabController,
              tabs: [
                Tab(icon: Icon(Icons.schedule), text: 'Appointments'),
                Tab(icon: Icon(Icons.sick), text: 'Patients'),
                Tab(icon: Icon(Icons.groups_rounded), text: 'Staff'),
              ],
            ),
            title: const Text(
              'Ayurvaidik Parishkar Kendra',
              textAlign: TextAlign.center,
            ),
          ),
          body:  TabBarView(
            controller: _tabController,
            children: [
              AppointmentsScreen(
                createAppointment: (){
                  print("appointment screen");
                  setState(() {
                    print("appointment screen set state");
                    _tabController.index = 1;
                  });
                },
              ),
              ListPatientsScreen(),
              StaffScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
