//
//  Venta.h
//  Jugueteria_OSX
//
//  Created by Iván Pacheco on 12/06/17.
//  Copyright © 2017 Iván Pacheco. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Empleado.h"

@interface Venta : NSObject

@property int IdVenta;
@property NSString *FechaVenta;
@property NSString *FormaPago;
@property int Estatus;
@property Empleado *Empleado;



@end
