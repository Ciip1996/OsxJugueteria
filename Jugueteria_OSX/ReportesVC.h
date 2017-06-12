//
//  ReportesVC.h
//  Jugueteria_OSX
//
//  Created by Iván Pacheco on 08/06/17.
//  Copyright © 2017 Iván Pacheco. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ManejadorSQLite.h"


@interface ReportesVC : NSViewController<NSTableViewDataSource>
{
    ManejadorSQLite *msqlite;
    NSMutableArray *listaTabla;
}

@property (weak) IBOutlet NSSegmentedControl *SegmentedControl;
@property (weak) IBOutlet NSTableView *tablaReporte;

-(IBAction)CargarViewControllerAsPopup:(id)sender;
- (IBAction)CerrarVC:(id)sender;
- (IBAction)OnChangeSegmentedControl:(id)sender;

-(void)CargarReporte;
@end
