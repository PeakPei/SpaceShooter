//
//  Definitions.h
//  Toppeak
//
//  Created by Kenny Lin on 2017/8/1.
//  Copyright © 2017年 Taiwan Mobile Co.,. All rights reserved.
//

#ifndef Definitions_h
#define Definitions_h


typedef NS_ENUM (NSInteger, MissileType)
{
    MissileTypeUnkown = 0,
    MissileTypeDavincci,
    MissileTypeBacon,
    MissileTypeNewTon,
    MissileTypeTotal
};



// zPosition
static const int zLevel0 = 0;
static const int zLevel1 = 1;
static const int zLevel2 = 2;
static const int zLevel3 = 3;

// missile type
static NSString* missile_type_1 = @"mt1";
static NSString* missile_type_2 = @"mt2";
static NSString* missile_type_3 = @"mt3";

// sprite name
static NSString* planeid = @"plane";
static NSString* fireid = @"fire";

#endif /* Definitions_h */
