import 'package:fisioflex_mobile/config/utils.dart';
import 'package:flutter/material.dart';

class HomeDateList extends StatefulWidget {
  final Function(int) onItemSelected;
  const HomeDateList({Key? key, required this.onItemSelected})
      : super(key: key);

  @override
  _HomeDateListState createState() => _HomeDateListState();
}

class _HomeDateListState extends State<HomeDateList> {
  int selectedIndex = 0; // Mantén un índice para el ítem seleccionado.

  @override
  Widget build(BuildContext context) {
    final days = getLast7DaysWithNames();
    return SizedBox(
      height: 96,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) =>
            _dateItem(context, days[index]['day'], days[index]['date'], index),
        itemCount: days.length,
      ),
    );
  }

  Widget _dateItem(BuildContext context, String day, int date, int index) {
    final isSelected =
        index == selectedIndex; // Comprueba si este ítem está seleccionado.

    return InkWell(
      onTap: () {
        // Establece el índice seleccionado cuando se toca el ítem.
        setState(() {
          selectedIndex = index;
        });
        widget.onItemSelected(date);
      },
      child: Container(
        width: 90,
        margin: const EdgeInsets.only(left: 15),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.blue // Cambia el color de fondo cuando se selecciona.
              : Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(day.substring(0, 3),
                style: isSelected
                    ? const TextStyle(
                        color: Colors
                            .white, // Cambia el color del texto cuando se selecciona.
                        fontWeight: FontWeight.bold,
                      )
                    : Theme.of(context).textTheme.bodySmall),
            Text('$date',
                style: isSelected
                    ? const TextStyle(
                        color: Colors
                            .white, // Cambia el color del texto cuando se selecciona.
                        fontWeight: FontWeight.bold,
                      )
                    : Theme.of(context).textTheme.displayMedium),
          ],
        ),
      ),
    );
  }
}
