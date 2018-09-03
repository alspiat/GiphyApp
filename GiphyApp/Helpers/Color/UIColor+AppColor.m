//
//  UIColor+AppColor.m
//  GiphyApp
//
//  Created by Алексей on 26.08.2018.
//  Copyright © 2018 Aliaksei Piatyha. All rights reserved.
//

#import "UIColor+AppColor.h"

@implementation UIColor (AppColor)

+ (UIColor *)appPurple {
    return [UIColor colorWithRed:97.0/255.0 green:87.0/255.0 blue:255.0/255.0 alpha:255.0/255.0];
}

+ (UIColor *)appPink {
    return [UIColor colorWithRed:230.0/255.0 green:70.0/255.0 blue:182.0/255.0 alpha:255.0/255.0];
}

+ (UIColor *)appBlue {
    return [UIColor colorWithRed:0.0/255.0 green:204.0/255.0 blue:255.0/255.0 alpha:255.0/255.0];
}

+ (UIColor *)appGreen {
    return [UIColor colorWithRed:0.0/255.0 green:230.0/255.0 blue:204.0/255.0 alpha:255.0/255.0];
}

+ (UIColor *)appRandomColor {
    NSArray<UIColor *> *array = [NSArray arrayWithObjects:[UIColor appPurple], [UIColor appPink], [UIColor appBlue], [UIColor appGreen], nil];
    return array[0 + arc4random() % (array.count - 0)];
}

@end
