//
//  GameScene.m
//  Slash It!
//
//  Created by Savan on 3/23/14.
//  Copyright (c) 2014 Savan Rupani. All rights reserved.
//

#import "GameScene.h"
#import "Math.h"
#import "ViewController.h"
#import "LevelScreenViewController.h"
#import "MovingObject.h"
#import "Audio.h"

static const uint8_t boundry   =  0x1 << 1;
static const uint8_t catd      =  0x1 << 2;
static const uint8_t lined     =  0x1 << 3;
static const uint8_t selfContainer = 0x1 << 4;
static const uint8_t fixedObjectd = 0x1 << 5;

static const double infinity = 9999999999;

@implementation GameScene{

    //Stores random moving objects
    
    //Stores polygon points
    NSMutableArray *polygonPoints,*polygonLowerBoundPoints,*polygonUpperBoundPoints;
    
    //stores polygon path
    CGMutablePathRef polygonPath,polygonPath1,polygonPath2;
    
    //lineCut path
    CGMutablePathRef pathToDraw;
    NSNumber *objectSpeed;
    SKShapeNode *polygonBoundry,*lineCut,*polygon1,*polygon2;
    
    CGPoint lineCutFirstPoint,lineCutSecondPoint;
    
    float ix1,ix2,iy1,iy2;
    float areaOfPolygonPercentage;
    float areaOfPolygonBefore;
    float areaOfPolygonCurrent;
    
    float velocity1,velocity2;
    SKAction *backgroundmusic;
    SKAction *cutmusic;
    
    // add fixed node here
    MovingObject *fixedObject;
    MovingObject *movingOb;
    
    NSDictionary *playerScore;
    NSDictionary *levelScore;
    
    NSTimer *timer;
    NSTimer *speedtimer;
    
    NSMutableArray *playerScores;

}


-(id)initWithSize:(CGSize)size {
    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        //self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        
       

        
        self.scaleMode = SKSceneScaleModeAspectFit;
        self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
        self.physicsWorld.gravity = CGVectorMake(0.0f,0.0f);
        self.physicsBody.categoryBitMask = selfContainer;
        self.physicsWorld.contactDelegate = self;
        self.physicsBody.node.name = @"body";
        
        /* Setup your scene here */
        NSLog(@"Screen Size: %f %f",self.frame.size.width,self.frame.size.height);
        
        movingOb = [[MovingObject alloc]init];
        fixedObject = [[MovingObject alloc]init];
        polygonPoints = [[NSMutableArray alloc] init];
        polygonBoundry = [[SKShapeNode alloc]init];
        
        polygon1 = [[SKShapeNode alloc]init];
        polygon2 = [[SKShapeNode alloc]init];
        
        
        polygonLowerBoundPoints = [[NSMutableArray alloc] init];
        polygonUpperBoundPoints = [[NSMutableArray alloc] init];
        
        
        _numberOfObjects = 0;
        _levelSetName = NULL;
        _levelName = NULL;
        _intersectionCount =0;
        _drawLineCut = 1;
        _numberOfCuts = 0;
        _finalTime = 0;
        _gamePaused = 0;
        fixedObject = NULL;
        _maxScore = 0;
        cutmusic = [SKAction playSoundFileNamed:@"cut.mp3" waitForCompletion:NO];
        playerScores = [[NSMutableArray alloc] init];
        
        
    }
    return self;
}


-(void)draw{
    
    
    if ([_levelSetName isEqualToString:@"set1"]) {
        SKSpriteNode *bk1 = [SKSpriteNode spriteNodeWithImageNamed:@"earth.jpg"];
        bk1.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame));
        bk1.name = @"BACKGROUND1";
        [self addChild:bk1];
        [[Audio sharedInstance] playBackgroundMusic:@"bgland.mp3"];
    }
    
    if ([_levelSetName isEqualToString:@"set2"]) {
        SKSpriteNode *bk2 = [SKSpriteNode spriteNodeWithImageNamed:@"mars.jpg"];
        bk2.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame));
        bk2.name = @"BACKGROUND2";
        [self addChild:bk2];
        [[Audio sharedInstance] playBackgroundMusic:@"bgwater.mp3"];
    }
    
    if ([_levelSetName isEqualToString:@"set3"]) {
        SKSpriteNode *bk3 = [SKSpriteNode spriteNodeWithImageNamed:@"moon.jpg"];
        bk3.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame));
        bk3.name = @"BACKGROUND2";
        [self addChild:bk3];
        [[Audio sharedInstance] playBackgroundMusic:@"bgspace.mp3"];
    }
    
    NSString *plistLevel = [[NSBundle mainBundle] pathForResource:@"Level-plist" ofType:@"plist"];
    
    NSDictionary *levelSetDictionary = [[NSDictionary alloc] initWithContentsOfFile:plistLevel];
    NSDictionary *levelDictionary = [[NSDictionary alloc] initWithDictionary:[levelSetDictionary objectForKey:self.levelSetName]];
    
    NSArray *tempLevel = [[NSArray alloc] init];
    tempLevel = [NSArray arrayWithArray:[levelDictionary objectForKey:self.levelName]];
    
    for (int i=0; i<tempLevel.count; i++) {
        NSArray *tempPoint = [[NSArray alloc] initWithArray:[tempLevel objectAtIndex:i]];
        CGFloat p1,p2;
        
        p1 =[[tempPoint objectAtIndex:0] floatValue];
        p2 =[[tempPoint objectAtIndex:1] floatValue];
        [polygonPoints addObject:[NSValue valueWithCGPoint:CGPointMake(p1,p2)]];
    }
    
    NSArray *tempPoint = [[NSArray alloc] initWithArray:[tempLevel objectAtIndex:0]];
    [polygonPoints addObject:[NSValue valueWithCGPoint:CGPointMake([[tempPoint objectAtIndex:0] floatValue],[[tempPoint objectAtIndex:1] floatValue])]];
    
    polygonBoundry = [self makePolygon:polygonPoints flag:0];
    
    [self addChild:polygonBoundry];
    areaOfPolygonBefore = [self areaOfPolygon:polygonPoints];
    areaOfPolygonPercentage = 100;
    
    NSLog(@"Remaining Area :: %f",areaOfPolygonPercentage);
    
    if([_levelSetName isEqualToString:@"set2"]){
        [self addFixedObjects];
    }
    
    if([_levelSetName isEqualToString:@"set1"]){
        [movingOb spawnObjects:_levelSetName lName:_levelName];
    }else{
        [movingOb spawnObjectsWithType:_levelSetName lName:_levelName];
    }
    
    MovingObject *temp;
    for(temp in movingOb.myObjects){
    
        temp.physicsBody.categoryBitMask = catd;
        temp.physicsBody.contactTestBitMask = lined;
        
        [self addChild:temp];
    }
    [self fetchPlayerScore];
    
    
    timer =[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countTime:)userInfo:nil repeats:YES];
    
    speedtimer =[NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(updateSpeed:)userInfo:nil repeats:YES];

}

