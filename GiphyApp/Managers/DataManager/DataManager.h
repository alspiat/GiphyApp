//
//  DataManager.h
//  GiphyApp
//
//  Created by Aliaksei Piatyha on 8/28/18.
//  Copyright © 2018 Aliaksei Piatyha. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GifEntity;
@protocol NetworkCancelable;

typedef void (^BlockWithImage)(UIImage *);

@interface DataManager : NSObject

+ (id<NetworkCancelable>)loadPreviewImage:(GifEntity*)gifEntity completionHandler:(BlockWithImage)completionHandler;
+ (id<NetworkCancelable>)loadOriginalImage:(GifEntity*)gifEntity completionHandler:(BlockWithImage)completionHandler;

@end
