class RelojModel {
  String shora = '';
  String sminutos = '';
  int hora;
  int min;
  int dia;
  int mes;
  int year;
  String ampm;
  int diaweek;
//   Timer _timer;
  List dias = [
    'Lunes',
    'Martes',
    'Miercoles',
    'Jueves',
    'Viernes',
    'Sábado',
    'Domingo'
  ];
  List meses = [
    'Enero',
    'Febrero',
    'Marzo',
    'Abril',
    'Mayo',
    'Junio',
    'Julio',
    'Agosto',
    'Septiembre',
    'Octubre',
    'Noviembre',
    'Diciembre'
  ];

  RelojModel() {
    this.hora = DateTime.now().hour;
    this.min = DateTime.now().minute;
    this.dia = DateTime.now().day;
    this.mes = DateTime.now().month;
    this.year = DateTime.now().year;
    this.diaweek = DateTime.now().weekday;

    this.sminutos = this.min.toString();
    this.ampm = 'am';

    if (this.hora > 12) {
      this.ampm = 'pm';
      this.hora = this.hora - 12;
    }
    if (this.hora < 10) {
      this.shora = '0' + this.hora.toString();
    } else {
      this.shora = this.hora.toString();
    }
    if (this.min < 10) {
      this.sminutos = '0' + this.min.toString();
    } else {
      this.sminutos = this.min.toString();
    }
  }
}
