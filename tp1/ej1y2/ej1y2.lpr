program ej1y2;

const
  MAX = 5;
  VALOR = 1500;

type
  archEnteros = file of integer;



  procedure writeArchEnteros(var arch: archEnteros);
  var
    i, numero: integer;
  begin
    rewrite(arch);
    writeln('Ingrese los numeros');
    for i := 1 to (MAX) do
    begin
      writeln('Numero ', i, ': ');
      readln(numero);
      Write(arch, numero);
    end;
    Close(arch);
  end;

  procedure readArchEnteros(var arch: archEnteros);
  var
    numero, suma, i, contador: integer;
  begin
    suma := 0;
    contador:= 0;
    reset(arch);
    for i := 1 to (MAX) do

    begin
      Read(arch, numero);
      if (numero < VALOR) then
        contador := contador + 1;
      suma := suma + numero;
    end;


    writeln('La cantidad de numeros en el archivo menores a ', VALOR, ' es: ', contador);
    writeln('El promedio es de: ', (suma / MAX): 0: 2);
    Close(arch);
  end;

var
  nomArch: string;
  arch: archEnteros;

begin
  writeln('Practica 1 - Ejercicios 1 y 2');
  writeln('Ingrese el nombre del archivo de enteros:');
  readln(nomArch);
  Assign(arch, nomArch);

  writeArchEnteros(arch);
  readArchEnteros(arch);
  readln();
end.
