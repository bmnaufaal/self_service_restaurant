import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lunapos_akpsi/screens/home_screen.dart';
import 'package:lunapos_akpsi/widgets/buttons/primary_button.dart';
import 'package:lunapos_akpsi/widgets/inputs/form_input.dart';
import 'package:lunapos_akpsi/widgets/inputs/number_input.dart';

class ScheduledOrderScreen extends StatefulWidget {
  const ScheduledOrderScreen({super.key});

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
                const Text(
                  'Anda belum memiliki jadwal pesanan',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(height: 16),
                PrimaryButton(
                  title: 'Jadwal Pesanan',
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
                const Text(
                  'Tanggal',
                  style: TextStyle(
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
                    hintText: 'Pilih tanggal',
                    isDisabled: true,
                    controller: controller['date']!,
                    validator: (value) {
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Time',
                  style: TextStyle(
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
                    hintText: 'Pilih waktu',
                    isDisabled: true,
                    controller: controller['time']!,
                    validator: (value) {
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Tamu',
                  style: TextStyle(
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
                const Text(
                  'Pemesanan minimum untuk pesanan terjadwal: Rp50.000/orang',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: PrimaryButton(
                    title: 'Mulai Jadwal Pesanan',
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
