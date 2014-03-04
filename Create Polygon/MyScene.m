//
//  MyScene.m
//  CreatePolygon
//
//  Created by iceking on 3/2/14.
//  Copyright (c) 2014 iceking. All rights reserved.
//

#import "MyScene.h"
@interface MyScene() //6
@property SKSpriteNode *mypolygon;
@property SKShapeNode * mycircle;
@property SKShapeNode * line;
@property SKShapeNode * edge;
@property SKShapeNode * edge1;
@property int count;
@property float area;
@property float temp;
@property float point1x;
@property float point1y;
@property float point2x;
@property float point2y;
@property float A;
@property float E;
@property float D;
@property float F;
@property float delta;
@property float deltax;
@property float deltay;




@end

CGPoint Array[6];

@implementation MyScene

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        
        
        /*
         SKShapeNode *ball = [[SKShapeNode alloc] init];
         
         CGMutablePathRef myPath = CGPathCreateMutable();
         CGPathAddArc(myPath, NULL, 0,0, 15, 0, M_PI*2, YES);
         ball.path = myPath;
         ball.position = CGPointMake(size.width/2, size.height/2);
         ball.lineWidth = 1.0;
         ball.fillColor = [SKColor blueColor];
         ball.strokeColor = [SKColor whiteColor];
         ball.glowWidth = 0.5;
         [self addChild:ball];
         */
        
        
        /*
         SKShapeNode *yourline = [SKShapeNode node];
         CGMutablePathRef pathToDraw = CGPathCreateMutable();
         CGPathMoveToPoint(pathToDraw, NULL, 100.0, 100.0);
         CGPathAddLineToPoint(pathToDraw, NULL, 0, 0);
         yourline.path = pathToDraw;
         [yourline setStrokeColor:[UIColor redColor]];
         [self addChild:yourline];
         
         */
        
        
        /*
         SKSpriteNode *testpic = [SKSpriteNode spriteNodeWithImageNamed:@"test.png"];
         testpic.position = CGPointMake(200,200);
         NSLog(@"size:%@",NSStringFromCGRect(testpic.frame));
         
         [self addChild: testpic];*/
        
        //SKShapeNode * edge = [SKShapeNode node];
        _edge = [SKShapeNode node];
        UIBezierPath * path = [[UIBezierPath alloc] init];
        [path moveToPoint:CGPointMake(50.0, 100.0)];
        [path addLineToPoint:CGPointMake(100.0, 200.0)];
        [path addLineToPoint:CGPointMake(150.0, 200.0)];
        [path addLineToPoint:CGPointMake(200.0, 100.0)];
        [path addLineToPoint:CGPointMake(50.0, 100.0)];
        _edge.path = path.CGPath;
        _edge.lineWidth = 5.0;
        _edge.strokeColor = [UIColor yellowColor];
        _edge.antialiased = YES;
        [self addChild:_edge];
        
        
        
        
        Array[0] = CGPointMake(50.0, 100.0);
        Array[1] = CGPointMake(100.0, 200.0);
        Array[2] = CGPointMake(150.0, 200.0);
        Array[3] = CGPointMake(200.0, 100.0);
        _count = 4;
        
        /*
         double x = Array[1].y;
         NSLog(@"%.0f", x);
         NSLog(@"count: %d",_count);
         */
        
        
        _temp = ((Array[0].x)*(Array[1].y)-(Array[1].x)*(Array[0].y))+((Array[1].x)*(Array[2].y)-(Array[2].x)*(Array[1].y))+((Array[2].x)*(Array[3].y)-(Array[3].x)*(Array[2].y))+((Array[3].x)*(Array[0].y)-(Array[0].x)*(Array[3].y));
        if(_temp < 0){
            _temp = 0 - _temp;
        }
        _area = fabs(_temp)/2;
        NSLog(@"Area: %f", _area);
        
        //[edge removeFromParent];
        
        
        
        
        
        
        
        /*
         
         SKShapeNode* topLeft = [SKShapeNode node];
         UIBezierPath* topLeftBezierPath = [[UIBezierPath alloc] init];
         [topLeftBezierPath moveToPoint:CGPointMake(0.0, 0.0)];
         [topLeftBezierPath addLineToPoint:CGPointMake(0.0, 100.0)];
         [topLeftBezierPath addLineToPoint:CGPointMake(100.0, 100.0)];
         topLeft.path = topLeftBezierPath.CGPath;
         topLeft.lineWidth = 10.0;
         topLeft.strokeColor = [UIColor redColor];
         topLeft.antialiased = NO;
         [self addChild:topLeft];
         
         SKShapeNode* bottomRight = [SKShapeNode node];
         UIBezierPath* bottomRightBezierPath = [[UIBezierPath alloc] init];
         [bottomRightBezierPath moveToPoint:CGPointMake(0.0, 0.0)];
         [bottomRightBezierPath addLineToPoint:CGPointMake(100.0, 0.0)];
         [bottomRightBezierPath addLineToPoint:CGPointMake(100.0, 100.0)];
         bottomRight.path = bottomRightBezierPath.CGPath;
         bottomRight.lineWidth = 10.0;
         bottomRight.strokeColor = [UIColor greenColor];
         bottomRight.antialiased = NO;
         [self addChild:bottomRight];
         */
        
        
        
        
        
    }
    return self;
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        
        _point1x = location.x;
        _point1y = location.y;
        
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        
        
        _line = [SKShapeNode node];
        CGMutablePathRef pathToDraw = CGPathCreateMutable();
        CGPathMoveToPoint(pathToDraw, NULL, _point1x, _point1y);
        CGPathAddLineToPoint(pathToDraw, NULL, location.x, location.y);
        _line.path = pathToDraw;
        _line.lineWidth = 0.1;
        [_line setStrokeColor:[UIColor redColor]];
        [self addChild:_line];
        
        
        
        
        
    }
}


