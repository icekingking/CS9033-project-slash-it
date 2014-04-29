//
//  MovingObject.m
//  Slash It!
//
//  Created by Savan on 4/21/14.
//  Copyright (c) 2014 Savan Rupani. All rights reserved.
//

#import "MovingObject.h"

@implementation MovingObject

-(MovingObject*)init{
    self = [super init];
    _myObjects = [[NSMutableArray alloc]init];
    _type = NULL;
    _numberOfObjects = 0;
    
    return self;
}

/*
 *
 * Function spawnObjects generates random moving obejcts
 * Parameters: Number of object
 * Return: Nothing
 *
 */

- (void)spawnObjects:(NSString*)setName lName:(NSString*)levelName{
    
    NSString *plistLevel = [[NSBundle mainBundle] pathForResource:@"Object-plist" ofType:@"plist"];
    NSDictionary *levelSetDictionary = [[NSDictionary alloc] initWithContentsOfFile:plistLevel];
    NSDictionary *levelDictionary = [[NSDictionary alloc] initWithDictionary:[levelSetDictionary objectForKey:setName]];
    NSDictionary *objectDataDictionary = [[NSDictionary alloc] initWithDictionary:[levelDictionary objectForKey:levelName]];
    
    NSArray *tempLevel = [[NSArray alloc] init];
    tempLevel = [NSArray arrayWithArray:[objectDataDictionary objectForKey:@"objectPosition"]];
    
    _objectSpeed = [objectDataDictionary objectForKey:@"objectSpeed"];
    _numberOfObjects = tempLevel.count;
    
    for(int i=0;i<tempLevel.count;i++){
        NSArray *tempPoint = [[NSArray alloc] initWithArray:[tempLevel objectAtIndex:i]];
        MovingObject *ob = [[MovingObject alloc]init];
        int r = arc4random() % 4;
        CGFloat p1,p2;
        
        p1 =[[tempPoint objectAtIndex:0] floatValue];
        p2 =[[tempPoint objectAtIndex:1] floatValue];
        
        if(r==0){
            //Rectangle
            ob =[MovingObject spriteNodeWithColor:[UIColor redColor] size:CGSizeMake(20, 20)];
            CGSize obSize = CGSizeMake(ob.size.height,ob.size.width);
            ob.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:obSize];
            
        }else if(r==1){
            //Circle
            if([setName isEqualToString:@"set1"] && [levelName isEqualToString:@"level3"]){
                ob =[MovingObject spriteNodeWithColor:[UIColor greenColor] size:CGSizeMake(20, 20)];
                CGSize obSize = CGSizeMake(ob.size.height,ob.size.width);
                ob.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:obSize];
                ob.physicsBody.mass = 0.35;
                
            }else{
                ob =[MovingObject spriteNodeWithImageNamed:@"Circle"];
                ob.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:16.0];
                
            }
            
        }else if(r==2){
            //Cat
            if([setName isEqualToString:@"set1"] && [levelName isEqualToString:@"level3"]){
                ob =[MovingObject spriteNodeWithColor:[UIColor blueColor] size:CGSizeMake(20, 20)];
                CGSize obSize = CGSizeMake(ob.size.height,ob.size.width);
                ob.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:obSize];
                ob.physicsBody.mass = 0.35;
                
            }else{
                ob =[MovingObject spriteNodeWithImageNamed:@"Cat"];
                CGSize obSize = CGSizeMake(ob.size.height,ob.size.width);
                
                ob.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:obSize];
                
            }
            
        }else if(r==3){
            //line
            
            ob =[MovingObject spriteNodeWithColor:[UIColor yellowColor] size:CGSizeMake(10, 32)];
            CGSize obSize = CGSizeMake(ob.size.height,ob.size.width);
            ob.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:obSize];
            ob.physicsBody.mass = 0.3;
            
            
        }else{
            ob =[MovingObject spriteNodeWithImageNamed:@"Cat"];
            CGSize obSize = CGSizeMake(ob.size.height,ob.size.width);
            ob.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:obSize];
        }
        NSLog(@"mass :: %f",ob.physicsBody.mass);
        
        
        
        
        ob.name = [NSString stringWithFormat:@"cat"];
        ob.physicsBody.node.name = [NSString stringWithFormat:@"cat"];
        
        ob.position = CGPointMake(p1,p2);
        
        ob.physicsBody.friction =0.0f;
        ob.physicsBody.linearDamping = 0.0f;
        ob.physicsBody.angularDamping = 0.0f;
        ob.physicsBody.allowsRotation= YES;
        
        [ob.physicsBody setRestitution:1.0f];
        CGFloat velocity1 = (arc4random() % [_objectSpeed integerValue]);
        CGFloat velocity2 = (arc4random() % [_objectSpeed integerValue]);
        [ob.physicsBody setVelocity:CGVectorMake(velocity1 ,velocity2)];
        [ob.physicsBody applyImpulse:CGVectorMake((arc4random() % 350),arc4random() % 350)];
        [_myObjects addObject:ob];
    }
}


