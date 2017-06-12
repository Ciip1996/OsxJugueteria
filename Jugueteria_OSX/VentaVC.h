//
//  VentaVC.h
//  Jugueteria_OSX
//
//  Created by Iván Pacheco on 11/06/17.
//  Copyright © 2017 Iván Pacheco. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <sqlite3.h>
#import "AppDelegate.h"
#import "InventarioVC.h"
#import "ManejadorSQLite.h"

@interface VentaVC : NSViewController<NSTableViewDataSource>
{
    AppDelegate *appdelegate;
    ManejadorSQLite *msqlite;
    NSMutableArray *listaProductosBD;
    NSMutableArray *listaComboBox;
    NSMutableArray *listaTabla;
}
//metodos:
- (void)cargarProductosEnPopUpDesdeBD;

//IBOutlets

@property (weak) IBOutlet NSTextField *txtNombreCliente;
@property (weak) IBOutlet NSTableView *TablaCarritoCompras;
@property (weak) IBOutlet NSPopUpButton *cboProductosBD;
@property (weak) IBOutlet NSTextField *txtCodigoProducto;
@property (weak) IBOutlet NSTextField *lblNombreProducto;
@property (weak) IBOutlet NSTextField *lblMarcaProducto;
@property (weak) IBOutlet NSTextField *lblPrecioProducto;
@property (weak) IBOutlet NSTextField *txtCantidadDeProductos;
@property (weak) IBOutlet NSSearchField *searchFieldProductos;
@property (weak) IBOutlet NSTextField *lblTotalDeCompra;

//IBActions
- (IBAction)SeleccionarProductoBD:(id)sender;
- (IBAction)OnAñadirAlCarrito:(id)sender;
- (IBAction)OnRealizarCompra:(id)sender;
- (IBAction)EliminarProductoCarrito:(id)sender;


-(BOOL)validarSesion;
@end
