//
//  ApiServices.h
//  KiddoTeste
//
//  Created by Aloisio Mello on 20/02/18.
//  Copyright © 2018 Aloisio Mello. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import "Reachability.h"

@interface ApiServices : NSObject

+(void)getRequestWithEndpoint:(NSURL*)endpoint withParameter:(id)parameter withCallback : (void (^) (id successCallback, id faillureCallback))handler;

@end
