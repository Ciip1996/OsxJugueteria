//
//  AlimentadorInventarioVC.h
//  Jugueteria_OSX
//
//  Created by Iván Pacheco on 06/04/17.
//  Copyright © 2017 Iván Pacheco. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <sqlite3.h>
#import "AppDelegate.h"
#import "InventarioVC.h"
#import "ManejadorSQLite.h"

@interface AlimentadorInventarioVC :  NSViewController<NSTableViewDataSource>
{
    AlimentadorInventarioVC *Ventana;
    InventarioVC *Principal;
    AppDelegate *appdelegate;
    ManejadorSQLite *msqlite;

    NSMutableArray *listaProductosExistentes;
    NSMutableArray *listaComboBox,*listaTabla;
    NSMutableArray *cantidadesViejas;
    double total;

}
//Controles de la seccón añadir nuevo producto
@property (weak) IBOutlet NSTextField *txtNombre;
@property (weak) IBOutlet NSTextField *txtEdadMinima;
@property (weak) IBOutlet NSTextField *txtEdadMaxima;
@property (weak) IBOutlet NSTextField *txtMarca;
@property (weak) IBOutlet NSTextField *txtPrecio;
@property (weak) IBOutlet NSTextField *txtCantidad;
@property (weak) IBOutlet NSTextField *txtDescripcion;
- (IBAction)AñadirNuevo:(id)sender;

//Controles de la seccón añadir producto existente
@property (weak) IBOutlet NSPopUpButton *cboProductos;
@property (weak) IBOutlet NSTextField *lblTotal;
@property (weak) IBOutlet NSTextField *lblNombre;
@property (weak) IBOutlet NSTextField *lblMarca;
@property (weak) IBOutlet NSTextField *lblPrecio;
@property (weak) IBOutlet NSTextField *lblEdades;
@property (weak) IBOutlet NSTextField *lblDescripcion;
@property (weak) IBOutlet NSTextField *txtCantidadExistente;
- (IBAction)AñadirExistente:(id)sender;


//Controles compartidos
@property (weak) IBOutlet NSTableView *tablaResumen;
- (void)agregarProductoBitacora:(Producto*)producto y:(int)cantidadAnterior;
- (IBAction)RegistrarBitacora:(id)sender;
- (IBAction)Cancelar:(id)sender;
@end
