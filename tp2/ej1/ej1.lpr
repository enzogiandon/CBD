program ej1;

const
  FIN = '-1';


type
  codigo = string[10]; // codigo de empleado

  empleado = record
    cod: codigo;
    nomAp: string[30];
    fechaNac: string[10];
    direccion: 1..10;
    hijos: integer;
    telefono: string[15];
    diasVacaciones: integer;
  end;

  solicVacaciones = record
    cod: codigo;
    fecha: string[10];
    cantDias: integer;
  end;

  maestro = file of empleado;
  detalle = file of solicVacaciones;

  procedure leer(var archivo: detalle; var dato: solicVacaciones);
  begin
    if (not EOF(archivo)) then
      Read(archivo, dato)
    else
      dato.cod := FIN;
  end;

var
  mae: maestro;
  det: detalle;

  regMaestro: empleado;
  regDetalle: solicVacaciones;

  aux: codigo; //codigo de empleado auxiliar
  totDias: integer;
begin
  Assign(mae, 'maestro.dat');
  Assign(det, 'detalle.dat');

  reset(mae);
  reset(det);


  repeat
    Read(mae, regMaestro); // asumiendo que no está vacío
    leer(det, regDetalle);

    // Proceso para cada registro con el mismo codigo
    aux := regDetalle.cod;
    totDias := 0;
    while (aux = regDetalle.cod) do
    begin
      totDias := totDias + regDetalle.cantDias;
      leer(det, regDetalle);
    end;

    // Busco en el registro maestro el codigo
    while (regMaestro.cod <> aux) do
      Read(mae, regMaestro);

    // Si tiene dias suficientes, actualizo
    if (totDias <= regMaestro.diasVacaciones) then  begin
      regMaestro.diasVacaciones := regMaestro.diasVacaciones - totDias;
      seek(mae,filepos(mae)-1);
      write(mae,regMaestro);
    end
    // Si no tiene dias suficientes, informo
    else
      with regMaestro do
        writeln('Codigo:', cod, '. Dias disponibles: ', diasVacaciones,
          'Dias solicitados: ', totDias);

    {
    Yo lo hubiera hecho asi:
            
      regMaestro.diasVacaciones := regMaestro.diasVacaciones - totDias;

      if (regMaestro >=0) then begin
        seek(mae,filepos(mae)-1);
        write(mae,regMaestro);
      end
      else
        with regMaestro do
          writeln('Codigo:', cod, '. Dias disponibles: ', diasVacaciones,
            'Dias solicitados: ', totDias);
    }



  until (regDetalle.cod <> FIN);

  close(det);
  close(mae);


end.
