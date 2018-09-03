//
//  NSDate+FormattedString.m
//  GiphyApp
//
//  Created by Алексей on 29.08.2018.
//  Copyright © 2018 Aliaksei Piatyha. All rights reserved.
//

#import "NSDate+FormattedString.h"
#import "GlobalConstants.h"

@implementation NSDate (FormattedString)

- (NSString *)formattedString {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:gifDateFormatOut];
    
    return [dateFormatter stringFromDate:self];
}

@end