- (void)spawnObjectsWithType:(NSString*)setName lName:(NSString*)levelName{
    
    NSString *plistLevel = [[NSBundle mainBundle] pathForResource:@"Object-plist" ofType:@"plist"];
    NSDictionary *levelSetDictionary = [[NSDictionary alloc] initWithContentsOfFile:plistLevel];
    NSDictionary *levelDictionary = [[NSDictionary alloc] initWithDictionary:[levelSetDictionary objectForKey:setName]];
    NSDictionary *objectDataDictionary = [[NSDictionary alloc] initWithDictionary:[levelDictionary objectForKey:levelName]];
    
    NSArray *tempLevel = [[NSArray alloc] init];
    tempLevel = [NSArray arrayWithArray:[objectDataDictionary objectForKey:@"objectPosition"]];
    
    _objectSpeed = [objectDataDictionary objectForKey:@"objectSpeed"];
    _numberOfObjects = tempLevel.count;
    
    for(int i=0;i<tempLevel.count;i++){
        NSArray *tempPoint = [[NSArray alloc] initWithArray:[tempLevel objectAtIndex:i]];
        MovingObject *ob = [[MovingObject alloc]init];
        CGFloat p1,p2;
        p1 =[[tempPoint objectAtIndex:0] floatValue];
        p2 =[[tempPoint objectAtIndex:1] floatValue];
        
        if(i%2==0){
            ob =[MovingObject spriteNodeWithColor:[UIColor blueColor] size:CGSizeMake(25,25)];
            ob.type=@"blue";
            
        }else{
            ob =[MovingObject spriteNodeWithColor:[UIColor greenColor] size:CGSizeMake(25,25)];
            ob.type=@"green";
        }
        
        CGSize obSize = CGSizeMake(ob.size.height,ob.size.width);
        ob.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:obSize];
        ob.name = [NSString stringWithFormat:@"cat"];
        ob.physicsBody.node.name = [NSString stringWithFormat:@"cat"];
        
        
        ob.position = CGPointMake(p1,p2);
        
        ob.physicsBody.friction =0.0f;
        ob.physicsBody.linearDamping = 0.0f;
        ob.physicsBody.angularDamping = 0.0f;
        ob.physicsBody.allowsRotation= YES;
        
        [ob.physicsBody setRestitution:1.0f];
        CGFloat velocity1 = (arc4random() % [_objectSpeed integerValue]);
        CGFloat velocity2 = (arc4random() % [_objectSpeed integerValue]);
        [ob.physicsBody setVelocity:CGVectorMake(velocity1 ,velocity2)];
        [ob.physicsBody applyImpulse:CGVectorMake((arc4random() % 350),arc4random() % 350)];
        [_myObjects addObject:ob];
        //[self addChild:ob];
        
        
    }
}



@end
