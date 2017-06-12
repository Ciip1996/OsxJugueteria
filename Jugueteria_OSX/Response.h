//
//  Response.h
//  Jugueteria_OSX
//
//  Created by Iván Pacheco on 12/06/17.
//  Copyright © 2017 Iván Pacheco. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Empleado.h"


@interface Response : NSObject

@property Empleado *Empleado;
@property NSString *stringResponseMessage;

@end
