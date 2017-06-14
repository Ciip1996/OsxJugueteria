//
//  AdministradorVC.m
//  Jugueteria_OSX
//
//  Created by Iván Pacheco on 14/06/17.
//  Copyright © 2017 Iván Pacheco. All rights reserved.
//

#import "AdministradorVC.h"
#import "Persona.h"
#import "Empleado.h"

@interface AdministradorVC ()

@end

@implementation AdministradorVC

- (void)viewDidLoad {
    [super viewDidLoad];
    msqlite =  [[ManejadorSQLite alloc] init];
    appdelegate = [[AppDelegate alloc]init];
    // Do view setup here.
}

- (IBAction)OnCrearUsuarioNuevo:(id)sender {
    Persona *p = [[Persona alloc]init];
    [p setNombre:[_txtNombre stringValue]];
    [p setApellidoMaterno:[_txtMaterno stringValue]];
    [p setApellidoPaterno:[_txtPaterno stringValue]];
    [p setRfc:[_txtRFC stringValue]];
    [p setCurp:[_txtCurp stringValue]];
    [p setGenero:[[_popUpBtnGenero selectedItem] title]];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *fechaNac = [dateFormatter stringFromDate:[_FechaNacimiento dateValue]];
    [p setFechaNacimiento:fechaNac];

    Empleado *em = [[Empleado alloc]init];
    [em setPersona:p];
    [em setRol:[[_popUpBtnRol selectedItem] title]];
    [em setSalario:[_txtSalario doubleValue]];
    NSString *user = [[_txtCurp stringValue] substringToIndex: MIN(4, [[_txtCurp stringValue] length])];
    [em setUsuario:user];
    [em setCodigo:[NSString stringWithFormat:@"EMP0%@",user]];
    if([[_txtClave stringValue] isEqualToString:[_txtConfirmarClave stringValue]])
        [em setContrasenia:[_txtClave stringValue]];
    else{
        [appdelegate MessageBox:@"Las contraseñas no coinciden y debe ser iguales, escribalas nuevamente. " andTitle:@"Clave no Coincide"];
        return;
    }
    NSString *fechaIngreso = [dateFormatter stringFromDate:[NSDate date]];
    [em setFechaIngreso:fechaIngreso];
    
    //Insertamos en tabla persona todos los datos:
    NSString *queryPersnona =
    [NSString stringWithFormat:
     @"INSERT INTO Persona(Nombre,ApellidoPaterno, ApellidoMaterno,FechaNacimiento,Curp,Rfc,Genero,Estatus) VALUES('%@','%@','%@','%@','%@','%@','%@',1);",
    [p Nombre],[p ApellidoPaterno],[p ApellidoMaterno],[p FechaNacimiento], [p Curp], [p Rfc], [p Genero]];
    [msqlite ExecuteSqlQuery:queryPersnona];
    
    //Ahora insertamos los datos en tabla empleado:
    NSString *queryEmpleado =
    [NSString stringWithFormat:@"INSERT INTO Empleado(IdPersona,Codigo, FechaIngreso,Rol,Salario) VALUES((SELECT IdPersona FROM Persona ORDER BY IdPersona DESC limit 1),'%@','%@','%@',%f);",
    [em Codigo],[em FechaIngreso], [em Rol], [em Salario]];
    [msqlite ExecuteSqlQuery:queryEmpleado];
    //Por ultimo insertamos los datos en tabla usuario:
    NSString *queryUsuario =
    [NSString stringWithFormat:
     @"INSERT INTO Usuario(Usuario,Contrasenia, IdEmpleado) VALUES('%@','%@',(SELECT IdEmpleado FROM Empleado ORDER BY IdEmpleado DESC limit 1));",[em Usuario], [em Contrasenia]];
    [msqlite ExecuteSqlQuery:queryUsuario];

}

- (IBAction)CerrarVC:(id)sender {
    [self dismissController:nil];
}
@end
