program ej1;

const
  FIN = 100000;
  MARCA = -1;

type
  int = integer;
  str30 = string[30];

  especie = record
    cod: int;
    nomVulg: str30;
    nomCien: str30;
    alt: double;
    prom: double;
    descrip: string[140];
    zona: str30;
  end;

  archivo = file of especie;


procedure bajaLogica(var a: archivo);
var
  dato: especie;
  cod: int;
  encontrado: boolean;
begin
  reset(a);
  writeln('Ingrese el codigo de planta a eliminar');
  readln(cod);

  while (cod <> FIN) do
  begin
    seek(a, 0);
    encontrado := false;

    while not EOF(a) do
    begin
      read(a, dato);
      if (dato.cod = cod) then
      begin
        seek(a, filepos(a) - 1);
        dato.cod := MARCA;
        write(a, dato);

        encontrado := true;
        writeln('Se borró correctamente la planta ', cod,'.');
        break;
      end;
    end;

    if not encontrado then
      writeln('Codigo ', cod, ' no encontrado.');

    writeln('Ingrese el codigo de planta a eliminar');
    readln(cod);
  end;

  close(a);
end;



  procedure bajaFisicaA(var a: archivo);
  var
    nue: archivo;
    dato: especie;
  begin

    Assign(nue, 'archCompacto.dat');
    rewrite(nue);

    reset(a);

    while (not (EOF(a))) do
    begin
      Read(a, dato);
      if (dato.cod <> MARCA) then
        Write(nue, dato);
    end;
    Close(a);
    Close(nue);

  end;


  procedure bajaFisicaB(var a: archivo);
  var
    dato: especie;
    ult: especie;
    posBorrar:int;
  begin

    reset(a);

    while (not (EOF(a))) do

    begin
      Read(a, dato);
      if (dato.cod = MARCA) then begin
        // Guardo la posición
        posBorrar:=filePos(a)-1;

        // Voy hasta la última posición y guardo el elemento
        seek(a,fileSize(a)-1);
        read(a,ult);

        // Reemplazo el borrado por el último
        seek(a,posBorrar);
        write(a,ult);

        // Voy a la ultima posición y la suprimo
        seek(a,fileSize(a)-1);
        truncate(a);

        // Vuelvo para seguir recorriendo
        seek(a,posBorrar); // sigo desde PosBorrar para verificar si el que reemplacé también debe ser borrado

      end;
    end;

    //NOTA: el método es medio reiterativo si tengo que borrar el último elemento, pero la cátedra lo da así.
    Close(a);

  end;


var
  a: archivo;
begin

  assign(a,'plantas.dat');

  bajaLogica(a);


end.
