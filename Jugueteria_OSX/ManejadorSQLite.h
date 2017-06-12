//
//  ManejadorSQLite.h
//  Jugueteria_OSX
//
//  Created by Iván Pacheco on 10/06/17.
//  Copyright © 2017 Iván Pacheco. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>
#import <sqlite3.h>
#import "AppDelegate.h"
#import "Producto.h"
#import "Empleado.h"
#import "Response.h"
#import "Reporte.h"

@interface ManejadorSQLite : NSObject
{
    NSMutableArray *listaElementos;
    AppDelegate *appdelegate;
    Producto *producto;
    sqlite3 *database;
    sqlite3_stmt *CompiledStatement;

}

-(Producto*)traerProducto:(int)Id;

-(NSMutableArray*)traerProductos;

-(BOOL)ExecuteSqlQuery:(NSString*)query;

-(Response*)Login:(NSString*)usuario yContraseña:(NSString*)contraseña;

-(NSObject*)traerEmpleado:(NSString*)usuario yContraseña:(NSString*)contraseña;

-(NSMutableArray*)SelectSomething:(NSString*)query;


-(id)init;

@end
