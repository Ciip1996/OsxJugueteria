//
//  InventarioVC.m
//  Jugueteria_OSX
//
//  Created by Iván Pacheco on 08/06/17.
//  Copyright © 2017 Iván Pacheco. All rights reserved.
//

#import "InventarioVC.h"
#import "AlimentadorInventarioVC.h"
#import "Producto.h"
#import "AFNetworking.h"

@interface InventarioVC ()

@end

@implementation InventarioVC

@synthesize ListaProductos = _ListaProductos;

-(id)init{
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //LLAMAR EL APPDELEGATE DE LA APLICACION
    appdelegate = [[AppDelegate alloc] init];
    //inicializar la NSMutableArray
    _ListaProductos = [[NSMutableArray alloc]init];
    //AppDelegate *myAppDelegate = [[NSApplication sharedApplication] delegate];
    lstID = [[NSArray alloc] init];
    [self ConsultarProductos];
}

-(void)ConsultarProductos {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [manager GET:@"http://192.168.43.194:55929/api/Productos" parameters:nil progress:nil success:^(NSURLSessionTask *task, id objectResponse) {
        _datosJson = (NSDictionary *) objectResponse;
        
        for(NSObject* key in _datosJson) {
            Producto *p = [[Producto alloc] init];
            
            [p setIdProducto:(int)[key valueForKey:@"IdProducto"]];
            [p setNombre:(NSString *)[key valueForKey:@"Nombre"]];
            [p setDescripcion:(NSString *)[key valueForKey:@"Descripcion"]];
            [p setMarca:(NSString *)[key valueForKey:@"Marca"]];
            [p setEdadMinima:(int)[key valueForKey:@"EdadMinima"]];
            [p setEdadMaxima:(int)[key valueForKey:@"EdadMaxima"]];
            [p setCantidad:(int)[key valueForKey:@"Cantidad"]];
            [p setPrecioVenta:(int)[key valueForKey:@"PrecioVenta"]];
            
            [_ListaProductos addObject:p];
            
            [_TablaProductos reloadData];
        }}failure:^(NSURLSessionTask *operation, NSError *error) {
            NSLog(@"Error: %@", error);
            
        }];
}

-(void)ActualizarProductos {
    /*AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSMutableArray *ID = [_ListaProductos objectAtIndex:0];
    NSLog(@"%@", ID);
    [manager PUT:@"http://192.168.43.194:55929/api/Productos/" parameters:nil success:^(NSURLSessionTask *task, id objectResponse) {
     NSLog(@"%@");
     }failure:^(NSURLSessionTask *operation, NSError *error) {
     NSLog(@"Error: %@", error);
     
     }];*/
    
}

- (void)ConsultarDatos {
    sqlite3 *database;
    sqlite3_stmt *CompiledStatement;
    [_ListaProductos removeAllObjects];
    //abrimos la base de datos de la ruta indicada en el delegate
    if (sqlite3_open([appdelegate.databasepath UTF8String], &database)==SQLITE_OK)
    {
        //podriamos seleccionar solo algunos o todos en el orden deseado asi:
        NSString *sqlStatement  = [NSString stringWithFormat:@"SELECT Producto.idProducto,  Producto.nombre, Producto.marca,  Producto.edadMinima, Producto.edadMaxima, Producto.cantidad, Producto.precioVenta, Producto.descripcion FROM Producto"];
        //lanzamos la consulta y recorremos los resultados si todo ha salido bien
        if (sqlite3_prepare_v2(database, [sqlStatement UTF8String], -1, &CompiledStatement, NULL)==SQLITE_OK)
        {
            //recorremos  los resultados. en este caso no habra
            while (sqlite3_step(CompiledStatement)==SQLITE_ROW)
            {
                //leemos las columnas necesarias.aunque algunos valores son numericos prefiero recuperarlos en string y convertirlos luego porque da menos problemas
                NSString *Id = [NSString stringWithUTF8String:(char *)sqlite3_column_text(CompiledStatement, 0)];
                NSString *nombre = [NSString stringWithUTF8String:(char *)sqlite3_column_text(CompiledStatement, 1)];
                NSString *marca = [NSString stringWithUTF8String:(char *)sqlite3_column_text(CompiledStatement, 2)];
                NSString *edadMinima = [NSString stringWithUTF8String:(char *)sqlite3_column_text(CompiledStatement, 3)];
                NSString *edadMaxima = [NSString stringWithUTF8String:(char *)sqlite3_column_text(CompiledStatement, 4)];
                NSString *cantidad = [NSString stringWithUTF8String:(char *)sqlite3_column_text(CompiledStatement, 5)];
                NSString *precioVenta = [NSString stringWithUTF8String:(char *)sqlite3_column_text(CompiledStatement, 6)];
                NSString *descripcion = [NSString stringWithUTF8String:(char *)sqlite3_column_text(CompiledStatement, 7)];
                Producto *objProducto  = [[Producto alloc]init];
                [objProducto setIdProducto:(int)Id.integerValue];
                [objProducto setNombre:nombre];
                [objProducto setDescripcion:descripcion];
                [objProducto setEdadMinima:(int)edadMinima.integerValue];
                [objProducto setEdadMaxima:(int)edadMaxima.integerValue];
                [objProducto setMarca:marca];
                [objProducto setCantidad:(int)cantidad.integerValue];
                [objProducto setPrecioVenta:precioVenta.doubleValue];
                [_ListaProductos addObject:objProducto];
            }
        }else
        {
            //indico si hubo un error
            NSLog(@"No se puede leer los datos");
        }
        //libero la consulta
        sqlite3_finalize(CompiledStatement);
    }
    //cierro la base de datos
    sqlite3_close(database);
    [_TablaProductos reloadData];
}
/*
 Este metodo manda llamar una consulta a la base de datos local.
 */
