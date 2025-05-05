{
Esta re mal redactado el ejercicio porque primero pide cantidad de niños en localidad y después el total en la localidad ¿¿??

Yo asumí que quiso decir cantidad en el barrio y luego total en la localidad.

}


program ej5;

const
  FIN = 'ZZZ';

type
  int = integer;
  str30 = string[30];

  riesgo = record
    partido: str30;
    localidad: str30;
    barrio: str30;
    ninios: int;
    adultos: int;
  end;

  archMaestro = file of riesgo;

  procedure leer(var archivo: archMaestro; var dato: riesgo);
  begin
    if (not (EOF(archivo))) then
      Read(archivo, dato)
    else
      dato.partido := FIN;
  end;


var
  maestro: archMaestro;
  regMaestro: riesgo;

  partidoAct, locAct, barrioAct: str30;
  numLoc: int;


  ninLoc, adulLoc: int;
  ninPartido, adulPartido: int;



begin
  Assign(maestro, 'maestro.dat');
  reset(maestro);


  leer(maestro, regMaestro); // asumo por enunciado que no está vacío
  repeat

    ninPartido := 0;
    adulPartido := 0;
    numLoc := 0;


    partidoAct := regMaestro.partido;
    writeln('Partido:', partidoAct);

    while (partidoAct = regMaestro.partido) do
    begin

      ninLoc := 0;
      adulLoc := 0;
      numLoc := numLoc + 1;
      locAct := regMaestro.localidad;

      writeln('Localidad ', numLoc, ' (', locAct, '):');


      while (locAct = regMaestro.localidad) and (partidoAct = regMaestro.partido) do
      begin
        writeln('Barrio ', regMaestro.barrio, ': ');
        writeln('Cantidad niños: ', regMaestro.ninios,
          '   Cantidad adultos: ', regMaestro.adultos);
        ninLoc := ninLoc + regMaestro.ninios;
        adulLoc := adulLoc + regMaestro.adultos;

        leer(maestro, regMaestro);
      end;


      ninPartido := ninPartido + ninLoc;
      adulPartido := adulPartido + adulLoc;
      writeln('Total niños localidad: ', ninLoc, 'Total adultos localidad: ',
        adulLoc);
    end;

    writeln('Total niños partido: ', ninPartido, 'Total adultos partido: ',
      adulPartido);

  until (regMaestro.partido = FIN);

  Close(maestro);

end.
