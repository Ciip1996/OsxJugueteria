//
//  Empleado.h
//  Jugueteria_OSX
//
//  Created by Iván Pacheco on 12/06/17.
//  Copyright © 2017 Iván Pacheco. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Persona.h"

@interface Empleado : NSObject


//propiedades de tabla Empleado:
@property int IdEmpleado;
@property int IdPersona;
@property Persona* persona;
@property double Salario;
@property NSString *Codigo;
@property NSString *FechaIngreso;
@property NSString *Rol;

//propiedades de tabla usuario:
@property NSString *Usuario;
@property NSString *Contrasenia;

//propiedades de tabla persona:



-(id)initWithRol:(NSString*)rol yUsuario:(NSString*)usuario yContraseña:(NSString*)contraseña;

@end
