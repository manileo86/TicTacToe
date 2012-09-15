//
//  GameViewController.h
//  TicTacToe
//
//  Created by Pramati technologies on 9/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Server;

@interface GameViewController : UIViewController
{
    Server *_server;
}
@property(nonatomic, retain) Server *server;
-(void)placeOn:(NSUInteger)tag;

@end
