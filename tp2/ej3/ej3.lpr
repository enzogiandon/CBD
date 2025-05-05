program ej3;

const
  N = 20;
  FIN = maxInt;
type
  str30 = string[30];
  int = integer;

  calzado = record
    cod: int;
    talle: int;  // numero
    descripcion: string[140];
    precio: double;
    color: str30;
    stock: int;
    stockMin: int;
  end;

  venta = record
    cod: int;
    talle: int;
    cant: int;
  end;


  maestro = file of calzado;
  detalle = file of venta;

  vDetalles = array[1..N] of detalle;
  vVentas = array[1..N] of venta;

  procedure leer(var archivo: detalle; var dato: venta);
  begin
    if (not EOF(archivo)) then
      Read(archivo, dato)
    else
      dato.cod := FIN;
  end;

  procedure codMinimo(var v: vVentas; var min: venta; var det: vDetalles);
  var
    i, posMin: int;
  begin
    min := v[1];
    posMin := 1;
    for i := 2 to N do
    begin
      if (v[i].cod < min.cod) then
      begin
        min := v[i];
        posMin := i;
      end
      else if (v[i].cod = min.cod) and (v[i].talle < min.talle) then
      begin
        min := v[i];
        posMin := i;
      end;
    end;
    leer(det[posMin], v[posMin]);
  end;

var
  mae: maestro;
  det: vDetalles;
  v: vVentas;

  min: venta;
  i: int;
  strAux: string;

  calzAct: calzado;

  regMae: calzado;

  ventasCalzado: int;

  arcTexto: Text;

begin

  min := default(venta);
  regMae := default(calzado);
  v := default(vVentas);


  Assign(mae, 'maestro.dat');

  for i := 1 to N do
  begin
    // Asigno todos los archivos detalles
    str(i, strAux);
    strAux := 'detalle' + strAux + '.dat';
    Assign(det[i], strAux);

    // Abro todos los detalles
    reset(det[i]);
    leer(det[i], v[i]);
  end;

  reset(mae);

  Assign(arcTexto, 'calzadosinstock.txt');
  rewrite(arcTexto);



  codMinimo(v, min, det);
  repeat

    // separo por codigo y talle
    calzAct.cod := min.cod;
    calzAct.talle := min.talle;
    ventasCalzado := 0;
    while (calzAct.talle = min.talle) and (calzAct.cod = min.cod) do
    begin
      ventasCalzado := ventasCalzado + min.cant;
      codMinimo(v, min, det);
    end;

    // CUANDO TERMINO DE PROCESAR LAS VENTAS DEL MISMO CALZADO (cod Y talle)

    // busqueda en el maestro  
    Read(mae, regMae);
    while (regMae.cod <> calzAct.cod) or (regMae.talle <> calzAct.talle) do
    begin
      Writeln(arcTexto, 'Sin ventas para el calzado cod', regMae.cod,
        ', talle: ', regMae.talle);
      Read(mae, regMae);

    end;
    // Solo si hay mas stock que ventas, actualizo el stock
    if (ventasCalzado <= regMae.stock) then
    begin
      regMae.stock := regMae.stock - ventasCalzado;

      seek(mae, filePos(mae) - 1);
      Write(mae, regMae);


      // Si me pasé del stock minimo, informo para después reponer
      if (regMae.stock < regMae.stockMin) then
        writeln(arcTexto, regMae.cod, ',', regMae.talle);

    end;

  until (min.cod = FIN);

  // Si me quedo sin detalles, sigo recorriendo el maestro para ver qué quedó sin vender
if not EOF(mae) then
begin
  repeat
    writeln('Sin ventas para el calzado cod ', regMae.cod, ', talle: ', regMae.talle);
    Read(mae, regMae);
  until EOF(mae);
end;


  Close(mae);
  for i := 1 to N do
    Close(det[i]);

end.
