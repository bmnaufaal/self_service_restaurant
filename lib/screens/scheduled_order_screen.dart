import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lunapos_akpsi/screens/home_screen.dart';
import 'package:lunapos_akpsi/widgets/buttons/primary_button.dart';
import 'package:lunapos_akpsi/widgets/inputs/form_input.dart';
import 'package:lunapos_akpsi/widgets/inputs/number_input.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ScheduledOrderScreen extends StatefulWidget {
  ScheduledOrderScreen({
    super.key,
    required this.onChangeLanguage,
  });

  dynamic? onChangeLanguage;

  @override
  State<ScheduledOrderScreen> createState() => _ScheduledOrderScreenState();
}

class _ScheduledOrderScreenState extends State<ScheduledOrderScreen> {
  bool isStarted = false;
  final Map<String, TextEditingController> controller = {
    'date': TextEditingController(),
    'time': TextEditingController(),
    'guest': TextEditingController(),
  };

  @override
  void dispose() {
    for (var controller in controller.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    controller['guest']!.text = '3';
  }

  String formatTimeOfDay(TimeOfDay timeOfDay) {
    final String hour = timeOfDay.hour.toString().padLeft(2, '0');
    final String minute = timeOfDay.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: (isStarted == false)
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 32),
                Text(
                  AppLocalizations.of(context)!.youDontHaveAnyScheduleYet,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 24,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                PrimaryButton(
                  title: AppLocalizations.of(context)!.scheduledOrder,
                  onPressed: () {
                    setState(() {
                      isStarted = true;
                    });
                  },
                ),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.date,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2024),
                    );

                    if (pickedDate != null) {
                      String formattedDate =
                          DateFormat('dd-MM-yyyy').format(pickedDate);
                      controller['date']!.text = formattedDate;
                    }
                  },
                  child: FormInput(
                    hintText: AppLocalizations.of(context)!.selectDate,
                    isDisabled: true,
                    controller: controller['date']!,
                    validator: (value) {
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  AppLocalizations.of(context)!.time,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: () async {
                    TimeOfDay? pickedTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );

                    if (pickedTime != null) {
                      String formattedTime = formatTimeOfDay(pickedTime);
                      controller['time']!.text = formattedTime;
                    }
                  },
                  child: FormInput(
                    hintText: AppLocalizations.of(context)!.selectTime,
                    isDisabled: true,
                    controller: controller['time']!,
                    validator: (value) {
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  AppLocalizations.of(context)!.guest,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                NumberTextField(
                  min: 3,
                  controller: controller['guest']!,
                ),
                const SizedBox(height: 16),
                Text(
                  AppLocalizations.of(context)!.minimumOrder,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: PrimaryButton(
                    title: AppLocalizations.of(context)!.startScheduledOrder,
                    onPressed: () {
                      if (controller['date']!.text != '' &&
                          controller['time']!.text != '') {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (_) {
                              return HomeScreen(
                                date: controller['date']!.text,
                                time: controller['time']!.text,
                                guest: controller['guest']!.text,
                                onChangeLanguage: widget.onChangeLanguage,
                              );
                            },
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
