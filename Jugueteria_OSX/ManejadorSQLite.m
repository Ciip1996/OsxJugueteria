//
//  ManejadorSQLite.m
//  Jugueteria_OSX
//
//  Created by Iván Pacheco on 10/06/17.
//  Copyright © 2017 Iván Pacheco. All rights reserved.
//

#import "ManejadorSQLite.h"

@implementation ManejadorSQLite

-(id)init{
    //LLAMAR EL APPDELEGATE DE LA APLICACION
    appdelegate = [[AppDelegate alloc] init];
    return self;
}

/*
 Este metodo accede a la base de datos local de sqlite y devuelve un NSMutableArray de productos
 */
-(NSMutableArray*)traerProductos{
    listaElementos = [[NSMutableArray alloc]init];
    [listaElementos removeAllObjects];
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
                producto  = [[Producto alloc]init];
                [producto setIdProducto:(int)Id.integerValue];
                [producto setNombre:nombre];
                [producto setDescripcion:descripcion];
                [producto setEdadMinima:(int)edadMinima.integerValue];
                [producto setEdadMaxima:(int)edadMaxima.integerValue];
                [producto setMarca:marca];
                [producto setCantidad:(int)cantidad.integerValue];
                [producto setPrecioVenta:precioVenta.doubleValue];
                [listaElementos addObject:producto];
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
    return listaElementos;
}
-(Producto*)traerProducto:(int)Id{
    if (sqlite3_open([appdelegate.databasepath UTF8String], &database)==SQLITE_OK)
    {
        NSString *sqlStatement  = [NSString stringWithFormat:@"SELECT Producto.idProducto,  Producto.nombre, Producto.marca,  Producto.edadMinima, Producto.edadMaxima, Producto.cantidad, Producto.precioVenta, Producto.descripcion FROM Producto WHERE idProducto = %d",Id];
        if (sqlite3_prepare_v2(database, [sqlStatement UTF8String], -1, &CompiledStatement, NULL)==SQLITE_OK)
        {
            if (sqlite3_step(CompiledStatement)==SQLITE_ROW)
            {
                NSString *Id = [NSString stringWithUTF8String:(char *)sqlite3_column_text(CompiledStatement, 0)];
                NSString *nombre = [NSString stringWithUTF8String:(char *)sqlite3_column_text(CompiledStatement, 1)];
                NSString *marca = [NSString stringWithUTF8String:(char *)sqlite3_column_text(CompiledStatement, 2)];
                NSString *edadMinima = [NSString stringWithUTF8String:(char *)sqlite3_column_text(CompiledStatement, 3)];
                NSString *edadMaxima = [NSString stringWithUTF8String:(char *)sqlite3_column_text(CompiledStatement, 4)];
                NSString *cantidad = [NSString stringWithUTF8String:(char *)sqlite3_column_text(CompiledStatement, 5)];
                NSString *precioVenta = [NSString stringWithUTF8String:(char *)sqlite3_column_text(CompiledStatement, 6)];
                NSString *descripcion = [NSString stringWithUTF8String:(char *)sqlite3_column_text(CompiledStatement, 7)];
                producto  = [[Producto alloc]init];
                [producto setIdProducto:(int)Id.integerValue];
                [producto setNombre:nombre];
                [producto setDescripcion:descripcion];
                [producto setEdadMinima:(int)edadMinima.integerValue];
                [producto setEdadMaxima:(int)edadMaxima.integerValue];
                [producto setMarca:marca];
                [producto setCantidad:(int)cantidad.integerValue];
                [producto setPrecioVenta:precioVenta.doubleValue];
            }
        }else
        {
            NSLog(@"No se puede leer los datos");
        }
        sqlite3_finalize(CompiledStatement);
    }
    sqlite3_close(database);
    return producto;
}
-(BOOL)ExecuteSqlQuery:(NSString *)query{
    BOOL response = NO;
    //abrimos la base de datos de la ruta indicada en el delegate
    if (sqlite3_open([appdelegate.databasepath UTF8String], &database)==SQLITE_OK)
    {
        //podriamos seleccionar solo algunos o todos en el orden deseado asi:
        NSString *sqlStatement  = [NSString stringWithFormat:@"%@", query];
        //lanzamos la consulta y recorremos los resultados si todo ha salido bien
        if (sqlite3_prepare_v2(database, [sqlStatement UTF8String], -1, &CompiledStatement, NULL)==SQLITE_OK)
        {
            //recorremos  los resultados. en este caso no habra
            while (sqlite3_step(CompiledStatement)==SQLITE_ROW)
            {
                //leemos las columnas necesarias.aunque algunos valores son numericos prefiero recuperarlos en string y convertirlos luego porque da menos problemas
                response = YES;
            }
        }
        else
        {
            //indico si hubo un error
            [appdelegate MessageBox:@"No se ha podido acceder a la base de datos local." andTitle:@"Error SQLite"];
            response = YES;
        }
        //libero la consulta
        sqlite3_finalize(CompiledStatement);
    }
    //cierro la base de datos
    sqlite3_close(database);
    return response;
}

-(NSString*)Login:(NSString*)usuario yContraseña:(NSString*)contraseña{
    NSString *resp = [[NSString alloc] init];
    if (sqlite3_open([appdelegate.databasepath UTF8String], &database)==SQLITE_OK)
    {
        NSString *sqlStatement  = [NSString stringWithFormat:@"SELECT  E.Rol FROM Usuario AS U INNER JOIN Empleado AS E ON  U.IdEmpleado = E.IdEmpleado WHERE U.Usuario = '%@' AND U.Contrasenia = '%@'",usuario,  contraseña];
        if (sqlite3_prepare_v2(database, [sqlStatement UTF8String], -1, &CompiledStatement, NULL)==SQLITE_OK)
        {
            while (sqlite3_step(CompiledStatement)==SQLITE_ROW)
            {
                resp = [NSString stringWithUTF8String:(char *)sqlite3_column_text(CompiledStatement, 0)];
            }
        }
        else
        {
                resp = @"Usuario o contraseña invalidos";
        }
        sqlite3_finalize(CompiledStatement);
    }
    //cierro la base de datos
    sqlite3_close(database);
    return resp;
}

@end
