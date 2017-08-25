//
//  NewTon.m
//  Toppeak
//
//  Created by Kenny Lin on 2017/8/1.
//  Copyright © 2017年 Taiwan Mobile Co.,. All rights reserved.
//

#import "NewTon.h"

@implementation NewTon

static NSString* newtonImgName = @"missile3";

- (instancetype)init {
    
    self = [super initWithImageNamed:newtonImgName];
    
    if (self) {
        self.missileId = @"NewTon";
        self.missileType = MissileTypeNewTon;
        self.imgName = newtonImgName;
        self.missileSpeed = 15;
        self.missileDiscount = -3;
        self = [super initWithImageNamed:self.imgName];
    }
    
    return self;
}

@end
