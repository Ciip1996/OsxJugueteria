//
//  InventarioVC.h
//  Jugueteria_OSX
//
//  Created by Iván Pacheco on 08/06/17.
//  Copyright © 2017 Iván Pacheco. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <sqlite3.h>
#import "AppDelegate.h"



@interface InventarioVC : NSViewController<NSTableViewDataSource>
{
    AppDelegate *appdelegate;
    NSMutableArray *lista;
    
}
- (IBAction)Eliminar:(id)sender;
- (IBAction)dobleClickRenglon:(id)sender;
-(id)init;
@property NSDictionary *datosJson;
@property (nonatomic,retain) NSMutableArray *ListaProductos;
@property (weak) IBOutlet NSTableView *TablaProductos;
@property (weak) IBOutlet NSButton *btnAlimentarInventario;
- (IBAction)OnClickAlimentarInventariobtn:(id)sender;

- (IBAction)RefrescarTabla:(id)sender;
-(void)MessageBox:(NSString *)Message andTitle:(NSString *)titulo;
-(void)ConsultarDatos;
-(void)ConsultarProductos;
-(IBAction)deleteRow:(id)sender;

@end
