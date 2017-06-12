//
//  LoginVC.m
//  Jugueteria_OSX
//
//  Created by Iván Pacheco on 06/06/17.
//  Copyright © 2017 Iván Pacheco. All rights reserved.
//

#import "LoginVC.h"
#import "TabViewController.h"
#import "InventarioVC.h"
#import "Response.h"

@interface LoginVC ()

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.

    //LLAMAR EL APPDELEGATE DE LA APLICACION
    appdelegate = [[AppDelegate alloc] init];
    msqlite =  [[ManejadorSQLite alloc]init];
 }

- (IBAction)btnEntrar:(id)sender {
    
    NSString *usuario = [[NSString alloc] initWithString:[_txtUsuario stringValue]];
    NSString *contrasenia = [[NSString alloc] initWithString:[_txtContraseña stringValue]];
    //acceso a datos para comprobar contraseña y usuario
    Response *response = [msqlite Login:usuario yContraseña:contrasenia];
    if (response)
    {
        appdelegate = [AppDelegate getInstance];
        appdelegate.EmpleadoSesionActivo = [response Empleado];
        [self dismissController:nil];//cierra este view controller
    }
    else{
        [appdelegate MessageBox:@"Usuario o Contraseña Incorrectos, reviselos e intente nuevamente." andTitle:@"Fallo al Iniciar Sesión"];
    }
}

@end