-(void)updateSpeed:()sender{
    if([_levelSetName isEqualToString:@"set2"]){
        MovingObject *tempNode;
        for (tempNode in movingOb.myObjects){
            [tempNode.physicsBody applyForce:CGVectorMake((arc4random() % 100),arc4random() % 100)];
            
        }
    }
}
 -(void)countTime:()sender{
    // Now call your methode you use to switch views
    //[self presentViewController:levelViewController animated:YES completion:Nil];
    
    if(self.paused == NO){
        _finalTime += 3;
    }
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    NSSet *allTouches = [event allTouches];
    if([allTouches count]==1){
        
        if(lineCut){
            [lineCut removeFromParent];
        }
        
        UITouch* touch = [touches anyObject];
        CGPoint tempPoint = [touch locationInNode:self];
        NSLog(@"%f %f",tempPoint.x,tempPoint.y);
        
        if(!CGPathContainsPoint(polygonPath, NULL,tempPoint,NULL)){
            
            self.drawLineCut=1;
            // Called when a touch begins
            UITouch* touch = [touches anyObject];
            lineCutFirstPoint = [touch locationInNode:self];
            pathToDraw = CGPathCreateMutable();
            CGPathMoveToPoint(pathToDraw, NULL, lineCutFirstPoint.x, lineCutFirstPoint.y);
            lineCut = [SKShapeNode node];
            lineCut.path = pathToDraw;
            lineCut.strokeColor = [SKColor redColor];
            [self addChild:lineCut];
        
        }else{
            self.drawLineCut = 0;
        }
    }else{
        if(lineCut)
            [lineCut removeFromParent];
        
        MovingObject *tempNode;
        tempNode = [movingOb.myObjects objectAtIndex:0];
        
        lineCutFirstPoint = [tempNode position];
        lineCutSecondPoint = [tempNode position];
        
    }
}


