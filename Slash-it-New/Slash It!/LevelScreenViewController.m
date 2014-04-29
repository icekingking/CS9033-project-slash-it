//
//  LevelScreenViewController.m
//  Screen
//
//  Created by iceking on 3/8/14.
//  Copyright (c) 2014 iceking. All rights reserved.
//

#import "LevelScreenViewController.h"
#import "LevelSetScreenViewController.h"
#import "GameCenterScreenViewController.h"
#import "SettingScreenViewController.h"
#import "ViewController.h"
#import "Audio.h"

@interface LevelScreenViewController ()

@end

@implementation LevelScreenViewController

-(void)initWithLevelSetName:(NSString *)env{

    self.levelSetName = env;
}

- (IBAction)level1button:(id)sender {
    
    ViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
    viewController.levelName= @"level1";
    viewController.levelSetName = self.levelSetName;
    [self.navigationController pushViewController:viewController animated:YES];
    [[Audio sharedInstance] playMusic:@"button_press.wav"];
}

- (IBAction)level2Button:(id)sender {
    
    ViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
    viewController.levelName= @"level2";
    viewController.levelSetName = self.levelSetName;
    [self.navigationController pushViewController:viewController animated:YES];
    [[Audio sharedInstance] playMusic:@"button_press.wav"];
    
}

- (IBAction)level3Button:(id)sender {
    
    ViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
    viewController.levelName= @"level3";
    viewController.levelSetName = self.levelSetName;
    [self.navigationController pushViewController:viewController animated:YES];
    [[Audio sharedInstance] playMusic:@"button_press.wav"];
    
}

- (IBAction)Backbutton:(id)sender {
    [[Audio sharedInstance] playMusic:@"button_press.wav"];
    [self.navigationController popViewControllerAnimated:YES];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([self.levelSetName  isEqual: @"set1"]) {
        UIImage *backgroundImage = [UIImage imageNamed:@"setscreen.jpeg"];
        UIImageView *backgroundImageView=[[UIImageView alloc]initWithFrame:self.view.frame];
        [self.view insertSubview:backgroundImageView atIndex:0];
        backgroundImageView.image=backgroundImage;
        [self.button1 setBackgroundImage:[UIImage imageNamed:@"set1-1.png"]forState:UIControlStateNormal];
        [self.button2 setBackgroundImage:[UIImage imageNamed:@"set1-2.png"]forState:UIControlStateNormal];
        [self.button3 setBackgroundImage:[UIImage imageNamed:@"set1-3.png"]forState:UIControlStateNormal];
    }
    
    if ([self.levelSetName  isEqual: @"set2"]) {
        UIImage *backgroundImage = [UIImage imageNamed:@"setscreen.jpeg"];
        UIImageView *backgroundImageView=[[UIImageView alloc]initWithFrame:self.view.frame];
        [self.view insertSubview:backgroundImageView atIndex:0];
        backgroundImageView.image=backgroundImage;
        [self.button1 setBackgroundImage:[UIImage imageNamed:@"set2-1.png"]forState:UIControlStateNormal];
         [self.button2 setBackgroundImage:[UIImage imageNamed:@"set2-2.png"]forState:UIControlStateNormal];
        [self.button3 setBackgroundImage:[UIImage imageNamed:@"set2-3.png"]forState:UIControlStateNormal];
    }
    
    if ([self.levelSetName  isEqual: @"set3"]) {
        UIImage *backgroundImage = [UIImage imageNamed:@"setscreen.jpeg"];
        UIImageView *backgroundImageView=[[UIImageView alloc]initWithFrame:self.view.frame];
        [self.view insertSubview:backgroundImageView atIndex:0];
        backgroundImageView.image=backgroundImage;
        [self.button1 setBackgroundImage:[UIImage imageNamed:@"set3-1.png"]forState:UIControlStateNormal];
        [self.button2 setBackgroundImage:[UIImage imageNamed:@"set3-2.png"]forState:UIControlStateNormal];
        [self.button3 setBackgroundImage:[UIImage imageNamed:@"set3-3.png"]forState:UIControlStateNormal];
       
    }
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
