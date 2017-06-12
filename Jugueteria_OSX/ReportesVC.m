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
    [self CargarReporte];
}
-(void)CargarReporte{
    NSInteger selectedTab = [_SegmentedControl selectedSegment];
    if (selectedTab == 0)//Venta
    {
        
    }
    else
    {//Entradas de Almacen
    
    
    }
}
-(IBAction)CargarViewControllerAsPopup:(id)sender{
    
}

- (IBAction)CerrarVC:(id)sender {
    [self dismissController:nil];
}
- (IBAction)OnChangeSegmentedControl:(id)sender {
    
    
}
@end
