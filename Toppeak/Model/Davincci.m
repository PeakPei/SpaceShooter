//
//  Davincci.m
//  Toppeak
//
//  Created by Kenny Lin on 2017/8/1.
//  Copyright © 2017年 Taiwan Mobile Co.,. All rights reserved.
//

#import "Davincci.h"

@implementation Davincci

static NSString* davincciImgName = @"missile1";

- (instancetype)init {
    
    self = [super initWithImageNamed:davincciImgName];
    
    if (self) {
        self.missileId = @"Davincci";
        self.missileType = MissileTypeDavincci;
        self.imgName = davincciImgName;
        self.missileSpeed = 5;
        self.missileDiscount = -1;
    }
    
    return self;
}

@end
