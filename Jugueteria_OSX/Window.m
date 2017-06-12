//
//  Window.m
//  Jugueteria_OSX
//
//  Created by Iván Pacheco on 09/06/17.
//  Copyright © 2017 Iván Pacheco. All rights reserved.
//

#import "Window.h"
#import "InventarioVC.h"
#import "AppDelegate.h"

@interface Window ()

@end

@implementation Window

- (void)windowDidLoad {
    [super windowDidLoad];
    
    self.window.titlebarAppearsTransparent = YES;
    self.window.titleVisibility = NSWindowTitleHidden;
    self.window.opaque = NO;
    self.window.contentView.wantsLayer = YES;
    
    
    NSVisualEffectView *blur = [[NSVisualEffectView alloc] initWithFrame: NSMakeRect(0, 0, 3000, 3000)];
    blur.material = NSVisualEffectMaterialPopover;//NSVisualEffectMaterialAppearanceBased;
    blur.blendingMode = NSVisualEffectBlendingModeBehindWindow;
    blur.state = NSVisualEffectStateActive;
    
    
    NSMutableArray *arreglo = [[NSMutableArray alloc] initWithArray:self.window.contentView.subviews];
    [arreglo insertObject:blur atIndex:0];
    
    NSTabView *tabview = [[NSTabView alloc] init];
    tabview =(NSTabView*)[arreglo objectAtIndex:1];
    tabview.window.backgroundColor = [NSColor clearColor];
    
    [arreglo setObject:tabview atIndexedSubscript:1];
    
    self.window.contentView.subviews = arreglo;
    self.window.backgroundColor = [NSColor colorWithSRGBRed:.98 green:.97 blue:.99 alpha:.85];//ajusta el color y transparencia de la barra toolbar y de titulo.

    
    
    //self.window.styleMask = NSWindowStyleMaskTitled;//Oculta los botones de cerrar, minimizar y cerrar.
    
    //self.window.styleMask = NSWindowStyleMaskDocModalWindow;//oculta el toolbar y barra de titulo
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    /*self.window.styleMask = NSWindowStyleMaskUnifiedTitleAndToolbar;   //(NSWindowStyleMask.unifiedTitleAndToolbar);
    self.window.styleMask = NSWindowStyleMaskFullSizeContentView;
    self.window.styleMask = NSWindowStyleMaskTitled;//  .insert(NSWindowStyleMask.titled);
    self.window.toolbar.visible = YES;
    self.window.titleVisibility = NSWindowTitleHidden;
    self.window.titlebarAppearsTransparent = NO;*/
}

- (IBAction)clickReportes:(id)sender {
    int x = 0;
}

- (IBAction)clickAdmin:(id)sender {
    int x = 0;
}
@end
