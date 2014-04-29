//
//  LevelSetScreenViewController.m
//  Slash It!
//
//  Created by Savan on 4/15/14.
//  Copyright (c) 2014 Savan Rupani. All rights reserved.
//

#import "LevelSetScreenViewController.h"
#import "HomeScreenViewController.h"
#import "LevelScreenViewController.h"
#import "SettingScreenViewController.h"
#import "Audio.h"

@interface LevelSetScreenViewController ()

@end

@implementation LevelSetScreenViewController


- (IBAction)toturialbutton:(id)sender {
    SettingScreenViewController *settingScreenViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SettingScreenViewController"];
    [self.navigationController pushViewController:settingScreenViewController animated:YES];
    [[Audio sharedInstance] playMusic:@"button_press.wav"];
}


- (IBAction)set1Clicked:(id)sender {
    LevelScreenViewController *levelScreenViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LevelScreenViewController"];
    levelScreenViewController.levelSetName= @"set1";
    
    [self.navigationController pushViewController:levelScreenViewController animated:YES];
    [[Audio sharedInstance] playMusic:@"Earth.mp3"];
    
}

- (IBAction)set2Clicked:(id)sender {
    
    LevelScreenViewController *levelScreenViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LevelScreenViewController"];
    levelScreenViewController.levelSetName= @"set2";
    
    [self.navigationController pushViewController:levelScreenViewController animated:YES];
    [[Audio sharedInstance] playMusic:@"Water.mp3"];
    
}

- (IBAction)set3Clicked:(id)sender {
    LevelScreenViewController *levelScreenViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LevelScreenViewController"];
    levelScreenViewController.levelSetName= @"set3";
    
    [self.navigationController pushViewController:levelScreenViewController animated:YES];
    [[Audio sharedInstance] playMusic:@"Space.mp3"];
    
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
- (void)viewDidLoad{
    
    [super viewDidLoad];
    UIImage *backgroundImage = [UIImage imageNamed:@"setscreen.jpeg"];
    UIImageView *backgroundImageView=[[UIImageView alloc]initWithFrame:self.view.frame];
    [self.view insertSubview:backgroundImageView atIndex:0];
    backgroundImageView.image=backgroundImage;
	// Do any additional setup after loading the view.
}
- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
