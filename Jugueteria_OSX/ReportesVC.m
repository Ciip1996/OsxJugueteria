//
//  ReportesVC.m
//  Jugueteria_OSX
//
//  Created by Iván Pacheco on 08/06/17.
//  Copyright © 2017 Iván Pacheco. All rights reserved.
//

#import "ReportesVC.h"
@interface ReportesVC ()

@end

@implementation ReportesVC

- (void)viewDidLoad {
    [super viewDidLoad];
    msqlite = [[ManejadorSQLite alloc]init];
    listaTabla = [[NSMutableArray alloc]init];
    [self CargarReporte];
}
-(void)CargarReporte{
    NSInteger selectedTab = [_SegmentedControl selectedSegment];
    if (selectedTab == 0)//Venta
    {
        
    }
    else
    {//Entradas de Almacen
        NSString *query = [NSString stringWithFormat:@"SELECT * FROM  Bitacora AS B"];
        listaTabla = [[NSMutableArray alloc] initWithArray:[msqlite SelectSomething:query]];
        [_tablaReporte reloadData];
    }
}
-(IBAction)CargarViewControllerAsPopup:(id)sender{
    
}

- (IBAction)CerrarVC:(id)sender {
    [self dismissController:nil];
}
- (IBAction)OnChangeSegmentedControl:(id)sender {
    
    
}
/*NSTableViewController methods to handle datasource*/
-(NSInteger) numberOfRowsInTableView:(NSTableView *)tableView{
    return   [listaTabla count];
}
-(id) tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row{
    Producto *producto = [listaTabla objectAtIndex:row];
    NSString *identifier = [tableColumn identifier];
    NSString *columna = [producto valueForKey:identifier];
    return columna;
}
@end
