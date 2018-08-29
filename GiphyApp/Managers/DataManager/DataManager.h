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

typedef void (^BlockWithData)(NSData *);

@interface DataManager : NSObject

+ (id<NetworkCancelable>)loadPreviewImageData:(GifEntity*)gifEntity completionHandler:(BlockWithData)completionHandler;
+ (id<NetworkCancelable>)loadOriginalImageData:(GifEntity*)gifEntity completionHandler:(BlockWithData)completionHandler;

@end
