//
//  LoginVC.h
//  Jugueteria_OSX
//
//  Created by Iván Pacheco on 06/06/17.
//  Copyright © 2017 Iván Pacheco. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <sqlite3.h>
#import "AppDelegate.h"
#import "ManejadorSQLite.h"


@interface LoginVC : NSViewController{
    AppDelegate *appdelegate;
    ManejadorSQLite *msqlite;
}
@property (weak) IBOutlet NSTextField *txtUsuario;
@property (weak) IBOutlet NSSecureTextField *txtContraseña;
- (IBAction)btnEntrar:(id)sender;

@end
