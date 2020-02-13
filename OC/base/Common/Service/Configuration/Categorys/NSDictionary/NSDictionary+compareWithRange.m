//
//  NSDictionary+compareWithRange.m
//

#import "NSDictionary+compareWithRange.h"

@implementation NSDictionary (compareWithRange)

- (NSComparisonResult)compareWithRange:(NSDictionary *) dic{  
    NSDictionary *dic1 = self;  
    NSRange range1 = [[dic1 objectForKey:@"range"] rangeValue];
    NSRange range2 = [[dic objectForKey:@"range"] rangeValue];
    return range1.location-range2.location;
}

@end
