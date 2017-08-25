//
//  GameScene.m
//  Toppeak
//
//  Created by Kenny Lin on 2017/7/31.
//  Copyright © 2017年 Taiwan Mobile Co.,. All rights reserved.
//

#import "GameScene.h"
#import "BaseMissile.h"
#import "Davincci.h"
#import "Bacon.h"
#import "NewTon.h"

@implementation GameScene {
    SKLabelNode *_bulletCount;
    SKLabelNode *_countNum;
    
    SKSpriteNode *_missileType1;
    SKSpriteNode *_missileType2;
    SKSpriteNode *_missileType3;
    
    SKSpriteNode *_ship;
    SKSpriteNode *_fireBtn;
    
    BaseMissile* selectedMissile;
    SKSpriteNode *_currentMissileImg;
    
    NSMutableDictionary *missileCatalog;
}

- (void)setupMissileType {
    
    SKNode* type1Pos = [self childNodeWithName:@"//type1Missile"];
    SKNode* type2Pos = [self childNodeWithName:@"//type2Missile"];
    SKNode* type3Pos = [self childNodeWithName:@"//type3Missile"];
    
    // setup missle1 Option
    _missileType1 = [SKSpriteNode spriteNodeWithImageNamed:@"missile-type-1"];
    _missileType1.zPosition = zLevel1;
    _missileType1.position = type1Pos.position;
    _missileType1.name = missile_type_1;
    [self addChild:_missileType1];
    
    _missileType2 = [SKSpriteNode spriteNodeWithImageNamed:@"missile-type-2"];
    _missileType2.zPosition = zLevel1;
    _missileType2.position = type2Pos.position;
    _missileType2.name = missile_type_2;
    [self addChild:_missileType2];
    
    _missileType3 = [SKSpriteNode spriteNodeWithImageNamed:@"missile-type-3"];
    _missileType3.zPosition = zLevel1;
    _missileType3.position = type3Pos.position;
    _missileType3.name = missile_type_3;
    [self addChild:_missileType3];
}

- (void)setupFireBtn {
    // setup fire Button
    _fireBtn = [SKSpriteNode spriteNodeWithImageNamed:@"fire"];
    _fireBtn.zPosition = zLevel2;
    _fireBtn.name = fireid;
    CGFloat posY = 0 - (self.frame.size.height/2) + _fireBtn.frame.size.height - 30;
    _fireBtn.position = CGPointMake(0, posY);
    [self addChild:_fireBtn];
}


- (void)setupMissileCatalog {
    
    missileCatalog = [[NSMutableDictionary alloc] init];
    
    for (int missileType = MissileTypeDavincci; missileType < MissileTypeTotal ;missileType++) {
        
        // has already filter unknown
        BaseMissile* missile;
        NSString* missileId = @"";
        
        switch ( missileType ) {
            case MissileTypeDavincci:
                missile = [[Davincci alloc] init];
                missileId = missile_type_1;
                break;
            case MissileTypeBacon:
                missile = [[Bacon alloc] init];
                missileId = missile_type_2;
                break;
            case MissileTypeNewTon:
                missile = [[NewTon alloc] init];
                missileId = missile_type_3;
                break;
                
            default:
                continue;
                break;
        }
        [missileCatalog setObject:missile forKey:missileId];
    }
    
}

- (void)setupAirPlane {
    
    // setup AirPlane
    //Create space sprite, setup position on left edge centered on the screen, and add to Scene
    _ship = [SKSpriteNode spriteNodeWithImageNamed:@"plane"];
    _ship.zPosition = zLevel3;
    _ship.name = planeid;
    CGFloat posY = 0 - (self.frame.size.height/2) + _fireBtn.frame.size.height - 30 + CGRectGetHeight(_fireBtn.frame) + 30;
    _ship.position = CGPointMake(0, posY);
    //move the ship using Sprite Kit's Physics Engine
    //Create a rectangular physics body the same size as the ship.
    _ship.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:_ship.frame.size];
    //Make the shape dynamic; this makes it subject to things such as collisions and other outside forces.
    _ship.physicsBody.dynamic = YES;
    //You don't want the ship to drop off the bottom of the screen, so you indicate that it's not affected by gravity.
    _ship.physicsBody.affectedByGravity = NO;
    //Give the ship an arbitrary mass so that its movement feels natural.
    _ship.physicsBody.mass = 0.02;
    [self addChild:_ship];
}

