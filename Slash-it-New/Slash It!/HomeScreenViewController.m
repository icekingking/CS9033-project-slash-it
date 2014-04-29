//
//  HomeScreenViewController.m
//  Screen
//
//  Created by iceking on 3/8/14.
//  Copyright (c) 2014 iceking. All rights reserved.
//

#import "HomeScreenViewController.h"
#import "LevelSetScreenViewController.h"
#import "SettingScreenViewController.h"
#import "GameCenterScreenViewController.h"
#import "Audio.h"

@interface HomeScreenViewController ()

@end

@implementation HomeScreenViewController


- (IBAction)scorebutton:(id)sender {
    
    [[Audio sharedInstance] playMusic:@"button_press.wav"];
    
    GameCenterScreenViewController *gameCenterScreenViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"GameCenterScreenViewController"];
    [self.navigationController pushViewController:gameCenterScreenViewController animated:NO];
}


- (IBAction)playbutton:(id)sender {
    
    [[Audio sharedInstance] playMusic:@"button_press.wav"];
    
    LevelSetScreenViewController *levelSetScreenViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LevelSetScreenViewController"];
    [self.navigationController pushViewController:levelSetScreenViewController animated:NO];
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    
    AnimatedPic.animationImages = [NSArray arrayWithObjects:
                                   [UIImage imageNamed:@"animation0.jpeg"],
                                   [UIImage imageNamed:@"animation0.jpeg"],
                                   [UIImage imageNamed:@"animation0.jpeg"],
                                   [UIImage imageNamed:@"animation1.jpeg"],
                                   [UIImage imageNamed:@"animation2.jpeg"],
                                   [UIImage imageNamed:@"animation3.jpeg"],
                                   [UIImage imageNamed:@"animation4.jpeg"],
                                   [UIImage imageNamed:@"animation5.jpeg"],nil];
    [AnimatedPic setAnimationRepeatCount:1];
    AnimatedPic.animationDuration = 1;
    [AnimatedPic startAnimating];
    
    [[Audio sharedInstance] pauseBackgroundMusic];
    [[Audio sharedInstance] playBackgroundMusic:@"bgmain.mp3"];
    [super viewDidLoad];
    UIImage *backgroundImage = [UIImage imageNamed:@"homebg.png"];
    UIImageView *backgroundImageView=[[UIImageView alloc]initWithFrame:self.view.frame];
    [self.view insertSubview:backgroundImageView atIndex:0];
    backgroundImageView.image=backgroundImage;
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
