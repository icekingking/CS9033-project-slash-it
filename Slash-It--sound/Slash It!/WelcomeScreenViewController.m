//
//  WelcomeScreenViewController.m
//  Screen
//
//  Created by iceking on 3/8/14.
//  Copyright (c) 2014 iceking. All rights reserved.
//

#import "WelcomeScreenViewController.h"
#import "HomeScreenViewController.h"

@interface WelcomeScreenViewController ()

@end

@implementation WelcomeScreenViewController

@synthesize SwitchTimer;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
//    [super viewDidLoad];
    UIImage *backgroundImage = [UIImage imageNamed:@"background.jpg"];
    UIImageView *backgroundImageView=[[UIImageView alloc]initWithFrame:self.view.frame];
    [self.view insertSubview:backgroundImageView atIndex:0];
    backgroundImageView.image=backgroundImage;
    
    
    temp = [Global_variable singleObj];
    temp.gblInt = 0;
    
    SwitchTimer =[NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(SwitchViews:)userInfo:nil repeats:NO];
	// Do any additional setup after loading the view.
}

- (void)viewDidLoad
{
}

-(void)SwitchViews:()sender
{
    // Now call your methode you use to switch views
        
    HomeScreenViewController *levelViewController = [[HomeScreenViewController alloc] init];
    levelViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeScreenViewController"];
    
    [self presentViewController:levelViewController animated:YES completion:Nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
