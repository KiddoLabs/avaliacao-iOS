//
//  ApiManager.m
//  KiddoTeste
//
//  Created by Aloisio Mello on 20/02/18.
//  Copyright © 2018 Aloisio Mello. All rights reserved.
//

#import "ApiManager.h"

@implementation ApiManager
+(void)getMoviesFromPage:(NSInteger)page withCallback:(void (^) (id successCallback, id faillureCallback))handler{
    NSString * strURL = [NSString stringWithFormat:@"%@%@%@", kWebserviceRootEndpoint, [NSString stringWithFormat:klistMovieApi,page],kTheMovieDatabaseApiKey];
    
    NSLog(@"url = %@", strURL);
    
    [ApiServices getRequestWithEndpoint:[NSURL URLWithString:strURL] withParameter:nil withCallback:handler];
}

@end
