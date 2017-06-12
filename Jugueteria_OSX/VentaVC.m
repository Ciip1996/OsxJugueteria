//
//  VentaVC.m
//  Jugueteria_OSX
//
//  Created by Iván Pacheco on 11/06/17.
//  Copyright © 2017 Iván Pacheco. All rights reserved.
//

#import "VentaVC.h"
#import "Producto.h"
#import "ManejadorSQLite.h"
@interface VentaVC ()

@end

@implementation VentaVC

-(void)viewWillAppear{
    msqlite = [[ManejadorSQLite alloc]init];
    appdelegate = [[AppDelegate alloc] init];
    [self cargarProductosEnPopUpDesdeBD];
    [_cboProductosBD addItemsWithTitles:listaComboBox];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    listaProductosBD = [[NSMutableArray alloc]init];
    listaComboBox = [[NSMutableArray alloc]init];
    listaTabla = [[NSMutableArray alloc]init];
}

- (void)cargarProductosEnPopUpDesdeBD {
    msqlite = [[ManejadorSQLite alloc]init];
    listaProductosBD = [msqlite traerProductos];
    for (int i = 0; i < listaProductosBD.count ; i++)
    {
        Producto *producto = [listaProductosBD objectAtIndex:i];
        NSString *textoProducto = [NSString stringWithFormat:@"%d: %@ de %@",[producto getIdProducto], [producto getNombre], [producto getMarca]];
        [listaComboBox addObject:textoProducto];
    }
}

- (IBAction)SeleccionarProductoBD:(id)sender {
    NSInteger i = _cboProductosBD.indexOfSelectedItem - 1;
    if (i == -1){
        [_lblNombreProducto setStringValue:@""];
        [_lblMarcaProducto setStringValue:@""];
        [_lblPrecioProducto setStringValue:@""];
        [_txtCodigoProducto setStringValue:@""];
        [_txtCantidadDeProductos setStringValue:@""];
    }
    else{
        [_lblNombreProducto setStringValue:[[listaProductosBD objectAtIndex:i] getNombre]];
        [_lblMarcaProducto setStringValue:[[listaProductosBD objectAtIndex:i] getMarca]];
        [_lblPrecioProducto setStringValue:[NSString stringWithFormat:@"$ %.2f",[[listaProductosBD objectAtIndex:i] getPrecioVenta]]];
        [_txtCodigoProducto setStringValue:[NSString stringWithFormat:@"%d",[[listaProductosBD objectAtIndex:i] getIdProducto]]];
    }
}

- (IBAction)OnAñadirAlCarrito:(id)sender {
    //primero validamos que haya un elemento seleccionado.
    NSInteger i = _cboProductosBD.indexOfSelectedItem - 1;
    if (i == -1)
    {
        [appdelegate MessageBox:@"Falta Selección" andTitle:@"Debe Seleccionar un producto."];
    }
    else
    {
        Producto *nuevoProducto = [[Producto alloc ]init];
        nuevoProducto = [listaProductosBD objectAtIndex:i];

        //primero validamos que haya suficiente producto en la bd
        Producto* pr = [msqlite traerProducto:i+1];
        if([pr getCantidad] > [_txtCantidadDeProductos intValue])
        {
            //Ahorabuscar si ya existe el producto en la tabla.
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"idProducto == %d", [[listaProductosBD objectAtIndex:i] getIdProducto]];
            NSArray *TablaFiltrada = [listaTabla filteredArrayUsingPredicate:predicate];
            if(TablaFiltrada.count > 0)
            {
                //ya existe el producto en la tabla
                //actualizar cantidades
                int cantidadJueguetesMas = [_txtCantidadDeProductos intValue];
                int cantidadJuguetesEnTabla = [[TablaFiltrada firstObject] getCantidad];
                int cantidadTotal = cantidadJueguetesMas + cantidadJuguetesEnTabla;
                [nuevoProducto setCantidad: cantidadTotal];
                [nuevoProducto setCosto:[nuevoProducto getPrecioVenta]*cantidadTotal];
                NSInteger anIndex = [listaTabla indexOfObject:[TablaFiltrada firstObject]];
                if(NSNotFound == anIndex)
                {
                    NSLog(@"not found");
                }
                [listaTabla replaceObjectAtIndex:anIndex withObject:nuevoProducto];
            }
            else
            {
                //no existe aun el producto en la tabla
                //insertar objeto en lista
                [nuevoProducto setCantidad:[_txtCantidadDeProductos intValue]];
                [nuevoProducto setCosto:[nuevoProducto getPrecioVenta]*[nuevoProducto getCantidad]];
                [listaTabla addObject:nuevoProducto];
            }
            double costoTotal = 0;
            for(id item in listaTabla){
                costoTotal = costoTotal + [item getCosto];
            }
            [_lblTotalDeCompra setStringValue:[NSString stringWithFormat:@"$%.2f",costoTotal]];
            [_TablaCarritoCompras reloadData];
        }
        else{
            [appdelegate MessageBox:@"No existen suficientes productos en la base de datos porfavor digite una cantidad menor o elija otro producto" andTitle:@"Productos Insuficientes"];
        }
    }
  }

