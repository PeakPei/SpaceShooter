//
//  BaseMissile.m
//  Toppeak
//
//  Created by Kenny Lin on 2017/8/1.
//  Copyright © 2017年 Taiwan Mobile Co.,. All rights reserved.
//

#import "BaseMissile.h"

@implementation BaseMissile

- (instancetype)init {
    
    self = [super init];
    
    if (self) {
        self.missileId = @"";
        self.missileType = MissileTypeUnkown;
        self.imgName = @"";
        self.missileSpeed = 0;
        self.missileDiscount = 0;
    }
    return self;
}

- (void)fire:(SKScene*)scene sprite:(SKSpriteNode*)fireSprite zPosition:(int)level {
    
    if ( scene ) {
        
        self.zPosition = level;
        self.position = fireSprite.position;
        [scene addChild:self];

        CGPoint location = CGPointMake(fireSprite.position.x, scene.frame.size.height);
        
        SKAction *laserMoveAction = [SKAction moveTo:location duration:self.missileSpeed];
        SKAction *laserDoneAction = [SKAction runBlock:(dispatch_block_t)^() {
            self.hidden = YES;
            [self removeFromParent];
        }];
        
        SKAction *moveLaserActionWithDone = [SKAction sequence:@[laserMoveAction,laserDoneAction]];
        
        [self runAction:moveLaserActionWithDone withKey:@"laserFired"];
    }
    
}
@end