- (void)touchesMoved:(NSSet*)touches withEvent:(UIEvent*)event{
    
    NSSet *allTouches = [event allTouches];
    SKShapeNode *polygonActionNode;
    
    polygonActionNode = [[SKShapeNode alloc]init];
    
    if([allTouches count] == 1){
        
        if(self.drawLineCut ==1){
            UITouch* touch = [touches anyObject];
            lineCutSecondPoint = [touch locationInNode:self];
            
            pathToDraw = CGPathCreateMutable();
            
            CGPathMoveToPoint(pathToDraw, NULL, lineCutFirstPoint.x,lineCutFirstPoint.y);
            CGPathAddLineToPoint(pathToDraw, NULL, lineCutSecondPoint.x, lineCutSecondPoint.y);
            lineCut.path = pathToDraw;
            lineCut.physicsBody = [SKPhysicsBody bodyWithEdgeFromPoint:lineCutFirstPoint toPoint:lineCutSecondPoint];
            lineCut.physicsBody.categoryBitMask = lined;
            lineCut.physicsBody.contactTestBitMask = catd|fixedObjectd;
            lineCut.physicsBody.node.name = @"lineCut";
            
            
            NSString *burstPath =
            [[NSBundle mainBundle]
             pathForResource:@"MyParticle" ofType:@"sks"];
            
            SKEmitterNode *burstNode =
            [NSKeyedUnarchiver unarchiveObjectWithFile:burstPath];
            
            burstNode.position = lineCutSecondPoint;
            [burstNode setParticleLifetime:0.3];
            
            [self addChild:burstNode];
            
            
            [self checkOnlyLineIntersection];
            
            if(self.intersectionCount>=2){
                bool ch = [self checkObjectPosition];
                
                if (ch != 0) {
                    
                    [self createPolygonPointForUpperLowerBound:1];// get points1
                    [self createPolygonPointForUpperLowerBound:2];// get points2
                    
                    polygon1 = [self makePolygon:polygonLowerBoundPoints flag:1];//get cgpath
                    polygon2 = [self makePolygon:polygonUpperBoundPoints flag:2];//get cgpath
                    
                    if([_levelSetName isEqualToString:@"set1"] || [_levelSetName isEqualToString:@"set2"]){
                        MovingObject *tempNode;
                        int pf1=0,pf2=0;
                        for (tempNode in movingOb.myObjects){
                            CGPoint tempCGPoint;
                            tempCGPoint = [tempNode position];
                            
                            if(CGPathContainsPoint(polygonPath1, NULL,tempCGPoint,NULL)){
                                pf1=1;
                                [polygonPoints removeAllObjects];
                                [polygonPoints addObjectsFromArray:polygonLowerBoundPoints];
                            }else{
                                pf2=1;
                                [polygonPoints removeAllObjects];
                                [polygonPoints addObjectsFromArray:polygonUpperBoundPoints];
                            }
                            
                        }
                        
                         //remove the fixed object from scene
                        if(fixedObject != NULL){
                            if(pf1==1){
                                if(CGPathContainsPoint(polygonPath2, NULL,fixedObject.position,NULL)){
                                    [fixedObject removeFromParent];
                                }
                            }
                            if(pf2==1){
                                if(CGPathContainsPoint(polygonPath1, NULL,fixedObject.position,NULL)){
                                    [fixedObject removeFromParent];
                                }
                            }
                        }
                        
                    
                        if(pf1==1 && pf2==1){
                            
                        }else{
                            if(pf1==1){
                                [polygonPoints removeAllObjects];
                                [polygonPoints addObjectsFromArray:polygonLowerBoundPoints];
                                polygonActionNode = polygon2;
                                
                            }else{
                                [polygonPoints removeAllObjects];
                                [polygonPoints addObjectsFromArray:polygonUpperBoundPoints];
                                polygonActionNode = polygon1;
                            }
                            
                            
                            [self changePolygon:polygonPoints];
                            [self runAction:cutmusic];
                            
                            areaOfPolygonCurrent = [self areaOfPolygon:polygonPoints];
                            areaOfPolygonPercentage = 100 - (((areaOfPolygonBefore -areaOfPolygonCurrent)/areaOfPolygonBefore)*100);
                            
                            //NSLog(@"Remaining area :: %f",areaOfPolygonPercentage);
                            //NSLog(@"Are of polygon :: %f",areaOfPolygonCurrent);
                            _changeScore(areaOfPolygonPercentage);
                            
                            
                            [polygonActionNode setPhysicsBody:NO];
                            [self addChild:polygonActionNode];
                            SKAction *fadeAway = [SKAction fadeOutWithDuration:1.0];
                            
                            SKAction *removeNode = [SKAction removeFromParent];
                            
                            SKAction *group = [SKAction group:@[fadeAway]];
                            
                            SKAction *sequence = [SKAction sequence:@[group, removeNode]];
                            [polygonActionNode runAction: sequence];

                        }
                    }
                    else{
                        MovingObject *tempNode;
                        int lg=0,lb=0,ub=0,ug=0;
                        for (tempNode in movingOb.myObjects){
                            CGPoint tempCGPoint;
                            tempCGPoint = [tempNode position];
                            
                            if(CGPathContainsPoint(polygonPath1, NULL,tempCGPoint,NULL) && [tempNode.type isEqualToString:@"blue"]){
                                lb++;
                            }else if(CGPathContainsPoint(polygonPath2, NULL,tempCGPoint,NULL) && [tempNode.type isEqualToString:@"blue"]){
                                ub++;
                            }else if(CGPathContainsPoint(polygonPath1, NULL,tempCGPoint,NULL) && [tempNode.type isEqualToString:@"green"]){
                                lg++;
                            }else{
                                ug++;
                            }
                            
                        }
                        
                        if(((lb==ug)||(lg==ub)) && (lb>=1 || lg>=1)){
                            [self set3Win];
                        }
                    }
                
                    
                [polygonLowerBoundPoints removeAllObjects];
                [polygonUpperBoundPoints removeAllObjects];
                    
            
                _numberOfCuts++;
                [self set1Win];
                        
                if(lineCut)[lineCut removeFromParent];
                if(pathToDraw)CGPathRelease(pathToDraw);
                lineCutFirstPoint = lineCutSecondPoint;
                    
                pathToDraw = CGPathCreateMutable();
                CGPathMoveToPoint(pathToDraw, NULL, lineCutFirstPoint.x, lineCutFirstPoint.y);
                lineCut = [SKShapeNode node];
                lineCut.path = pathToDraw;
                lineCut.strokeColor = [SKColor redColor];
                [self addChild:lineCut];
                
                self.intersectionCount = 0;
        }
            }
        else{
            self.intersectionCount = 0;
        }
        
    }else{
        
        if(lineCut) [lineCut removeFromParent];
        
        MovingObject *tempNode;
        tempNode = [movingOb.myObjects objectAtIndex:0];
        lineCutFirstPoint = [tempNode position];
        lineCutSecondPoint = [tempNode position];
        }

    }
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    if(self.drawLineCut == 1){
        [lineCut removeFromParent];
    }
    MovingObject *tempNode;
    
    lineCutFirstPoint = [tempNode position];
    lineCutSecondPoint = [tempNode position];

    self.drawLineCut =0;
    self.intersectionCount = 0;
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    if(lineCut){
        [lineCut removeFromParent];
    }
    MovingObject *tempNode;
    
    lineCutFirstPoint = [tempNode position];
    lineCutSecondPoint = [tempNode position];

}

