//
//  GifManagedObjectImage+CoreDataClass.h
//  GiphyApp
//
//  Created by Aliaksei Piatyha on 8/30/18.
//  Copyright © 2018 Aliaksei Piatyha. All rights reserved.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "GifModel.h"

extern NSString * _Nonnull const imageEntityName;

@class GifImage;

NS_ASSUME_NONNULL_BEGIN

@interface GifManagedObjectImage : NSManagedObject <GifImageModel>

@property (nonatomic) NSInteger height;
@property (nonnull, nonatomic, copy) NSString *url;
@property (nonatomic) NSInteger width;

+ (NSFetchRequest<GifManagedObjectImage *> *)fetchRequest;
- (GifManagedObjectImage*)initWithImage:(GifImage *)image context:(NSManagedObjectContext *)context;

@end

NS_ASSUME_NONNULL_END
