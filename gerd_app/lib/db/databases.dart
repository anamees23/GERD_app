import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/widgets.dart';

// void main() async {
// // Avoid errors caused by flutter upgrade.
// // Importing 'package:flutter/widgets.dart' is required.
//   WidgetsFlutterBinding.ensureInitialized();
// // Open the database and store the reference.
//   final database = openDatabase(
//     // Set the path to the database. Note: Using the `join` function from the
//     // `path` package is best practice to ensure the path is correctly
//     // constructed for each platform.
//     join(await getDatabasesPath(), 'gerd_database.db'),

//     // When the database is first created, create a table to store database.
//     onCreate: (db, version) async {
//       // Run the CREATE TABLE statement on the database.
//       await db.execute(
//         'CREATE TABLE patient_info(first_name TEXT, last_name TEXT, mhr_number INT PRIMARY KEY, time_stamp DATETIME NOT NULL)',
//       );
//       await db.execute(
//         'CREATE TABLE doctor_info(email_id TEXT PRIMARY KEY, time_stamp DATETIME NOT NULL)',
//       );
//       await db.execute(
//         'CREATE TABLE ph_data(ph_value FLOAT NOT NULL, time_stamp DATETIME PRIMARY KEY)',
//       );
//       await db.execute(
//         'CREATE TABLE physical_activity(activity_status TEXT, start_time DATETIME PRIMARY KEY, end_time DATETIME NOT NULL, time_stamp DATETIME NOT NULL)',
//       );
//       await db.execute(
//         'CREATE TABLE meal_status(food TEXT, drink TEXT, start_time DATETIME PRIMARY KEY, end_time DATETIME NOT NULL, time_stamp DATETIME NOT NULL)',
//       );
//       await db.execute(
//         'CREATE TABLE symptoms_status(symptom TEXT, start_time DATETIME PRIMARY KEY, end_time DATETIME, time_stamp DATETIME NOT NULL)',
//       );
//       await db.execute(
//         'CREATE TABLE messages(message TEXT, time_stamp DATETIME PRIMARY KEY)',
//       );
//     },
//     // Set the version. This executes the onCreate function and provides a
//     // path to perform database upgrades and downgrades.
//     version: 1,
//   );

//   // Define a function that inserts patient info into the database
//   Future<void> insert_patient(patient_info patient) async {
//     // Get a reference to the database.
//     final db = await database;

//     // Insert the patient info into the correct table. You might also specify the
//     // `conflictAlgorithm` to use in case the same patient is inserted twice.
//     //
//     // In this case, replace any previous data.
//     await db.insert(
//       'patient_info',
//       patient.toMap(),
//       conflictAlgorithm: ConflictAlgorithm.replace,
//     );
//   }

//   // Define a function that inserts doctor info into the database
//   Future<void> insert_doctor(doctor_info doctor) async {
//     // Get a reference to the database.
//     final db = await database;

//     // Insert the doctor info into the correct table. You might also specify the
//     // `conflictAlgorithm` to use in case the same doctor is inserted twice.
//     //
//     // In this case, replace any previous data.
//     await db.insert(
//       'doctor_info',
//       doctor.toMap(),
//       conflictAlgorithm: ConflictAlgorithm.replace,
//     );
//   }

//   // Define a function that inserts pH data into the database
//   Future<void> insert_ph_data(ph_data data) async {
//     // Get a reference to the database.
//     final db = await database;

//     // Insert the pH data into the correct table. You might also specify the
//     // `conflictAlgorithm` to use in case the same timestamp is inserted twice.
//     //
//     // In this case, replace any previous data.
//     await db.insert(
//       'ph_data',
//       data.toMap(),
//       conflictAlgorithm: ConflictAlgorithm.replace,
//     );
//   }

//   // Define a function that inserts physical activity info into the database
//   Future<void> insert_physical_activity(physical_activity activity) async {
//     // Get a reference to the database.
//     final db = await database;

//     // Insert the physical activity info into the correct table. You might also specify the
//     // `conflictAlgorithm` to use in case the same data is inserted twice.
//     //
//     // In this case, replace any previous data.
//     await db.insert(
//       'physical_activity',
//       activity.toMap(),
//       conflictAlgorithm: ConflictAlgorithm.replace,
//     );
//   }

//   // Define a function that inserts meal info into the database
//   Future<void> insert_meal(meal_status meal) async {
//     // Get a reference to the database.
//     final db = await database;

//     // Insert the meal info into the correct table. You might also specify the
//     // `conflictAlgorithm` to use in case the same meal is inserted twice.
//     //
//     // In this case, replace any previous data.
//     await db.insert(
//       'meal_status',
//       meal.toMap(),
//       conflictAlgorithm: ConflictAlgorithm.replace,
//     );
//   }

//   // Define a function that inserts symptom info into the database
//   Future<void> insert_symptom(symptoms_status symptom) async {
//     // Get a reference to the database.
//     final db = await database;

//     // Insert the symptom info into the correct table. You might also specify the
//     // `conflictAlgorithm` to use in case the same data is inserted twice.
//     //
//     // In this case, replace any previous data.
//     await db.insert(
//       'symptoms_status',
//       symptom.toMap(),
//       conflictAlgorithm: ConflictAlgorithm.replace,
//     );
//   }

//   // Define a function that inserts a message into the database
//   Future<void> insert_message(messages message) async {
//     // Get a reference to the database.
//     final db = await database;