-(void)update:(CFTimeInterval)dt {

    
    
}



/*
 *
 * This Function detects collision between [lineCut and Object]
 * Event is handled by the system
 *
 */
- (void)didBeginContact:(SKPhysicsContact *)contact{
    
    
    SKPhysicsBody *firstBody, *secondBody;
    firstBody = contact.bodyA;
    secondBody = contact.bodyB;
    NSString * pb = [NSString stringWithFormat:@"polygonBoundry"];
    NSString * lc = [NSString stringWithFormat:@"lineCut"];
    NSString * ob = [NSString stringWithFormat:@"cat"];
    NSString * fbn = firstBody.node.name;
    NSString * sbn = secondBody.node.name;
    
    
    if(([fbn isEqualToString:pb]||[sbn isEqualToString:pb])&&([fbn isEqualToString:ob]||[sbn isEqualToString:ob]) ){
        //NSLog(@"polygonBoundry and cat collision");
    }else if(([fbn isEqualToString:ob]||[sbn isEqualToString:ob])&&([fbn isEqualToString:lc]||[sbn isEqualToString:lc])){
        NSLog(@"cat and lineCut collision");
        [self gameRestart];
    }else{
        //NSLog(@"lineCut and new ob");
        if(lineCut) [lineCut removeFromParent];
        
        MovingObject *tempNode;
        tempNode = [movingOb.myObjects objectAtIndex:0];
        lineCutFirstPoint = [tempNode position];
        lineCutSecondPoint = [tempNode position];
    }
}


/*
 *
 * checkObjectPosition Function checks whether objects on the screen are on one side of the linecut or both
 * side
 *
 * Parameter: Nothing
 * Return: 0 if points are on the both side of the linecut
 *         1 if points are on the one side of the line
 */

- (bool)checkObjectPosition{
    
    float tempArray[self.numberOfObjects];
    int flag=0;
    for(int i=0;i<self.numberOfObjects;i++){
        MovingObject *tempOb = [movingOb.myObjects objectAtIndex:i];
        CGPoint x1 = tempOb.position;
        float ch = ((lineCutSecondPoint.x - lineCutFirstPoint.x) * (x1.y - lineCutFirstPoint.y)) - ((lineCutSecondPoint.y-lineCutFirstPoint.y)*(x1.x-lineCutFirstPoint.x));
        tempArray[i] = ch;
    }
    if(tempArray[0]<0){
        flag=0;
    }else{
        flag=1;
    }
    for(int i=0;i<self.numberOfObjects;i++){
        if(tempArray[i]<0 && flag==0){
            flag=0;
        }else if(tempArray[i]>0 && flag==1){
            flag=1;
        }else{
            return false;
        }
    }
    
    return true;
}



/*
 *
 * Function makePolygon genrates polygon
 * Parameters: Array of points
 * Return: SKShapeNode
 *
 */
- (SKShapeNode*)makePolygon:(NSMutableArray*)temppolygonPointsArray flag:(int)polygonFlag{
    
    CGMutablePathRef tempPathToDraw;
    SKShapeNode *tempPolygon;
    NSValue *tempObjectPoint;
    int c=0;
    tempPathToDraw = CGPathCreateMutable();
    tempObjectPoint = [temppolygonPointsArray objectAtIndex:0];
    CGPathMoveToPoint(tempPathToDraw, NULL,tempObjectPoint.CGPointValue.x,tempObjectPoint.CGPointValue.y);
    //NSLog(@"x:%f y:%f ",tempObjectPoint.CGPointValue.x,tempObjectPoint.CGPointValue.y);
    
    for(tempObjectPoint in temppolygonPointsArray){
        CGPathAddLineToPoint(tempPathToDraw, NULL,tempObjectPoint.CGPointValue.x,tempObjectPoint.CGPointValue.y);
        c++;
        //NSLog(@"x:%f y:%f ",tempObjectPoint.CGPointValue.x,tempObjectPoint.CGPointValue.y);
    }
    
    tempPolygon = [SKShapeNode node];
    tempPolygon.strokeColor = [SKColor redColor];
    tempPolygon.path = tempPathToDraw;
    
    if(polygonFlag==0)
        polygonPath = tempPathToDraw;
    else if(polygonFlag==1)
        polygonPath1 = tempPathToDraw;
    else
        polygonPath2 = tempPathToDraw;
    
    NSLog(@"Total point For :: %d is %d",polygonFlag,c);
    tempPolygon.physicsBody.friction=0.0f;
    [tempPolygon.physicsBody setRestitution:1.0f];
    tempPolygon.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromPath:tempPathToDraw];
    tempPolygon.physicsBody.categoryBitMask = boundry;
    tempPolygon.physicsBody.contactTestBitMask = lined;
    tempPolygon.physicsBody.node.name = @"polygonBoundry";
    [tempPolygon setFillColor:[UIColor grayColor]];
    
    return tempPolygon;
}

