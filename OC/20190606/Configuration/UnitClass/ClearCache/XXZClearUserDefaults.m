//
//  XXZClearUserDefaults.m
//  Saas
//
//  Created by Jiayu_Zachary on 16/9/22.
//  Copyright © 2016年 Zachary. All rights reserved.
//

#import "XXZClearUserDefaults.h"

@implementation XXZClearUserDefaults

+ (void)clearCommonUserDefaults {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"session_id"];
    
    
}

+ (void)clearSpecificUserDefaults {
    
}

+ (void)clearAllUserDefaults {
    //方法一
    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
    
#if 0
    //方法二
        NSUserDefaults * defs = [NSUserDefaults standardUserDefaults];
        NSDictionary * dict = [defs dictionaryRepresentation];
        for (id key in dict) {
            [defs removeObjectForKey:key];
        }
        [defs synchronize];
#endif
    
#if 0
    // 方法三
    [[NSUserDefaults standardUserDefaults] setPersistentDomain:[NSDictionary dictionary] forName:[[NSBundle mainBundle] bundleIdentifier]];
#endif
}

@end
