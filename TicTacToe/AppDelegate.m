//
//  AppDelegate.m
//  TicTacToe
//
//  Created by Pramati technologies on 9/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "ServerBrowserTableViewController.h"
#import "GameViewController.h"

@implementation AppDelegate

@synthesize window;
@synthesize navigationController;

- (void)applicationDidFinishLaunching:(UIApplication *)application {
	
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    
    NSString *type = @"TicTacToe";
    _server = [[Server alloc] initWithProtocol:type];
    _server.delegate = self;
    NSError *error = nil;
    if(![_server start:&error]) {
        NSLog(@"error = %@", error);
    }
        
    serverBrowserVC = [[ServerBrowserTableViewController alloc] init];
    serverBrowserVC.server = _server;
    self.navigationController = [[UINavigationController alloc] initWithRootViewController:serverBrowserVC];
	// Configure and show the window
	[window addSubview:[navigationController view]];
	[window makeKeyAndVisible];
}

#pragma mark Server Delegate Methods

- (void)serverRemoteConnectionComplete:(Server *)server {
    NSLog(@"Server Started");
    // this is called when the remote side finishes joining with the socket as
    // notification that the other side has made its connection with this side
    gameVC = [[GameViewController alloc] initWithNibName:@"GameViewController" bundle:nil];
    gameVC.server = server;
    [self.navigationController pushViewController:gameVC animated:YES];
}

- (void)serverStopped:(Server *)server {
    NSLog(@"Server stopped");
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)server:(Server *)server didNotStart:(NSDictionary *)errorDict {
    NSLog(@"Server did not start %@", errorDict);
}

- (void)server:(Server *)server didAcceptData:(NSData *)data {
    NSLog(@"Server did accept data %@", data);
    NSString *message = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
    if(nil != message || [message length] > 0) {
        [gameVC placeOn:[message intValue]];
    } else {
        //gameVC.message = @"no data received";
    }
}

- (void)server:(Server *)server lostConnection:(NSDictionary *)errorDict {
    NSLog(@"Server lost connection %@", errorDict);
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)serviceAdded:(NSNetService *)service moreComing:(BOOL)more {
    [serverBrowserVC addService:service moreComing:more];
}

- (void)serviceRemoved:(NSNetService *)service moreComing:(BOOL)more {
    [serverBrowserVC removeService:service moreComing:more];
}

#pragma mark -

- (void)applicationWillTerminate:(UIApplication *)application {
    [_server stop];
    [_server stopBrowser];
}

- (void)dealloc {
	self.navigationController = nil;
    self.window = nil;
    [gameVC release];
    gameVC = nil;
    [serverBrowserVC release];
    serverBrowserVC = nil;
    [_server release];
    _server = nil;
	[super dealloc];
}


@end
