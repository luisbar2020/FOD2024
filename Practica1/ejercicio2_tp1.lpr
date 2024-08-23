program ejercicio2_tp1;
type
  archivo=file of integer;
var
  mae:archivo;
  num,cant,tot,sum:integer;
  nombre:string;

begin
  Write('Ingrese nombre del archivo a procesar: '); readln(nombre);
  assign(mae,nombre);
  reset(mae); // abrir archivo existente con el nombre indicado
  cant:=0; tot:=0; sum:=0;
  While ( not EOF(mae) ) do begin

    read(mae,num);    // leer en num lo que este apuntando el puntero

    if(num<1500) then begin
      cant:=cant+1;
    end;

    tot:=tot+1; sum:=sum+num;

    write(num, '___' );
  end;

  Writeln();
  Writeln('Numeros menores a 1500: ',cant,' y Promedio de numeros: ',sum/tot);

  close(mae);       // Cerrar archivo.
  readln();
end.

