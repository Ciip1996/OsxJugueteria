//
//  Producto.m
//  Jugueteria_OSX
//
//  Created by Iván Pacheco on 04/04/17.
//  Copyright © 2017 Iván Pacheco. All rights reserved.
//

#import "Producto.h"

@implementation Producto

@synthesize IdProducto = IdProducto;
@synthesize Nombre = Nombre;
@synthesize Marca = Marca;
@synthesize Descripcion = Descripcion;
@synthesize EdadMinima = EdadMinima;
@synthesize EdadMaxima = EdadMaxima;
@synthesize Cantidad = Cantidad;
@synthesize PrecioVenta = PrecioVenta;

//sintesis y metodos no genericos
@synthesize nuevo = nuevo;
@synthesize Costo = Costo;
-(BOOL)esNuevo{
    return nuevo;
}
-(double)getCosto{
    return Costo;
}


-(int)getIdProducto{
    return IdProducto;
}
-(NSString*)getNombre{
    return Nombre;
}
-(NSString*)getMarca{
    return Marca;
}
-(NSString*)getDescripcion{
    return Descripcion;
}

-(int)getEdadMinima{
    return EdadMinima;
}

-(int)getEdadMaxima{
    return EdadMinima;
}

-(int)getCantidad{
    return Cantidad;
}

-(double)getPrecioVenta{
    return PrecioVenta;
}


@end
