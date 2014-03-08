//
//  ViewController.m
//  Screen
//
//  Created by iceking on 3/8/14.
//  Copyright (c) 2014 iceking. All rights reserved.
//

#import "ViewController.h"
#import "MyScene.h"
#import "ScoreScreenViewController.h"

@implementation ViewController






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





- (IBAction)pausebutton:(id)sender {
    
    ScoreScreenViewController *scoreScreenViewController = [[ScoreScreenViewController alloc] init];
    scoreScreenViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ScoreScreenViewController"];
    
    [self presentViewController:scoreScreenViewController animated:YES completion:Nil];
    
    //SKView *spriteView = (SKView *) self.view;
    //SKScene *currentScene = [spriteView scene];
    
    /*
    [newScene.userData setObject:[currentScene.userData objectForKey:@"score"] forKey:@"score"];
    [spriteView presentScene:newScene];
     */
    
    
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
