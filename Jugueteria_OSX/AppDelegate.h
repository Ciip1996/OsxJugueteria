//
//  AppDelegate.h
//  Jugueteria_OSX
//
//  Created by Iván Pacheco on 04/04/17.
//  Copyright © 2017 Iván Pacheco. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>{
    NSWindow *ventana;
    NSString *EmpleadoRol;
}
@property(nonatomic,retain)NSString *EmpleadoRol;
+(AppDelegate*)getInstance;

@property (nonatomic,strong) NSString *databasename;
@property (nonatomic,strong) NSString *databasepath;
-(void) loadDB;
-(void) replicarBD;
-(id) init;
-(void)MessageBox:(NSString *)Message andTitle:(NSString *)titulo;

@end

