//
//  FavoriteMinionsTestCase.m
//  KiddoTesteTests
//
//  Created by Aloisio Mello on 23/02/18.
//  Copyright © 2018 Aloisio Mello. All rights reserved.
//

#import <KIF/KIF.h>

@interface FavoriteMinionsTestCase : KIFTestCase

@end

@implementation FavoriteMinionsTestCase

-(void)beforeAll{
    [tester tapViewWithAccessibilityLabel:@"Home"];
}

-(void)testFavoriteMinions{
    [tester waitForTappableViewWithAccessibilityLabel:@"Minions"];
    [tester tapViewWithAccessibilityLabel:@"Minions"];
    [tester waitForTappableViewWithAccessibilityLabel:@"Add aos favoritos"];
    [tester tapViewWithAccessibilityLabel:@"Add aos favoritos"];
    [tester waitForTappableViewWithAccessibilityLabel:@"Remover dos favoritos"];
    [tester tapViewWithAccessibilityLabel:@"Voltar"];
    [tester tapViewWithAccessibilityLabel:@"Favoritos"];
    [tester waitForTappableViewWithAccessibilityLabel:@"Minions"];
}


@end
