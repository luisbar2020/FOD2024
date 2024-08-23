program ejercicio1_tp1;
const
  fin=30000;
type
  archivo= file of integer;
var
  mae:archivo;
  num:integer;
  nombre:string;
begin
  Write('Ingrese nombre del archivo: '); readln(nombre);
  assign(mae,nombre);     // asignacion nombre
  rewrite(mae);  // creacion archivo
  Write('Ingrese un numero: '); readln(num);
  While( num<>fin) do begin
    write(mae,num);
    Write('Ingrese un numero: '); readln(num);
  end;
  close(mae);

end.

