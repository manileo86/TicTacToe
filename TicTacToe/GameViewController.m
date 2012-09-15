//
//  GameViewController.m
//  TicTacToe
//
//  Created by Pramati technologies on 9/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GameViewController.h"
#import "Server.h"

@interface GameViewController()

-(IBAction)buttonPressed:(id)sender;

@end

@implementation GameViewController

@synthesize server;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(IBAction)buttonPressed:(id)sender
{
    UIButton *button = (UIButton*)sender;
    [button setImage:[UIImage imageNamed:self.server.isOwner?@"x.png":@"o.png"] forState:UIControlStateNormal];    
    NSLog(@"Button - %d", button.tag);
    
    NSData *data = [[NSString stringWithFormat:@"%d",button.tag] dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    [self.server sendData:data error:&error];
}

-(void)placeOn:(NSUInteger)tag
{
    id aSubview = [self.view viewWithTag:tag];
    if(aSubview && [aSubview isKindOfClass:[UIButton class]])
    {
        UIButton *button = (UIButton*)aSubview;
        [button setImage:[UIImage imageNamed:self.server.isOwner?@"o.png":@"x.png"] forState:UIControlStateNormal];
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void) dealloc
{
    //[server release];
    [super dealloc];
}

@end
