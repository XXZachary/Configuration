//
//  NSDictionary+stringForKey.h
//

#import <Foundation/Foundation.h>

@interface NSDictionary (stringForKey)

- (NSString *)stringForKey:(id)aKey;
- (NSString *)stringForKeyNotNull:(id)aKey;

- (int) intForKey:(id)aKey;
- (double) doubleForKey:(id)aKey;
- (BOOL) boolForKey:(id)aKey;
- (CGRect) rectForKey:(id)aKey;

- (NSArray *)arrayForKey:(id)aKey;
- (NSArray *)arrayForKeyNotNull:(id)aKey;

- (NSDictionary *)dictionaryForKey:(id)aKey;
- (NSDictionary *)dictionaryForKeyNotNull:(id)aKey;

@end
