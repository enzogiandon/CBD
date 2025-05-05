program ej4;

const
  FIN = maxInt;
  N = 20;
type
  int = integer;
  str30 = string[30];
  str10 = string[10];

  asistencia = record
    cod: int;
    nombre: str30;
    genero: str30;
    director: str30;
    duracion: int;
    fecha: str10;
    asistentes: int;
  end;


  archivo = file of asistencia;

  vDetalles = array[1..N] of archivo;
  vRegistros = array[1..N] of asistencia;


  procedure leer(var a: archivo; var dato: asistencia);
  begin
    if not (EOF(a)) then
      Read(a, dato)
    else
      dato.cod := FIN;
  end;

  procedure codMin(var vD: vDetalles; var vR: vRegistros; var min: asistencia);
  var
    i, posMin: int;
  begin
    min := vR[1];
    posMin := 1;

    for i := 2 to N do
    begin
      if (vR[i].cod < min.cod) then
      begin
        min := vR[i];
        posMin := i;
      end;

    end;
    leer(vD[posMin], vR[posMin]);

  end;

  procedure crearMaestro(var vD: vDetalles; nomMaestro: string);
  var
    maestro: archivo;
    vR: vRegistros;

    i: int;
    act, min: asistencia;

    asistentes: int;
  begin
    for i := 1 to N do
    begin
      reset(vD[i]);
      leer(vD[i], vR[i]);
    end;


    Assign(maestro, nomMaestro);
    rewrite(maestro);

    codMin(vD, vR, min);
    repeat

      act := min;
      asistentes := 0;
      while (min.cod = act.cod) do
      begin
        asistentes := asistentes + min.asistentes;
        codMin(vD, vR, min);
      end;

      act.asistentes := asistentes;
      Write(maestro, act);


    until (min.cod = FIN);

    for i := 1 to N do
      Close(vD[i]);
  end;

var

  vD: vDetalles;

  i: int;
  strAux: string;
begin

  for i := 1 to N do
  begin
    str(i, strAux);
    strAux := 'detalle' + strAux + '.dat';
    Assign(vD[i], strAux);

  end;

  crearMaestro(vD, 'maestro.dat');

end.
