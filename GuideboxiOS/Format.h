//
//  Format.h
//  GuideboxiOS
//
//  Created by Ezequiel Thomazetto on 09/09/16.
//  Copyright © 2016 Ezequiel Thomazetto. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface Format : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSString *formatName;
@property (nonatomic, strong) NSString *price;

#warning propriedade type pode ser um enum
@property (nonatomic, strong) NSString *type;

@end