/*
 *
 * Function areaOfPolygon calculates area of the polygon
 * Parameters: Array of points
 * Return: area(float number)
 *
 */
- (float)areaOfPolygon:(NSMutableArray*)temppolygonPointsArray{
    
    float polygonArea=0.0;
    NSValue* tempObjectPoint1;
    NSValue* tempObjectPoint2;
    
    for(int i=0;i< temppolygonPointsArray.count-1; i++){
        tempObjectPoint1 = [temppolygonPointsArray objectAtIndex:i];
        tempObjectPoint2 = [temppolygonPointsArray objectAtIndex:i+1];
        
        polygonArea += (tempObjectPoint1.CGPointValue.x * tempObjectPoint2.CGPointValue.y)
        - (tempObjectPoint1.CGPointValue.y * tempObjectPoint2.CGPointValue.x);
    }
    
    tempObjectPoint2 = [temppolygonPointsArray objectAtIndex:0];
    tempObjectPoint1 = [temppolygonPointsArray lastObject];
    
    polygonArea += (tempObjectPoint1.CGPointValue.x * tempObjectPoint2.CGPointValue.y)
    - (tempObjectPoint1.CGPointValue.y * tempObjectPoint2.CGPointValue.x);
    
    polygonArea = fabsf(polygonArea/2);
    //NSLog(@"Area of plygon: %f ",polygonArea);
    return polygonArea;
}



/*
 * Function returns sign of th efloat Number
 * Input : float Number
 * Output: [1 or -1]
 *
 */
-(int)getSign:(float) val{
    
    if(val>0)
        return 1;
    
    return -1;
}

-(void)gameRestart{
    
    self.paused = YES;
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"Ooops :(" message:@"You Lost!!!" delegate:self cancelButtonTitle:@"Restart" otherButtonTitles:@"Levels", nil, nil];
    [alertView show];
    [[Audio sharedInstance] playMusic:@"Lose.mp3"];
    [[Audio sharedInstance] pauseBackgroundMusic];
}

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    self.paused = NO;
    
    if (buttonIndex == 1) {
        /*  Level */
        self.goBackToLevel();
        [[Audio sharedInstance] playBackgroundMusic:@"bgmain.mp3"];
        
    }else if(buttonIndex == 0){
        /* Restart */
        [self removeAllChildren];
        [polygonPoints removeAllObjects];
        [movingOb.myObjects removeAllObjects];
        self.restartLevel();
        if ([_levelSetName isEqualToString:@"set1"]) {
            [[Audio sharedInstance] playBackgroundMusic:@"bgland.mp3"];
        }
        if ([_levelSetName isEqualToString:@"set2"]) {
            [[Audio sharedInstance] playBackgroundMusic:@"bgwater.mp3"];
        }
        if ([_levelSetName isEqualToString:@"set3"]) {
            [[Audio sharedInstance] playBackgroundMusic:@"bgspace.mp3"];
        }
    }else{
        
    }
}

-(void)changePolygon:(NSMutableArray*)temppolygonPointsArray{

    CGMutablePathRef tempPathToDraw;
    NSValue *tempObjectPoint;
    
    tempPathToDraw = CGPathCreateMutable();
    tempObjectPoint = [temppolygonPointsArray objectAtIndex:0];
    CGPathMoveToPoint(tempPathToDraw, NULL,tempObjectPoint.CGPointValue.x,tempObjectPoint.CGPointValue.y);
    
    for(tempObjectPoint in temppolygonPointsArray){
        CGPathAddLineToPoint(tempPathToDraw, NULL,tempObjectPoint.CGPointValue.x,tempObjectPoint.CGPointValue.y);
    }
    
    polygonBoundry.strokeColor = [SKColor redColor];
    polygonBoundry.path = tempPathToDraw;
    polygonPath = tempPathToDraw;
    polygonBoundry.physicsBody.friction=0.0f;
    polygonBoundry.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromPath:tempPathToDraw];
    polygonBoundry.physicsBody.categoryBitMask = boundry;
    polygonBoundry.physicsBody.contactTestBitMask = lined;
    polygonBoundry.physicsBody.node.name = @"polygonBoundry";
    [polygonBoundry setFillColor:[UIColor grayColor]];
    
}

