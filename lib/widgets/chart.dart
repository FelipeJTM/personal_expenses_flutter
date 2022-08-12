import 'package:flutter/material.dart';
import 'package:personal_expenses/models/transactions.dart';
import 'package:intl/intl.dart';

import 'chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transactions> recentTransactions;

//el metodo get de abajo regresa una lista de maps [{"a":"A"},{"b":"B"},{"c":"C"}]
//que es basicamente la suma de las correspondiente a cada dia de la semana.
  List<Map<String, Object>> get groupedTransactionsValues {
    //1- se genera una lista de 7 campos correspondiente a cada dia de la semana
    //(el metodo generate pide un indice y una funcion)
    //es como un loop (generate)
    return List.generate(7, (index) {
      //la funcion anonima siguen los siguientes pasos:
      //    1- crea una variable que substrae la cantidad de dias del indice a la fecha actual:
      //    ejemplo: date = 23 agosto; i = 1;
      //    date.subtract(Duration(Days:i)) 23 - 1 = 22 (22 de agosto).
      //    i++
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalSum = 0.0; //esta es la suma correspondiente al dia que se
      //revisa cuantas transacciones de la lista de transacciones corresponden a un dia
      //en especifico.
      //ej:  Lista l = [t{id: 0}, titulo: "cosa" , cantidad: 22.5, fecha: "23 de agosto"];  weekDay = 23 de agosto;
      //(l.fecha == weekDay) ? totalSum += l.cantidad : no hacer nada;
      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day && // es igual el dia
            recentTransactions[i].date.month == weekDay.month && // el mes
            recentTransactions[i].date.year == weekDay.year) {
          // y el año?
          totalSum += recentTransactions[i]
              .amount; // si se cumple la condicion sumale el amount a totalsum
        }
      }
      //print(DateFormat.E().format(weekDay));
      //print(totalSum);
      //se le agrega a la lista un map nuevo con los siguentes valores...
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum,
      };
    }).reversed.toList();
  }

  double get totalSpending {
    return groupedTransactionsValues.fold(0.0, (sum, item) {
      return sum + (item['amount'] as double);
    });
  }

  const Chart({Key? key, required this.recentTransactions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //se imprime la lista de maps correspondiente a cada valor
    //print(groupedTransactionsValues);

    return Container(
      child: Card(
        elevation: 6,
        margin: EdgeInsets.all(20),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: groupedTransactionsValues.map((data) {
              return Flexible(
                fit: FlexFit.tight,
                child: ChartBar(
                    data["day"] as String,
                    data['amount'] as double,
                    (totalSpending == 0.0)
                        ? 0.0
                        : (data['amount'] as double) / totalSpending),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