-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        
        [_line removeFromParent];
        [_edge removeFromParent];
        _point2x = location.x;
        _point2y = location.y;
        
        Array[4] = CGPointMake(_point1x, _point1y);
        Array[5] = CGPointMake(_point2x, _point2y);
        _A = (Array[0].y-Array[3].y)/(Array[0].x-Array[3].x);
        _E = Array[0].x*(Array[0].y-Array[3].y)/(Array[0].x-Array[3].x);
        _E = _E -Array[0].y;
        _D = (Array[4].y-Array[5].y)/(Array[4].x-Array[5].x);
        _F = Array[4].x*(Array[4].y-Array[5].y)/(Array[4].x-Array[5].x);
        _F = _F - Array[4].y;
        _delta = fabsf(_D - _A);
        _deltax = fabsf(_F - _E);
        _deltay = fabsf((_A*_F) - (_E*_D));
        
        Array[4].x = _deltax/_delta;
        Array[4].y = _deltay/_delta;
        
        _A = (Array[2].y-Array[3].y)/(Array[2].x-Array[3].x);
        _E = Array[2].x*(Array[2].y-Array[3].y)/(Array[2].x-Array[3].x);
        _E = _E -Array[2].y;
        _delta = fabsf(_D - _A);
        _deltax = fabsf(_F - _E);
        _deltay = fabsf((_A*_F) - (_E*_D));
        
        Array[5].x = _deltax/_delta;
        Array[5].y = _deltay/_delta;
        
        /*
         NSLog(@"Area: %f", Array[4].x);
         NSLog(@"Area: %f", Array[4].x);
         NSLog(@"Area: %f", Array[5].x);
         NSLog(@"Area: %f", Array[5].x);
         */
        
        _edge1 = [SKShapeNode node];
        UIBezierPath * path1 = [[UIBezierPath alloc] init];
        [path1 moveToPoint:CGPointMake(50.0, 100.0)];
        [path1 addLineToPoint:CGPointMake(100.0, 200.0)];
        [path1 addLineToPoint:CGPointMake(150.0, 200.0)];
        [path1 addLineToPoint:CGPointMake(Array[5].x, Array[5].y)];
        [path1 addLineToPoint:CGPointMake(Array[4].x, Array[4].y)];
        [path1 addLineToPoint:CGPointMake(50.0, 100.0)];
        _edge1.path = path1.CGPath;
        _edge1.lineWidth = 5.0;
        _edge1.strokeColor = [UIColor yellowColor];
        _edge1.antialiased = YES;
        [self addChild:_edge1];
        _edge = _edge1;
        _edge1 = NULL;
        
        
        
        
        
    }
}


-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
