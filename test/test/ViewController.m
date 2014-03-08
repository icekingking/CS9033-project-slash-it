//
//  ViewController.m
//  test
//
//  Created by iceking on 3/6/14.
//  Copyright (c) 2014 iceking. All rights reserved.
//

#import "ViewController.h"
#import "MyScene.h"

@implementation ViewController


- (IBAction)buttonpress:(UIButton *)sender {
    if([sender.titleLabel.text isEqualToString:@"button1"]){
        self.label.text = @"user press buton1";
    }
    if([sender.titleLabel.text isEqualToString:@"button2"]){
        self.label.text = @"user press buton2";
    }
    self.label2.text = user_input;
    
}

-(void)passinput:(NSString *)input{
    user_input = input;
}


- (void)viewDidLoad
{
    [super viewDidLoad];

    // Configure the view.
    SKView * skView = (SKView *)self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    
    // Create and configure the scene.
    SKScene * scene = [MyScene sceneWithSize:skView.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    // Present the scene.
    [skView presentScene:scene];
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

@end
