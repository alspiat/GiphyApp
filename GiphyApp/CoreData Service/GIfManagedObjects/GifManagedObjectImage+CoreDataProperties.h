//
//  GifManagedObjectImage+CoreDataProperties.h
//  GiphyApp
//
//  Created by Dmitriy Tarelkin on 29/8/18.
//  Copyright © 2018 Aliaksei Piatyha. All rights reserved.
//
//

#import "GifManagedObjectImage+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface GifManagedObjectImage (CoreDataProperties)

+ (NSFetchRequest<GifManagedObjectImage *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *webURL;
@property (nonatomic) int64_t size;
@property (nonatomic) int64_t height;
@property (nonatomic) int64_t width;
@property (nullable, nonatomic, copy) NSString *localURL;

@end

NS_ASSUME_NONNULL_END