-(void)checkOnlyLineIntersection{
    
    float m1,m2,c1,c2,x1,y1,x2,y2;
    float tx1,tx2,ty1,ty2;
    float ttx1,ttx2,tty1,tty2;
    NSValue *tempObjectPoint1;
    NSValue *tempObjectPoint2;
    int flag=0;
    NSMutableArray* tempObjectArray;
    tempObjectArray = [[NSMutableArray alloc]init];
    
    
    ix1=0;iy1=0;ix2=0;iy2=0;
    
    /* Handle parallel line for lineCut*/
    if((lineCutSecondPoint.x -lineCutFirstPoint.x)==0){
        m1 = infinity;
        c1 = infinity;
    }else{
        m1 = (lineCutSecondPoint.y-lineCutFirstPoint.y)/(lineCutSecondPoint.x-lineCutFirstPoint.x);
        c1 = ((lineCutSecondPoint.y*lineCutFirstPoint.x)-(lineCutFirstPoint.y*lineCutSecondPoint.x))/(lineCutFirstPoint.x-lineCutSecondPoint.x);
    }
    
    
    /* set points [left to right] */
    if(lineCutFirstPoint.x>lineCutSecondPoint.x){
        tx1 = lineCutSecondPoint.x;
        tx2 = lineCutFirstPoint.x;
    }else{
        tx1 = lineCutFirstPoint.x;
        tx2 = lineCutSecondPoint.x;
    }
    
    /* set points [top to bottom] */
    if(lineCutFirstPoint.y>lineCutSecondPoint.y){
        ty1 = lineCutSecondPoint.y;
        ty2 = lineCutFirstPoint.y;
    }else{
        ty1 = lineCutFirstPoint.y;
        ty2 = lineCutSecondPoint.y;
    }
    
    //??
    flag=0;
    
    for(int i=0;i<polygonPoints.count-1;i++){
        
        float ax,ay;
        tempObjectPoint1 = [polygonPoints objectAtIndex:i];
        
        if(i==polygonPoints.count){
            tempObjectPoint2 = [polygonPoints objectAtIndex:0];
        }else{
            tempObjectPoint2 = [polygonPoints objectAtIndex:i+1];
        }
        
        x1 = (float)tempObjectPoint1.CGPointValue.x;
        y1 = (float)tempObjectPoint1.CGPointValue.y;
        x2 = (float)tempObjectPoint2.CGPointValue.x;
        y2 = (float)tempObjectPoint2.CGPointValue.y;
        
        
        /* Handle parallel line for Polgon line*/
        if((x2-x1)==0){
            m2 = infinity;
            c2 = infinity;
        }else{
            m2 = (y2-y1)/(x2-x1);
            c2 = ((y2*x1)-(y1*x2))/(x1-x2);
        }
        
        if((m1-m2)==0){
            ax = infinity;
            ay = infinity;
        }else{
            if(m1 >= infinity){
                ax = lineCutFirstPoint.x;
                ay = ((m2*lineCutFirstPoint.x)) + c2;
            }else{
                if(m2 >= infinity){
                    ax = x1;
                    ay = ((m1*x1)) + c1;
                }else{
                    
                    ax = ((c2-c1)/(m1-m2));
                    ay = (m1*((c2-c1)/(m1-m2)))+ c1;
                    
                }
            }
        }
        
        //handle polygon line from left to right
        if(x1>x2){
            ttx1 = x2;
            ttx2 = x1;
        }else{
            ttx1 = x1;
            ttx2 = x2;
        }
        
        //handle polygon right from top to bottom
        if(y1>y2){
            tty1 = y2;
            tty2 = y1;
        }else{
            tty1 = y1;
            tty2 = y2;
        }
        
        if((ax>=tx1 && ax<=tx2) && (ax>=ttx1 && ax<=ttx2) && (ay>=ty1 && ay<=ty2) && (ay>=tty1 && ay<=tty2)){
           self.intersectionCount++;
        }
    }
}

