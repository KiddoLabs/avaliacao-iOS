//
//  UnfavoriteMinionsTestCase.m
//  KiddoTesteTests
//
//  Created by Aloisio Mello on 23/02/18.
//  Copyright © 2018 Aloisio Mello. All rights reserved.
//

#import <KIF/KIF.h>

@interface UnfavoriteMinionsTestCase : KIFTestCase

@end

@implementation UnfavoriteMinionsTestCase

-(void)beforeAll{
    [tester tapViewWithAccessibilityLabel:@"Home"];
}

-(void)testUnfavoriteMinions{
    [tester waitForTappableViewWithAccessibilityLabel:@"Minions"];
    [tester tapViewWithAccessibilityLabel:@"Minions"];
    [tester waitForTappableViewWithAccessibilityLabel:@"Remover dos favoritos"];
    [tester tapViewWithAccessibilityLabel:@"Remover dos favoritos"];
    [tester waitForTappableViewWithAccessibilityLabel:@"Add aos favoritos"];
    [tester tapViewWithAccessibilityLabel:@"Voltar"];
    [tester tapViewWithAccessibilityLabel:@"Home"];
    [tester waitForTappableViewWithAccessibilityLabel:@"Minions"];
}
@end
