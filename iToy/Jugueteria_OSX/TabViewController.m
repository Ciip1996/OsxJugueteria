//
//  TabViewController.m
//  Jugueteria_OSX
//
//  Created by Iván Pacheco on 06/06/17.
//  Copyright © 2017 Iván Pacheco. All rights reserved.
//

#import "TabViewController.h"
#import "LoginVC.h"

@interface TabViewController ()

@end

@implementation TabViewController

-(void)viewWillAppear{
    [self ShowLogin:nil];
    NSStoryboard *storyboard = [NSStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    NSWindowController *controller = (NSWindowController *)[storyboard instantiateControllerWithIdentifier:@"windowController"];
    controller.window.titlebarAppearsTransparent = YES;
    controller.window.titleVisibility = NSWindowTitleHidden;
    [self.tabView setControlTint:NSClearControlTint];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    
}
-(IBAction)ShowLogin:(id)sender{
    NSStoryboard *storyboard = [NSStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    LoginVC *controller = (LoginVC *)[storyboard instantiateControllerWithIdentifier:@"Login"];
    //LoginVC *login = [[LoginVC alloc] init];
    [self presentViewControllerAsSheet:controller];
}
@end