- (IBAction)OnRealizarCompra:(id)sender {
    //obtengo datos de venta:
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];// or @"yyyy-MM-dd hh:mm:ss a" if you prefer the time with AM/PM
    NSString *fechaVenta = [dateFormatter stringFromDate:[NSDate date]];
    appdelegate = [AppDelegate getInstance];
    Empleado *e = appdelegate.EmpleadoSesionActivo;

    //Creo query para insertar Venta:
    NSString *queryVenta = [NSString stringWithFormat:@"INSERT INTO Venta (IdEmpleado, FechaVenta, FormaPago, Estatus) VALUES (%d, '%@', '%@', %d);",[e IdEmpleado],fechaVenta,@"Efectivo",1];
    [msqlite ExecuteSqlQuery:queryVenta];

    //Actualizar Inventario con updates y hago inserts de mis detalles de venta.
    for (id producto in listaTabla)
    {
        msqlite = [[ManejadorSQLite alloc]init];
        //obtener la cantidad anterior de bd y restarle la cantidad que estoy comprando
        NSArray *tablabd =[msqlite traerProductos];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"idProducto == %d", [producto getIdProducto]];
        NSArray *TablaFiltrada = [tablabd filteredArrayUsingPredicate:predicate];
        int cantidadAnteriorBD = [[TablaFiltrada firstObject] getCantidad];
        int cantidadArestar = [producto getCantidad];
        int cantidadNueva = cantidadAnteriorBD - cantidadArestar;
        NSString *query = [NSString stringWithFormat: @"UPDATE Producto SET cantidad = %d WHERE idProducto = %d;",cantidadNueva,[producto getIdProducto]];
        [msqlite ExecuteSqlQuery:query];
        
        //ahora inserto mi DetalleVenta
        msqlite = [[ManejadorSQLite alloc]init];
        NSString *queryDetalleVenta = [NSString stringWithFormat:@"INSERT INTO DetalleVenta (IdVenta, IdProducto, Cantidad) VALUES  ((SELECT IdVenta FROM Venta  ORDER BY IdVenta DESC limit 1), %d, %d);",[producto IdProducto],[producto Cantidad]];
        [msqlite ExecuteSqlQuery:queryDetalleVenta];
    }
    [appdelegate MessageBox:@"Se ha realizado su compra con exito." andTitle:@"Compra Exitosa"];
    [listaTabla removeAllObjects];
    [_TablaCarritoCompras reloadData];
}

- (IBAction)EliminarProductoCarrito:(id)sender {
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
                NSInteger row = [_TablaCarritoCompras selectedRow];
                [listaTabla removeObjectAtIndex:row];
                [_TablaCarritoCompras reloadData];
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
