import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sdapk_app/users/providers/doctors_provider.dart';
import 'package:sdapk_app/users/screens/list_doctors_screen.dart';
import 'package:sdapk_app/users/screens/list_therapists_screen.dart';

class StaffScreen extends ConsumerStatefulWidget {
  const StaffScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _StaffScreenState();
}

class _StaffScreenState extends ConsumerState<StaffScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    ref.read(doctorsProvider.notifier).addDoctors();
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          TabBar(
            controller: _tabController,
            tabs: [
              Tab(
                icon: const Icon(Icons.schedule),
                child: Text(
                  'Doctors',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.errorContainer),
                ),
              ),
              Tab(
                icon: const Icon(Icons.sick),
                child: Text(
                  'Therapists',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.errorContainer),
                ),
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                ListDoctorsScreen(),
                ListTherapistsScreen()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
