{
Esta re mal redactado el ejercicio porque primero pide cantidad de niños en localidad y después el total en la localidad ¿¿??

Yo asumí que quiso decir cantidad en el barrio y luego total en la localidad.

}


program ej5;

const
  FIN = 'ZZZ';

type
  int=integer;
  str30= string[30];

  riesgo = record
    partido: str30;
    localidad: str30;
    barrio: str30;
    ninios: int;
    adultos: int;
  end;

  archMaestro = file of riesgo;

procedure leer(var archivo: arvchivoMaestro; var dato: riesgo);
begin
  if (not(eof(archivo)) then
     read(archivo,dato)
     else
       dato.partido:=FIN;
end;


var
  maestro: archMaestro;
  regMaestro: riesgo;

  partidoAct,locAct,barrioAct:str30;
  numLoc:int;


  ninLoc,adulLoc: int;
  ninPartido,adulPartido: int;



begin
  assign(maestro,'maestro.dat');
  reset(maestro);


  leer(maestro,regMaestro); // asumo por enunciado que no está vacío
  repeat

        ninPartido:=0;
        adulPartido:=0;
        numLoc:=0;


        partidoAct:= regMaestro.partido;
        writeln('Partido:' partiodoAct);

        while (partidoAct=regMaestro.partido) do begin
          numLoc:=numLoc+1;
          locAct:=regMaestro.localidad;
          writeln('Localidad ',numLoc, ' (', locAct,'):'

          while(locAct=regMaestro.localidad) and (partidoAct=regMaestro.partido) do begin
            barrioAct:=regMaestro.barrio;
            writeln('Barrio: ', barrioAct,):
            while(locAct=regMaestro.localidad) and (partidoAct=regMaestro.partido) and (barrioAct=regMaestro.barrio) do begin
              writeln('Cantidad niños: ',regMaestro.ninios,'   Cantidad adultos: ',regMaestro.ninios);
              ninLoc:=ninLoc+regMaestro.ninios;
              adulLoc:=adulLoc + regMaesetro.adultos;

              leer(maestro,regMaestro);
            end;
            ninPartido:=ninPartido+ninLoc;
            adulPartido:=adulPartido+adulLoc;
          end;

            writeln('Total niños localidad: ',ninLoc,'Total adultos localidad: ', adulLoc);
        end;

            writeln('Total niños partido: ',ninPartido,'Total adultos partido: ', adulPartido);

  until (regMaesetro.cod=FIN);

  close(maestro);

end.


