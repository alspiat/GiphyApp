//
//  DataManager.h
//  GiphyApp
//
//  Created by Aliaksei Piatyha on 8/28/18.
//  Copyright © 2018 Aliaksei Piatyha. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GifEntity;

typedef void (^BlockWithImage)(UIImage *);

@interface DataManager : NSObject

+ (NSURLSessionDataTask *)loadPreviewImage:(GifEntity*)gifEntity completionHandler:(BlockWithImage)completionHandler;
+ (NSURLSessionDataTask *)loadOriginalImage:(GifEntity*)gifEntity completionHandler:(BlockWithImage)completionHandler;

@end
