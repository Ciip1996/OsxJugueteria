//
//  AlimentadorInventarioVC.m
//  Jugueteria_OSX
//
//  Created by Iván Pacheco on 06/04/17.
//  Copyright © 2017 Iván Pacheco. All rights reserved.
//

#import "AlimentadorInventarioVC.h"
#import "Producto.h"
#import "LoginVC.h"
#import "ManejadorSQLite.h"


@interface AlimentadorInventarioVC ()

@end

@implementation AlimentadorInventarioVC

-(void)viewWillAppear{
    [self traerJuguetesComboBox];
    [_cboProductos addItemsWithTitles:listaComboBox];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    Ventana = [[AlimentadorInventarioVC alloc]init];//inicializo mi Ventana.
    Principal = [[InventarioVC alloc]init];
    
    //LLAMAR EL APPDELEGATE DE LA APLICACION
    appdelegate = [[AppDelegate alloc] init];
    listaProductosExistentes = [[NSMutableArray alloc]init];
    listaComboBox = [[NSMutableArray alloc]init];
    listaTabla = [[NSMutableArray alloc]init];
    msqlite = [[ManejadorSQLite alloc]init];
    cantidadesViejas = [[NSMutableArray alloc]init];

}
/*
 El siguiente metodo se llama para que consulte en sqlite los juguetes existentes y asi poder rellenar el combobox (popup button) con los nombres de estos.
 Tambien llena un NSMutableArray con todos los juguetes para usarlos despues.
 */
- (void)traerJuguetesComboBox {
    msqlite = [[ManejadorSQLite alloc]init];
    listaProductosExistentes = [msqlite traerProductos];
    for (int i = 0; i < listaProductosExistentes.count ; i++)
    {
        Producto *obj = [listaProductosExistentes objectAtIndex:i];
        [listaComboBox addObject:[obj getNombre]];
    }
}
/*
    Evento que se activa al seleccionar un item del combo box (popup button)
 */
- (IBAction)SeleccionarProducto:(id)sender
{
    NSInteger i = _cboProductos.indexOfSelectedItem - 1;
    if (i == -1)
    {
        [_txtNombre setStringValue:@""];
        [_txtMarca setStringValue:@""];
        [_txtDescripcion setStringValue:@""];
        [_txtEdadMaxima setStringValue:@""];
        [_txtEdadMinima setStringValue:@""];
        [_txtPrecio setStringValue:@""];
        [_txtCantidad setStringValue:@""];
    }
    else
    {
        [_lblNombre setStringValue:[[listaProductosExistentes objectAtIndex:i] getNombre]];
        [_lblMarca setStringValue:[[listaProductosExistentes objectAtIndex:i] getMarca]];
        [_lblDescripcion setStringValue:[[listaProductosExistentes objectAtIndex:i] getDescripcion]];
        NSString *edades = [NSString stringWithFormat:@"%d - %d",[[listaProductosExistentes objectAtIndex:i] getEdadMinima],[[listaProductosExistentes objectAtIndex:i] getEdadMaxima]];
        [_lblEdades setStringValue:edades];
        [_lblPrecio setDoubleValue:[[listaProductosExistentes objectAtIndex:i] getPrecioVenta]];
    }
}
- (IBAction)AñadirNuevo:(id)sender {
    Producto *producto = [[Producto alloc]init];
    [producto setNombre:_txtNombre.stringValue];
    [producto setMarca:_txtMarca.stringValue];
    [producto setCantidad:_txtCantidad.doubleValue];
    [producto setEdadMaxima:_txtEdadMaxima.doubleValue];
    [producto setEdadMinima:_txtEdadMinima.doubleValue];
    [producto setPrecioVenta:_txtPrecio.doubleValue];
    [producto setDescripcion:_txtDescripcion.stringValue];
    [producto setNuevo:YES];
    [self agregarProductoBitacora:producto y:0];
}

- (IBAction)AñadirExistente:(id)sender {
    Producto *prod = [[Producto alloc] init];
    prod = [listaProductosExistentes objectAtIndex:[_cboProductos indexOfSelectedItem]-1];
    int cantidadAnterior = 0;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"Nombre == %@", prod.getNombre];
    NSArray *TablaFiltrada = [listaTabla filteredArrayUsingPredicate:predicate];
    if(TablaFiltrada.count > 0)
    {
        cantidadAnterior = [[TablaFiltrada firstObject] getCantidad];
    }
    [prod setCantidad:[_txtCantidadExistente intValue]];
    [prod setNuevo:NO];
    [self agregarProductoBitacora:prod y:cantidadAnterior];
}

- (void)agregarProductoBitacora:(Producto*)producto y:(int)cantidadAnterior
{
    if (cantidadAnterior != 0)
    {
        [listaTabla removeObjectIdenticalTo:producto];
        int cantNueva = cantidadAnterior + producto.getCantidad;
        [producto setCantidad:cantNueva];
    }
    [listaTabla addObject:producto];
    [_tablaResumen reloadData];
    total = 0.0;
    for (id item in listaTabla)
        total = total + ([item getPrecioVenta] * [item getCantidad]);
    [_lblTotal setStringValue: [NSString stringWithFormat:@"Total: $%.2f",total]];
}

