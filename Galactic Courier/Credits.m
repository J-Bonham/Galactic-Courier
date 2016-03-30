//
//  Credits.m
//  Galactic Courier
//
//  Created by Jeremiah Bonham on 5/27/15.
//  Copyright (c) 2015 Jeremiah.Bonham. All rights reserved.
//

#import "Credits.h"
#import "Title.h"

@interface Credits ()
{
    
    SKSpriteNode *tut;
    SKLabelNode *backText;
    SKSpriteNode *stars1;
    SKLabelNode *extra;
    SKLabelNode *extra2;

    
}

@end


@implementation Credits


-(void)didMoveToView:(SKView *)view {
    
    self.scaleMode = SKSceneScaleModeAspectFill;
    
    self.backgroundColor = [SKColor blackColor];
    
    stars1 = [SKSpriteNode spriteNodeWithImageNamed:@"stars010"];
    stars1.anchorPoint = CGPointZero;
    stars1.position = CGPointMake(0, 0);
    [self addChild:stars1];
    
    backText = [SKLabelNode labelNodeWithFontNamed:@"Futura Medium"];
    backText.text = @"Touch Screen to Return to Menu";
    backText.fontColor = [SKColor whiteColor];
    backText.fontSize = 20;
    backText.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMaxY(self.frame) - 40);
    [self addChild:backText];
    
    extra = [SKLabelNode labelNodeWithFontNamed:@"Futura Medium"];
    extra.text = @"Project started as School Assignment";
    extra.fontColor = [SKColor whiteColor];
    extra.fontSize = 12;
    extra.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMinY(self.frame) + 40);
    [self addChild:extra];
    
    extra2 = [SKLabelNode labelNodeWithFontNamed:@"Futura Medium"];
    extra2.text = @"Much More Planned for Future Releases";
    extra2.fontColor = [SKColor whiteColor];
    extra2.fontSize = 12;
    extra2.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMinY(self.frame) + 20);
    [self addChild:extra2];
    
    
    
    tut = [SKSpriteNode spriteNodeWithImageNamed:@"cred"];
    tut.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    
    [self addChild:tut];
    
    
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    Title   *firstScene = [Title sceneWithSize:self.size];
    [self.view presentScene:firstScene transition:[SKTransition doorsCloseHorizontalWithDuration:(1.25)]];
}

@end