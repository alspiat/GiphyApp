//
//  UIColor+AppColor.m
//  GiphyApp
//
//  Created by Алексей on 26.08.2018.
//  Copyright © 2018 Aliaksei Piatyha. All rights reserved.
//

#import "UIColor+AppColor.h"

@implementation UIColor (AppColor)

+ (UIColor *)giphyPurple {
    return [UIColor colorWithRed:97.0/255.0 green:87.0/255.0 blue:255.0/255.0 alpha:255.0/255.0];
}

+ (UIColor *)giphyPink {
    return [UIColor colorWithRed:230.0/255.0 green:70.0/255.0 blue:182.0/255.0 alpha:255.0/255.0];
}

+ (UIColor *)giphyBlue {
    return [UIColor colorWithRed:0.0/255.0 green:204.0/255.0 blue:255.0/255.0 alpha:255.0/255.0];
}

+ (UIColor *)giphyGreen {
    return [UIColor colorWithRed:0.0/255.0 green:230.0/255.0 blue:204.0/255.0 alpha:255.0/255.0];
}

+ (UIColor *)randomThemeColor {
    NSArray<UIColor *> *array = [NSArray arrayWithObjects:[UIColor giphyPurple], [UIColor giphyPink], [UIColor giphyBlue], [UIColor giphyGreen], nil];
    return array[0 + arc4random() % (array.count - 0)];
}

@end
