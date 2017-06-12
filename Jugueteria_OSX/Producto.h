//
//  Producto.h
//  Jugueteria_OSX
//
//  Created by Iván Pacheco on 04/04/17.
//  Copyright © 2017 Iván Pacheco. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Producto : NSObject

//propiedades genericas
@property int IdProducto;
@property NSString *Nombre;
@property NSString *Descripcion;
@property NSString *Marca;
@property int EdadMinima;
@property int EdadMaxima;
@property int Cantidad;
@property double PrecioVenta;

//propiedades no genericas
@property BOOL nuevo;
@property double Costo;

//metodos no genericos
-(BOOL)esNuevo;
-(double)getCosto;

//Metodos genericos
-(NSString*)getNombre;
-(NSString*)getMarca;
-(NSString*)getDescripcion;
-(int)getIdProducto;
-(int)getEdadMinima;
-(int)getEdadMaxima;
-(int)getCantidad;
-(double)getPrecioVenta;


@end
