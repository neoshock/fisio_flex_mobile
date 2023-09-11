List<Map<String, dynamic>> getLast7DaysWithNames() {
  final List<Map<String, dynamic>> last7DaysWithNames = [];
  final today = DateTime.now();

  for (int i = 0; i < 7; i++) {
    // Cambiamos la lógica para obtener los últimos 7 días.
    final day = today.subtract(Duration(days: i));
    final dayName = getDayName(day);
    last7DaysWithNames.add({'day': dayName, 'date': day.day});
  }

  return last7DaysWithNames;
}

String getDayName(DateTime date) {
  final weekDays = [
    'Lunes',
    'Martes',
    'Miércoles',
    'Jueves',
    'Viernes',
    'Sábado',
    'Domingo',
  ];
  return weekDays[date.weekday -
      1]; // Restamos 1 porque DateTime usa 1 para Lunes, 2 para Martes, etc.
}

String getDateNow() {
  final now = DateTime.now();
  final day = now.day
      .toString()
      .padLeft(2, '0'); // Asegura que siempre tenga dos dígitos.
  final month = now.month
      .toString()
      .padLeft(2, '0'); // Asegura que siempre tenga dos dígitos.
  final year = now.year.toString();

  return '$day/$month/$year';
}

String convertDate(DateTime date) {
  final day = date.day.toString().padLeft(2, '0');
  final month = date.month.toString().padLeft(2, '0');
  final year = date.year.toString();

  return '$day/$month/$year';
}
