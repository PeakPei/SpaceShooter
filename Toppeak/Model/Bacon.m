//
//  Bacon.m
//  Toppeak
//
//  Created by Kenny Lin on 2017/8/1.
//  Copyright © 2017年 Taiwan Mobile Co.,. All rights reserved.
//

#import "Bacon.h"

@implementation Bacon

static NSString* baconImgName = @"missile2";

- (instancetype)init {
    
    self = [super initWithImageNamed:baconImgName];
    
    if (self) {
        self.missileId = @"Bacon";
        self.missileType = MissileTypeBacon;
        self.imgName = baconImgName;
        self.missileSpeed = 10;
        self.missileDiscount = -2;
    }
    
    return self;
}

@end