//     // Insert the message into the correct table. You might also specify the
//     // `conflictAlgorithm` to use in case the same data is inserted twice.
//     //
//     // In this case, replace any previous data.
//     await db.insert(
//       'messages',
//       message.toMap(),
//       conflictAlgorithm: ConflictAlgorithm.replace,
//     );
//   }
// }

class patient_info {
  final String first_name;
  final String last_name;
  final int mhr_number;
  final DateTime time_stamp;

  const patient_info({
    required this.first_name,
    required this.last_name,
    required this.mhr_number,
    required this.time_stamp,
  });

  // Convert patient_info into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'First Name': first_name,
      'Last Name': last_name,
      'MHR Number': mhr_number,
      'Last Updated': time_stamp,
    };
  }

  // Implement toString to make it easier to see information about
  // the patient when using the print statement.
  @override
  String toString() {
    return 'patient_info{first_name: $first_name, last_name: $last_name, mhr_number: $mhr_number, time_stamp: $time_stamp}';
  }
}

class doctor_info {
  final String email_id;
  final DateTime time_stamp;

  const doctor_info({
    required this.email_id,
    required this.time_stamp,
  });

  // Convert doctor_info into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'Doctor Email': email_id,
      'Last Updated': time_stamp,
    };
  }

  // Implement toString to make it easier to see information about
  // the doctor's info when using the print statement.
  @override
  String toString() {
    return 'doctor_info{email_id: $email_id, time_stamp: $time_stamp}';
  }
}

class ph_data {
  double ph_value = 0.00;
  DateTime time_stamp = DateTime.now();

  ph_data(double ph_value, DateTime time_stamp) {
    this.ph_value = ph_value;
    this.time_stamp = time_stamp;
  }

  // Convert ph_data into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'ph_value': ph_value,
      'time_stamp': time_stamp,
    };
  }

  // // Define a function that inserts pH data into the database
  // Future<void>
  void insert_ph_data(ph_data data) async {
    // Get a reference to the database.

    final db = openDatabase(
        // Set the path to the database. Note: Using the `join` function from the
        // `path` package is best practice to ensure the path is correctly
        // constructed for each platform.
        join(await getDatabasesPath(), 'gerd_database.db'));
    onCreate:
    (db, version) async {
      await db.execute(
        'CREATE TABLE ph_data(ph_value FLOAT NOT NULL, time_stamp DATETIME PRIMARY KEY)',
      );

      // Insert the pH data into the correct table. You might also specify the
      // `conflictAlgorithm` to use in case the same timestamp is inserted twice.
      //
      // In this case, replace any previous data.
      await db.insert('ph_data', data.toMap());
    };
  }

  // Implement toString to make it easier to see information about
  // the pH values when using the print statement.
  @override
  String toString() {
    return 'ph_data{ph_value: $ph_value, time_stamp: $time_stamp}';
  }
}

class physical_activity {
  final String activity_status;
  final DateTime start_time;
  final DateTime end_time;
  final DateTime time_stamp;

  const physical_activity({
    required this.activity_status,
    required this.start_time,
    required this.end_time,
    required this.time_stamp,
  });

  // Convert physical_activity into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'Activity Status': activity_status,
      'Start Time': start_time,
      'End Time': end_time,
      'Time Recorded': time_stamp,
    };
  }

  // Implement toString to make it easier to see information about
  // the physical acitivity when using the print statement.
  @override
  String toString() {
    return 'physical_activity{activity_status: $activity_status, start_time: $start_time, end_time: $end_time, time_stamp: $time_stamp}';
  }
}

class meal_status {
  final String meal;
  final String drink;
  final DateTime start_time;
  final DateTime end_time;
  final DateTime time_stamp;

  const meal_status({
    required this.meal,
    required this.drink,
    required this.start_time,
    required this.end_time,
    required this.time_stamp,
  });

  // Convert meal_status into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'Food eaten': meal,
      'Drink': drink,
      'Start Time': start_time,
      'End Time': end_time,
      'Time Recorded': time_stamp,
    };
  }

  // Implement toString to make it easier to see information about
  // the meal status when using the print statement.
  @override
  String toString() {
    return 'meal_status{meal: $meal, drink: $drink, start_time: $start_time, end_time: $end_time, time_stamp: $time_stamp}';
  }
}

class symptoms_status {
  final String symptom;
  final DateTime start_time;
  final DateTime end_time;
  final DateTime time_stamp;

  const symptoms_status({
    required this.symptom,
    required this.start_time,
    required this.end_time,
    required this.time_stamp,
  });

  // Convert symptoms_status into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'Symptoms': symptom,
      'Start Time': start_time,
      'End Time': end_time,
      'Time Recorded': time_stamp,
    };
  }

  // Implement toString to make it easier to see information about
  // symptoms when using the print statement.
  @override
  String toString() {
    return 'symptoms_status{symptom: $symptom, start_time: $start_time, end_time: $end_time, time_stamp: $time_stamp}';
  }
}

class messages {
  final String message;
  final DateTime time_stamp;

  const messages({
    required this.message,
    required this.time_stamp,
  });

  // Convert messages into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'Messages': message,
      'Time recorded': time_stamp,
    };
  }

  // Implement toString to make it easier to see information about
  // the  messages when using the print statement.
  @override
  String toString() {
    return 'messages{message: $message, time_stamp: $time_stamp}';
  }
}
