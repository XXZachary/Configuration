//
//  XXZEnum.h
//  Saas
//
//  Created by Jiayu_Zachary on 16/10/13.
//  Copyright © 2016年 Zachary. All rights reserved.
//

#ifndef XXZEnum_h
#define XXZEnum_h


/* ***************************************************** */
typedef NS_ENUM(NSInteger, XXZDateType) {
    XXZDateYear = 1,
    XXZDateMonth,
    XXZDateWeek,
    XXZDateDay,
    XXZDateHour,
    XXZDateMinute,
    XXZDateSecond
};

/* ***************************************************** */
typedef NS_ENUM(NSInteger, XXZNewsType) {
    XXZNewsTypeSystem,
    XXZNewsTypeLearn,
    XXZNewsTypeWallet,
    XXZNewsTypeOther
};

typedef NS_ENUM(NSInteger, XXZNoDataType) {
    XXZNoDataTypeSystemMessage, //系统消息
    XXZNoDataTypeMyAppoint, //我的预约
    XXZNoDataTypeMyOrder //我的订单
};


#endif /* XXZEnum_h */
