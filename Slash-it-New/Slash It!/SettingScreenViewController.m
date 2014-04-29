//
//  SettingScreenViewController.m
//  Screen
//
//  Created by iceking on 3/8/14.
//  Copyright (c) 2014 iceking. All rights reserved.
//

#import "SettingScreenViewController.h"
#import "HomeScreenViewController.h"
#import "Audio.h"

@interface SettingScreenViewController ()

@end

@implementation SettingScreenViewController

- (IBAction)backbutton:(id)sender {
    [[Audio sharedInstance] playMusic:@"button_press.wav"];
    [self.navigationController popViewControllerAnimated:YES];
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
    
    [super viewDidLoad];
    UIImage *backgroundImage = [UIImage imageNamed:@"homebg.png"];
    UIImageView *backgroundImageView=[[UIImageView alloc]initWithFrame:self.view.frame];
    [self.view insertSubview:backgroundImageView atIndex:0];
    backgroundImageView.image=backgroundImage;
    
    AnimatedPic1.animationImages = [NSArray arrayWithObjects:
                                   [UIImage imageNamed:@"toturial1.png"],
                                   [UIImage imageNamed:@"toturial1.png"],
                                   [UIImage imageNamed:@"toturial2.png"],
                                   [UIImage imageNamed:@"toturial3.png"],
                                   [UIImage imageNamed:@"toturial4.png"],
                                   [UIImage imageNamed:@"toturial4.png"],nil];
    [AnimatedPic1 setAnimationRepeatCount:0];
    AnimatedPic1.animationDuration = 4;
    [AnimatedPic1 startAnimating];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
