//
//  Window.h
//  Jugueteria_OSX
//
//  Created by Iván Pacheco on 09/06/17.
//  Copyright © 2017 Iván Pacheco. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface Window : NSWindowController

- (IBAction)clickReportes:(id)sender;
- (IBAction)clickAdmin:(id)sender;

@property (weak) IBOutlet NSToolbarItem *ToolBarReportes;
@property (weak) IBOutlet NSToolbarItem *ToolBarAdmin;

@end