- (IBAction)OnClickAlimentarInventariobtn:(id)sender {
    appdelegate = [AppDelegate getInstance];
    Empleado *empleado = appdelegate.EmpleadoSesionActivo;
    if([[empleado Rol] isEqualToString:@"Admin"] || [[empleado Rol] isEqualToString:@"Almacenista"]){
        [_btnAlimentarInventario setEnabled:YES];
        NSStoryboard *storyboard = [NSStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        AlimentadorInventarioVC *controller = (AlimentadorInventarioVC *)[storyboard instantiateControllerWithIdentifier:@"AlimentadorInventario"];
        [self presentViewControllerAsModalWindow:controller];

    }
    else{
        [_btnAlimentarInventario setEnabled:NO];
        [appdelegate MessageBox:@"Debe haberse logeado como administrador o almacenista." andTitle:@"Permiso denegado"];
    }
}

- (IBAction)RefrescarTabla:(id)sender {
    _ListaProductos = [[NSMutableArray alloc]init];
    //refresca la lista de productos de la bd
    [self ConsultarProductos];
    //Recargar o refrescar la tabla
    [_TablaProductos reloadData];
}
/*
 Metodo que automatiza el despliego de un alert en la interfaz.
 */
-(void) MessageBox:(NSString *)Message andTitle:(NSString *)titulo{
    NSAlert *alert = [[NSAlert alloc] init];
    [alert addButtonWithTitle:@"Continuar"];
    [alert setMessageText:titulo];
    [alert setInformativeText:Message];
    [alert setAlertStyle:NSAlertStyleInformational];
    [alert runModal];
}
/*
 Manejador de la tableView
 */
-(NSInteger) numberOfRowsInTableView:(NSTableView *)tableView{
    return   [_ListaProductos count];
}
/*
 Manejador de la tableView
 */
-(id) tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row{
    Producto *producto = [_ListaProductos objectAtIndex:row];
    NSString *identifier = [tableColumn identifier];
    NSString *columna = [producto valueForKey:identifier];
    return columna;
}
/*
 El siguiente metodo elimina graficamente un renglon de la tabla. Es mandado llamar por el btn Eliminar y tambien al oprimir la tecla delete de el teclado.
 */
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
                NSInteger row = [_TablaProductos selectedRow];
                [_ListaProductos removeObjectAtIndex:row];
                [_TablaProductos reloadData];
            }
            else if(returnCode == NSAlertSecondButtonReturn){
                //No hace nada.
            }
        }];
    }
    @catch (NSException *exception)
    {
        [self MessageBox:@"No se pudo eliminar" andTitle:@"Error"];
    }
}
/*
 Este evento se activa cuando se da doble click en el renglon seleccionado de la tabla principal.
 */
- (IBAction)dobleClickRenglon:(id)sender {
    
    
}
/*
 Este metodo es activado siempre que el usuario oprime la tecla delete de el teclado. Valida que este algun renglon de la tabla seleccionado y de no ser asi no ejecuta ninguna acción.
 */
-(IBAction)deleteRow:(id)sender{
    NSInteger selectedRow = [_TablaProductos selectedRow];
    if (selectedRow != -1) {//valida que haya algo seleccionado.
        [self Eliminar:NULL];//manda llamar el metodo de esta clase llamado eliminar.
    }
    else {//avisa que no hay nada seleccionado.
        [self MessageBox:@"Debe seleccionar un registro de la tabla para poder borrarlo." andTitle:@"Seleccione un Renglon."];
    }
}

@end
