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
    
}
- (IBAction)Eliminar:(id)sender;
- (IBAction)dobleClickRenglon:(id)sender;
-(id)init;

@property (nonatomic,retain) NSMutableArray *ListaProductos;
@property (weak) IBOutlet NSTableView *TablaProductos;
@property (weak) IBOutlet NSButton *btnAlimentarInventario;

- (IBAction)RefrescarTabla:(id)sender;
-(void)MessageBox:(NSString *)Message andTitle:(NSString *)titulo;
-(void)ConsultarDatos;
-(IBAction)deleteRow:(id)sender;

@end