/* Este evento se activa al dar clic en el boton registrar y generar bitacora
 checa cada objeto de la listaTabla si es nuevo hace insert si es viejo solo hace update a los datos.
 */
- (IBAction)RegistrarBitacora:(id)sender{
    //primero registramos nuestra bitacora:
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *fechaHoy = [dateFormatter stringFromDate:[NSDate date]];
    
    appdelegate = [AppDelegate getInstance];
    int idempleado = [[appdelegate EmpleadoSesionActivo] IdEmpleado];
    NSString *queryBitacora = [NSString stringWithFormat:
                               @"INSERT INTO Bitacora (FechaAbastecimiento, IdEmpleado, Total) VALUES ('%@',%d, %.2f)",fechaHoy, idempleado, total];
    msqlite = [[ManejadorSQLite alloc]init];
    [msqlite ExecuteSqlQuery:queryBitacora];

    //actualizamos el inventario
    for(id producto in listaTabla)
    {
        NSString *queryDetalleBitacora = [NSString stringWithFormat:
                           @"INSERT INTO DetalleBitacora (IdBitacora,IdProducto,Cantidad) VALUES ((SELECT IdBitacora FROM Bitacora ORDER BY IdBitacora DESC limit 1),%d,%d);",[producto IdProducto],[producto Cantidad]];
        msqlite = [[ManejadorSQLite alloc]init];
        [msqlite ExecuteSqlQuery:queryDetalleBitacora];

        if ([producto esNuevo])
        {
            NSString *query = [NSString stringWithFormat:
                               @"INSERT INTO Producto (nombre, marca, edadMinima,edadMaxima,cantidad,precioVenta,descripcion) VALUES ('%@','%@',%d,%d,%d,%f,'%@');",
                               [producto getNombre],
                               [producto getMarca],
                               [producto getEdadMinima],
                               [producto getEdadMaxima],
                               [producto getCantidad],
                               [producto getPrecioVenta],
                               [producto getDescripcion]];
            msqlite = [[ManejadorSQLite alloc]init];
            [msqlite ExecuteSqlQuery:query];
        }
        else
        {
            NSMutableArray *TablaBD = [[NSMutableArray alloc] init];
            msqlite = [[ManejadorSQLite alloc]init];
            TablaBD = [msqlite traerProductos];
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"idProducto == %d", [producto getIdProducto]];
            NSArray *TablaFiltrada = [TablaBD filteredArrayUsingPredicate:predicate];
            
            int cantBD = [[TablaFiltrada firstObject] getCantidad];
            int cantTotal = cantBD + [producto getCantidad];
            [producto setCantidad: cantTotal];
            NSString *query = [NSString stringWithFormat: @"UPDATE Producto SET marca = '%@', edadMinima = %d, edadMaxima = %d, cantidad = %d, precioVenta = %f, descripcion = '%@' WHERE idProducto = %d;",[producto getMarca],[producto getEdadMinima],[producto getEdadMaxima],[producto getCantidad],[producto getPrecioVenta], [producto getDescripcion],[producto getIdProducto]];
            msqlite = [[ManejadorSQLite alloc]init];
            [msqlite ExecuteSqlQuery:query];
        }
    }
    
    
    
    
    
    
    
    [Principal RefrescarTabla:nil];
    [Ventana dismissViewController:self];//Cierra/libera el control
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

/* Elimina un elemento seleccioado de la tabla NO IMPLEMENTADO AUN */
- (IBAction)Eliminar:(id)sender {
    @try
    {
        NSAlert *alert = [[NSAlert alloc] init];
        [alert addButtonWithTitle:@"Eliminar"];
        [alert addButtonWithTitle:@"Cancelar"];
        [alert setMessageText:@"Confirmar Eliminación"];
        [alert setInformativeText:@"¿Seguro que desea eliminar el registro?, No podrá deshacer esta acción después. "];
        [alert setAlertStyle:NSAlertStyleWarning];
        [alert beginSheetModalForWindow:self.view.window completionHandler:^(NSModalResponse returnCode) {
            if (returnCode == NSAlertFirstButtonReturn) {
                NSInteger row = [_tablaResumen selectedRow];
                [listaTabla removeObjectAtIndex:row];
                [_tablaResumen reloadData];
            }
            else if(returnCode == NSAlertSecondButtonReturn){
                //No hace nada.
            }
        }];
    }
    @catch (NSException *exception)
    {
        [appdelegate MessageBox:@"No se pudo eliminar" andTitle:@"Error"];
    }
}
/*
 Cierra el view controller
 */
- (IBAction)Cancelar:(id)sender {
    [Ventana dismissViewController:self];//Cierra/libera el control
}

@end
