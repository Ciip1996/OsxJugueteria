//
//  Empleado.m
//  Jugueteria_OSX
//
//  Created by Iván Pacheco on 12/06/17.
//  Copyright © 2017 Iván Pacheco. All rights reserved.
//

#import "Empleado.h"

@implementation Empleado

@synthesize IdEmpleado = IdEmpleado;
@synthesize IdPersona = IdPersona;
@synthesize Rol = Rol;
@synthesize Usuario = Usuario;
@synthesize Contraseña = Contraseña;

-(id)initWithRol:(NSString*)rol yUsuario:(NSString*)usuario yContraseña:(NSString*)contraseña{
    self.Rol = rol;
    self.Usuario = usuario;
    self.Contraseña = contraseña;
    return self;
}


@end
