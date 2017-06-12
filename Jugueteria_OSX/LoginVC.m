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

@interface LoginVC ()

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    Ventana = [[LoginVC alloc]init];//inicializo mi Ventana.
    //LLAMAR EL APPDELEGATE DE LA APLICACION
    appdelegate = [[AppDelegate alloc] init];
    msqlite =  [[ManejadorSQLite alloc]init];
 }

- (IBAction)btnEntrar:(id)sender {
    NSString *usuario = [[NSString alloc] init];
    NSString *contrasenia = [[NSString alloc] init];
    usuario = [_txtUsuario stringValue];
    contrasenia = [_txtContraseña stringValue];
    //acceso a datos para comprobar contraseña y usuario
    NSString*response = [msqlite Login:usuario yContraseña:contrasenia];
    
    AppDelegate *obj = [AppDelegate getInstance];
    obj.EmpleadoRol = response;

    if (response)
    {
        [self dismissController:nil];//cierra este view controller
        NSWindowController *window = [[NSWindow alloc]init];
        InventarioVC *inv = [[InventarioVC alloc]init];
    }
    else{
        [appdelegate MessageBox:@"Usuario o Contraseña Incorrectos, reviselos e intente nuevamente." andTitle:@"Fallo al Iniciar Sesión"];
    }
}

@end
