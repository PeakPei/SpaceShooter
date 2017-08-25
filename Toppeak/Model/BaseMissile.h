//
//  BaseMissile.h
//  Toppeak
//
//  Created by Kenny Lin on 2017/8/1.
//  Copyright © 2017年 Taiwan Mobile Co.,. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Definitions.h"

@interface BaseMissile : SKSpriteNode

@property (nonatomic, retain) NSString* missileId;
@property (nonatomic, retain) NSString* imgName;
@property (nonatomic, assign) MissileType missileType;
@property (nonatomic, assign) int missileSpeed;
@property (nonatomic, assign) int missileDiscount;

- (void)fire:(SKScene*)scene sprite:(SKSpriteNode*)fireSprite zPosition:(int)level;
@end
