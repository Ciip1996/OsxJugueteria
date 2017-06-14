//
//  AdministradorVC.h
//  Jugueteria_OSX
//
//  Created by Iván Pacheco on 14/06/17.
//  Copyright © 2017 Iván Pacheco. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ManejadorSQLite.h"

@interface AdministradorVC : NSViewController{
    ManejadorSQLite *msqlite;
    AppDelegate *appdelegate;

}
@property (weak) IBOutlet NSDatePicker *FechaNacimiento;
@property (weak) IBOutlet NSTextField *txtNombre;
@property (weak) IBOutlet NSTextField *txtPaterno;
@property (weak) IBOutlet NSTextField *txtMaterno;
@property (weak) IBOutlet NSTextField *txtCurp;
@property (weak) IBOutlet NSTextField *txtRFC;
@property (weak) IBOutlet NSPopUpButton *popUpBtnGenero;
@property (weak) IBOutlet NSTextField *txtClave;
@property (weak) IBOutlet NSTextField *txtConfirmarClave;
@property (weak) IBOutlet NSTextField *txtSalario;
@property (weak) IBOutlet NSPopUpButton *popUpBtnRol;
- (IBAction)OnCrearUsuarioNuevo:(id)sender;
- (IBAction)CerrarVC:(id)sender;

@end
