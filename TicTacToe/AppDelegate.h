//
//  AppDelegate.h
//  TicTacToe
//
//  Created by Pramati technologies on 9/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Server.h"

@class ViewController;
@class ServerBrowserTableViewController;
@class GameViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate, ServerDelegate>
{
    Server *_server;
    UIWindow *window;
    UINavigationController *navigationController;
    ServerBrowserTableViewController *serverBrowserVC;
    GameViewController *gameVC;    
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *navigationController;

@end