/* Create point arrays for upper and lower polygon*/
-(void)createPolygonPointForUpperLowerBound:(int)checkPolygonFlag{
    
    float m1,m2,c1,c2,x1,y1,x2,y2;
    float tx1,tx2,ty1,ty2;
    float ttx1,ttx2,tty1,tty2;
    NSValue *tempObjectPoint1;
    NSValue *tempObjectPoint2;
    int flag=0;
    NSMutableArray* tempObjectArray;
    tempObjectArray = [[NSMutableArray alloc]init];
    int intersectionPoin1Flag=0;
    int intersectionPoin2Flag=0;
    
    ix1=0;iy1=0;ix2=0;iy2=0;
    
    /* Handle parallel line for lineCut*/
    if((lineCutSecondPoint.x -lineCutFirstPoint.x)==0){
        m1 = infinity;
        c1 = infinity;
    }else{
        m1 = (lineCutSecondPoint.y-lineCutFirstPoint.y)/(lineCutSecondPoint.x-lineCutFirstPoint.x);
        c1 = ((lineCutSecondPoint.y*lineCutFirstPoint.x)-(lineCutFirstPoint.y*lineCutSecondPoint.x))/(lineCutFirstPoint.x-lineCutSecondPoint.x);
    }
    
    
    /* set points [left to right] */
    if(lineCutFirstPoint.x>lineCutSecondPoint.x){
        tx1 = lineCutSecondPoint.x;
        tx2 = lineCutFirstPoint.x;
    }else{
        tx1 = lineCutFirstPoint.x;
        tx2 = lineCutSecondPoint.x;
    }
    
    /* set points [top to bottom] */
    if(lineCutFirstPoint.y>lineCutSecondPoint.y){
        ty1 = lineCutSecondPoint.y;
        ty2 = lineCutFirstPoint.y;
    }else{
        ty1 = lineCutFirstPoint.y;
        ty2 = lineCutSecondPoint.y;
    }
    
    //??
    flag=0;
    
    for(int i=0;i<polygonPoints.count-1;i++){
        
        float ax,ay;
        tempObjectPoint1 = [polygonPoints objectAtIndex:i];
        
        if(i==polygonPoints.count){
            tempObjectPoint2 = [polygonPoints objectAtIndex:0];
        }else{
            tempObjectPoint2 = [polygonPoints objectAtIndex:i+1];
        }
        
        x1 = (float)tempObjectPoint1.CGPointValue.x;
        y1 = (float)tempObjectPoint1.CGPointValue.y;
        x2 = (float)tempObjectPoint2.CGPointValue.x;
        y2 = (float)tempObjectPoint2.CGPointValue.y;
        
        
        /* Handle parallel line for Polgon line*/
        if((x2-x1)==0){
            m2 = infinity;
            c2 = infinity;
        }else{
            m2 = (y2-y1)/(x2-x1);
            c2 = ((y2*x1)-(y1*x2))/(x1-x2);
        }
        
        if((m1-m2)==0){
            ax = infinity;
            ay = infinity;
        }else{
            if(m1 >= infinity){
                ax = lineCutFirstPoint.x;
                ay = ((m2*lineCutFirstPoint.x)) + c2;
            }else{
                if(m2 >= infinity){
                    ax = x1;
                    ay = ((m1*x1)) + c1;
                }else{
                    
                    ax = ((c2-c1)/(m1-m2));
                    ay = (m1*((c2-c1)/(m1-m2)))+ c1;
                    
                }
            }
        }
        
        //handle polygon line from left to right
        if(x1>x2){
            ttx1 = x2;
            ttx2 = x1;
        }else{
            ttx1 = x1;
            ttx2 = x2;
        }
        
        //handle polygon right from top to bottom
        if(y1>y2){
            tty1 = y2;
            tty2 = y1;
        }else{
            tty1 = y1;
            tty2 = y2;
        }
        if(checkPolygonFlag==1){
            if((ax>=tx1 && ax<=tx2) && (ax>=ttx1 && ax<=ttx2) && (ay>=ty1 && ay<=ty2) && (ay>=tty1 && ay<=tty2)){
                
                if(intersectionPoin1Flag==1){
                    intersectionPoin2Flag=1;
                    [tempObjectArray addObject:[NSValue valueWithCGPoint:CGPointMake(ax,ay)]];
                    
                }else{
                    [tempObjectArray addObject:[polygonPoints objectAtIndex:i]];
                    [tempObjectArray addObject:[NSValue valueWithCGPoint:CGPointMake(ax,ay)]];
                    intersectionPoin1Flag=1;
                }
                
                //self.intersectionCount++;
            }else{
                /* No intersection */
                if(intersectionPoin1Flag==0){
                    [tempObjectArray addObject:[polygonPoints objectAtIndex:i]];
                }else if(intersectionPoin2Flag==1){
                    [tempObjectArray addObject:[polygonPoints objectAtIndex:i]];
                    
                }else{
                    
                }
                
                
            }

        }else{
            if((ax>=tx1 && ax<=tx2) && (ax>=ttx1 && ax<=ttx2) && (ay>=ty1 && ay<=ty2) && (ay>=tty1 && ay<=tty2)){
                
                if(intersectionPoin1Flag==1){
                    intersectionPoin2Flag=1;
                    [tempObjectArray addObject:[polygonPoints objectAtIndex:i]];
                    [tempObjectArray addObject:[NSValue valueWithCGPoint:CGPointMake(ax,ay)]];
                    
                }else{
                    [tempObjectArray addObject:[NSValue valueWithCGPoint:CGPointMake(ax,ay)]];
                    intersectionPoin1Flag=1;
                }
                
                //self.intersectionCount++;
            }else{
                /* No intersection */
                if(intersectionPoin1Flag==1 && intersectionPoin2Flag==0){
                    [tempObjectArray addObject:[polygonPoints objectAtIndex:i]];
                }
            }
        }
    }
    
    [tempObjectArray addObject:[tempObjectArray objectAtIndex:0]];
    if(checkPolygonFlag==1){
        [polygonLowerBoundPoints addObjectsFromArray:tempObjectArray];
    }else{
        [polygonUpperBoundPoints addObjectsFromArray:tempObjectArray];
    }
}

-(void)addFixedObjects{
    NSString *plistLevel = [[NSBundle mainBundle] pathForResource:@"Object-plist" ofType:@"plist"];
    NSDictionary *levelSetDictionary = [[NSDictionary alloc] initWithContentsOfFile:plistLevel];
    NSDictionary *levelDictionary = [[NSDictionary alloc] initWithDictionary:[levelSetDictionary objectForKey:_levelSetName]];
    NSDictionary *objectDataDictionary = [[NSDictionary alloc] initWithDictionary:[levelDictionary objectForKey:_levelName]];
    
    NSArray *tempLevel = [[NSArray alloc] init];
    tempLevel = [NSArray arrayWithArray:[objectDataDictionary objectForKey:@"fixedObjectPosition"]];
    CGFloat p1,p2;
    
    NSArray *tempPoint = [[NSArray alloc] initWithArray:[tempLevel objectAtIndex:0]];
    
    p1 =[[tempPoint objectAtIndex:0] floatValue];
    p2 =[[tempPoint objectAtIndex:1] floatValue];
    
    fixedObject =  [[MovingObject alloc]initWithColor:[UIColor blueColor] size:CGSizeMake(25, 25)];
    fixedObject.position = CGPointMake(p1,p2);
    fixedObject.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(25, 25)];
    fixedObject.physicsBody.categoryBitMask = fixedObjectd;
    fixedObject.physicsBody.contactTestBitMask = lined;
    fixedObject.physicsBody.node.name = @"fixedObject";
    [fixedObject.physicsBody setRestitution:1.0f];
    [fixedObject.physicsBody setFriction:0.0f];
    
    
    [self addChild:fixedObject];
    
    SKPhysicsJointFixed *jf = [SKPhysicsJointFixed jointWithBodyA:fixedObject.physicsBody bodyB:self.physicsBody anchor:fixedObject.position];
    
    [self.physicsWorld addJoint:jf];
    
    
    
}