- (void)didMoveToView:(SKView *)view {
    // Setup your scene here
    
    // setup backgroud
    SKSpriteNode* bg = [SKSpriteNode spriteNodeWithImageNamed:@"background"];
    bg.zPosition = zLevel0;
    [bg scaleToSize:self.view.frame.size];
    [self addChild:bg];
    
    [self setupMissileType];
    [self setupFireBtn];
    [self setupMissileCatalog];
    [self setupAirPlane];
    
    // setup default missile
    selectedMissile = [missileCatalog objectForKey:missile_type_1];
    // setup current missile image, default missile image
    [self updateSelectedMissileImg:selectedMissile];
    
    _countNum = (SKLabelNode*)[self childNodeWithName:@"//countNum"];
}

- (void)updateBCount {
    int currentBCount = [_countNum.text intValue];
    currentBCount = currentBCount + selectedMissile.missileDiscount;
    _countNum.text = [NSString stringWithFormat:@"%d", currentBCount];
}

- (void)updateSelectedMissileImg:(BaseMissile*)selectedMissle {
    
    if (!_currentMissileImg) {
        SKNode* currMissilePos = [self childNodeWithName:@"//currMissile"];
        _currentMissileImg = [SKSpriteNode spriteNodeWithImageNamed:selectedMissile.imgName];
        _currentMissileImg.position = currMissilePos.position;
        [self addChild:_currentMissileImg];
    }
    _currentMissileImg.texture = [SKTexture textureWithImageNamed:selectedMissle.imgName];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

    BOOL bUpdateMissile = NO;
    BaseMissile* originSelectedMissile = selectedMissile;
    
    for (UITouch *t in touches)
    {
        CGPoint point = [t locationInNode:self];
        SKNode* touchNode = [self nodeAtPoint:point];
        NSString* touchNN = touchNode.name;
        
        if ([touchNN isEqualToString:fireid]) {
            
            if ( [_countNum.text intValue] > 0 ) {
                BaseMissile* launchMissile = [selectedMissile copy];
                [launchMissile fire:self sprite:_ship zPosition:zLevel2];
                
                [self updateBCount];
            }
        } else if ([touchNN isEqualToString:missile_type_1]) {
            bUpdateMissile = YES;
            selectedMissile = [missileCatalog objectForKey:missile_type_1];
        } else if ([touchNN isEqualToString:missile_type_2]) {
            bUpdateMissile = YES;
            selectedMissile = [missileCatalog objectForKey:missile_type_2];
        } else if ([touchNN isEqualToString:missile_type_3]) {
            bUpdateMissile = YES;
            selectedMissile = [missileCatalog objectForKey:missile_type_3];
        }
    }
    
    if (bUpdateMissile) {
        bUpdateMissile = NO;
        if (selectedMissile) {
            [self updateSelectedMissileImg:selectedMissile];
        } else {
            selectedMissile = originSelectedMissile;
        }
    }
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    for (UITouch *t in touches)
    {
        CGPoint point = [t locationInNode:self];
        SKNode* touchNode = [self nodeAtPoint:point];
        
        
        if ([touchNode.name isEqualToString:planeid]) {
            CGPoint nodePoint = touchNode.position;

            CGPoint previousPoint = [t previousLocationInNode:self];
            float diffY = point.y - previousPoint.y;
            float diffX = point.x - previousPoint.x;
            CGPoint newPosition = CGPointMake(nodePoint.x + diffX, nodePoint.y + diffY);
            
            touchNode.position = newPosition;
        }
    }
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    
}


-(void)update:(CFTimeInterval)currentTime {
    // Called before each frame is rendered
    
}

@end
