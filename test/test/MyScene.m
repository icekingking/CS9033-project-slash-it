//
//  MyScene.m
//  test
//
//  Created by iceking on 3/6/14.
//  Copyright (c) 2014 iceking. All rights reserved.
//

#import "MyScene.h"

@implementation MyScene

NSMutableArray * MovePointsArray;



-(SKShapeNode *)createpolygon:(NSMutableArray *)inputarray{
    SKShapeNode * mypolygon = [SKShapeNode node];
    NSValue * point;
    UIBezierPath * path = [[UIBezierPath alloc] init];
    
    point = [inputarray objectAtIndex:0];
    [path moveToPoint:CGPointMake(point.CGPointValue.x, point.CGPointValue.y)];
    
    for (int i =1; i < [inputarray count]; i++) {
        point = [inputarray objectAtIndex:i];
        [path addLineToPoint:CGPointMake(point.CGPointValue.x, point.CGPointValue.y)];
    }
    
    
    mypolygon.path = path.CGPath;
    mypolygon.lineWidth = 5.0;
    mypolygon.strokeColor = [UIColor yellowColor];
    mypolygon.antialiased = YES;
    mypolygon.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromPath:path.CGPath];
    
    return mypolygon;
    
}




/*
-(float)calculatearea:(NSMutableArray *)inputarray{
    float area;
    NSValue* point1;
    NSValue* point2;
    
    for(int i=0; i<[inputarray count]-1; i+=1){
        point1 = [inputarray objectAtIndex:i];
        point2 = [inputarray objectAtIndex:i+1];
        area = area + (point1.CGPointValue.x * point2.CGPointValue.y) - (point1.CGPointValue.y * point2.CGPointValue.x);
    }
    
    point1 = [inputarray objectAtIndex:0];
    point2 = [inputarray objectAtIndex:[inputarray count]-1];
    area = area + (point2.CGPointValue.x * point1.CGPointValue.y)-(point1.CGPointValue.x * point2.CGPointValue.y);
    
    area = fabsf(area/2);  //int abs,   double fabs
    return area;
}
*/

/*
#define M_PI     3.14159265358979323846264338327950288


- (SKShapeNode*)makePolygon:(NSMutableArray*)tempObjectPointsArray{
    
    CGMutablePathRef tempPathToDraw;
    SKShapeNode *tempPolygon;
    NSValue *tempObjectPoint;
    
    tempPathToDraw = CGPathCreateMutable();
    tempObjectPoint = [tempObjectPointsArray objectAtIndex:0];
    CGPathMoveToPoint(tempPathToDraw, NULL,tempObjectPoint.CGPointValue.x,tempObjectPoint.CGPointValue.y);
    NSLog(@"x:%f y:%f ",tempObjectPoint.CGPointValue.x,tempObjectPoint.CGPointValue.y);
    
    for(tempObjectPoint in tempObjectPointsArray){
        CGPathAddLineToPoint(tempPathToDraw, NULL,tempObjectPoint.CGPointValue.x,tempObjectPoint.CGPointValue.y);
        NSLog(@"x:%f y:%f ",tempObjectPoint.CGPointValue.x,tempObjectPoint.CGPointValue.y);
    }
    
    
    CGAffineTransform transform = CGAffineTransformMakeRotation(M_PI*0.38);
    CGPathRef rotatedPath = CGPathCreateCopyByTransformingPath(tempPathToDraw, &transform);
    tempPolygon = [SKShapeNode node];
    tempPolygon.name =@"polygon";
    tempPolygon.strokeColor = [SKColor redColor];
    tempPolygon.path = rotatedPath;
    tempPolygon.physicsBody.friction=0.0f;
    tempPolygon.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromPath:tempPathToDraw];
    //tempPolygon.physicsBody.categoryBitMask = boundry;
    //tempPolygon.physicsBody.contactTestBitMask = catd|lined;
    //tempPolygon.physicsBody.collisionBitMask = catd|lined;
    
    return tempPolygon;
}*/


- (float)areaOfPolygon:(NSMutableArray*)tempObjectPointsArray{
    
    float polygonArea=0.0;
    NSValue* tempObjectPoint1;
    NSValue* tempObjectPoint2;
    
    for(int i=0;i< tempObjectPointsArray.count-1; i++){
        tempObjectPoint1 = [tempObjectPointsArray objectAtIndex:i];
        tempObjectPoint2 = [tempObjectPointsArray objectAtIndex:i+1];
        
        polygonArea += (tempObjectPoint1.CGPointValue.x * tempObjectPoint2.CGPointValue.y)
        - (tempObjectPoint1.CGPointValue.y * tempObjectPoint2.CGPointValue.x);
    }
    
    tempObjectPoint2 = [tempObjectPointsArray objectAtIndex:0];
    tempObjectPoint1 = [tempObjectPointsArray lastObject];
    polygonArea += (tempObjectPoint1.CGPointValue.x * tempObjectPoint2.CGPointValue.y)
    - (tempObjectPoint1.CGPointValue.y * tempObjectPoint2.CGPointValue.x);
    
    polygonArea = fabsf(polygonArea/2);
    //NSLog(@"Area of plygon: %f ",polygonArea);
    return polygonArea;
}



-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        
       
        
        
        
       
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    /*
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        
        SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:@"Spaceship"];
        
        sprite.position = location;
        
        SKAction *action = [SKAction rotateByAngle:M_PI duration:1];
        
        [sprite runAction:[SKAction repeatActionForever:action]];
        
        [self addChild:sprite];
    }
     */
}


-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
    /*
    UITouch *move = [[event allTouches] anyObject];
    CGPoint MovePoint = [move locationInView:self.view];
    if (MovePointsArray==NULL) {
        MovePointsArray=[[NSMutableArray alloc]init];
    }
    [MovePointsArray addObject:[NSValue valueWithCGPoint:MovePoint]];
    */
     
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    for(UITouch *touch in touches){
        
        SKShapeNode * sh = [SKShapeNode node];
        //float polygonarea;
        //sh = [self makePolygon:MovePointsArray];
        
        sh = [self createpolygon:MovePointsArray];
        [self addChild:sh];
        
        //polygonarea = [self areaOfPolygon:MovePointsArray];
        //NSLog(@"Polygon area = %f ",polygonarea);
        
        
        
        
    
        
        
        /*
        sh = [self createpolygon:MovePointsArray];
        [self addChild:sh];
         polygonarea = [self calculatearea:MovePointsArray];
         NSLog(@"AREA = %f ",polygonarea);
        */

         
        
        
        
    }
    
    
}


-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