-(void)set1Win{
    
    if(areaOfPolygonPercentage<_winningScore){
        self.paused = YES;
        
        [self computeFinalScore];
        
        if(_finalScore>=_minScore){
            [self updatePlayerScore];
        }else{
            [self fetchPlayerScore];
        }
        
        NSSortDescriptor *sd = [[NSSortDescriptor alloc] initWithKey:nil ascending:NO];
        playerScores = [NSMutableArray arrayWithArray:[playerScores sortedArrayUsingDescriptors:@[sd]]];
        
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"Woohhhhhoo You Won!!! :)" message:[NSString stringWithFormat:@"Previous HigestScores::\n%d\n%d\n%d\n Final score::%d",[[playerScores objectAtIndex:0] integerValue],[[playerScores objectAtIndex:1] integerValue],[[playerScores objectAtIndex:2] integerValue],_finalScore] delegate:self cancelButtonTitle:@"Restart" otherButtonTitles:@"Levels", nil, nil];
       
        [alertView show];
        [[Audio sharedInstance] pauseBackgroundMusic];
        [[Audio sharedInstance] playMusic:@"Win.mp3"];
        

    }
}

-(void) set3Win{
    self.paused = YES;
    
    [self computeFinalScore];
    
    if(_finalScore>=_minScore){
        [self updatePlayerScore];
    }else{
        [self fetchPlayerScore];
    }
    
    NSSortDescriptor *sd = [[NSSortDescriptor alloc] initWithKey:nil ascending:NO];
    playerScores = [NSMutableArray arrayWithArray:[playerScores sortedArrayUsingDescriptors:@[sd]]];
    
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"Woohhhhhoo You Won!!! :)" message:[NSString stringWithFormat:@"Previous HigestScores::\n%d\n%d\n%d\n Final score::%d",[[playerScores objectAtIndex:0] integerValue],[[playerScores objectAtIndex:1] integerValue],[[playerScores objectAtIndex:2] integerValue],_finalScore] delegate:self cancelButtonTitle:@"Restart" otherButtonTitles:@"Levels", nil, nil];
    
    [alertView show];
}

-(void)fetchPlayerScore{
    
    NSString *plistLevel = [[NSBundle mainBundle] pathForResource:@"Player-score" ofType:@"plist"];
    
    NSDictionary *levelSetDictionary = [[NSDictionary alloc] initWithContentsOfFile:plistLevel];
    NSDictionary *levelDictionary = [[NSDictionary alloc] initWithDictionary:[levelSetDictionary objectForKey:self.levelSetName]];
    
    NSArray *tempLevel = [[NSArray alloc] init];
    tempLevel = [NSArray arrayWithArray:[levelDictionary objectForKey:self.levelName]];
    playerScores = [NSMutableArray arrayWithArray:tempLevel];
    int max=0;
    int min=999999;
    
    for (int i=0; i<tempLevel.count; i++) {
        int val = [[tempLevel objectAtIndex:i] integerValue];
        if(val>max)
            max=val;
    }
    _maxScore = max;
    
    for (int i=0; i<tempLevel.count; i++) {
        int val = [[tempLevel objectAtIndex:i] integerValue];
        if(val<min)
            min=val;
    }
    _minScore = min;
    
}

-(void)updatePlayerScore{
    
    NSString *plistLevel = [[NSBundle mainBundle] pathForResource:@"Player-score" ofType:@"plist"];
    
    NSMutableDictionary *levelSetDictionary = [[NSMutableDictionary alloc] initWithContentsOfFile:plistLevel];
    NSMutableDictionary *levelDictionary = [[NSMutableDictionary alloc] initWithDictionary:[levelSetDictionary objectForKey:self.levelSetName]];
    [playerScores removeAllObjects];
    playerScores = [NSMutableArray arrayWithArray:[levelDictionary objectForKey:self.levelName]];
    int min=99999;
    int minIndex=0;
    for (int i=0; i<playerScores.count; i++) {
        int val = [[playerScores objectAtIndex:i] integerValue];
        if(val<min){
            min=val;
            minIndex=i;
        }
    }
    
    [playerScores replaceObjectAtIndex:minIndex withObject:[NSNumber numberWithInt:_finalScore]];
    [levelDictionary setObject:[NSMutableArray arrayWithArray:playerScores] forKey:_levelName];
    [levelSetDictionary setObject:[NSDictionary dictionaryWithDictionary:levelDictionary] forKey:_levelSetName];
    
    [levelSetDictionary writeToFile:plistLevel atomically:YES];
    
    if(_maxScore<_finalScore){
        _maxScore = _finalScore;
    }
}

-(void)computeFinalScore{

    float temp1;
    float temp2;
    
    
    if([_levelSetName isEqualToString:@"set3"]){
        temp1 = powf((1/1.1), _numberOfCuts)*100;
        temp2 = powf(1/1.1,_finalTime)*100;
        _finalScore = (int)temp1*temp2;
        
    }else{
        temp1 = powf((1/1.1), _numberOfCuts)*100;
        temp2 = powf(1/1.0009,_finalTime)*100;
        _finalScore = (int)temp1*temp2;
        
    }
}
@end
