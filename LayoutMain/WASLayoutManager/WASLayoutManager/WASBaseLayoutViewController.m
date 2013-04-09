//
//  WASBaseLayoutViewController.m
//  WASLayoutManager
//
//  Created by allen.wang on 11/19/12.
//  Copyright (c) 2012 b5m. All rights reserved.
//

#import "WASBaseLayoutViewController.h"

@interface WASBaseLayoutViewController()
@property (nonatomic, retain) WASContainer *container;

@end


@implementation WASBaseLayoutViewController
@synthesize container = _container;


- (void) loadView
{
    [super loadView];
    if (!_container) {
        WASFlowLayout *flow = [[[WASFlowLayout alloc] init] autorelease];
        flow.newAlign = WASFlowLayout.LEFT;
        flow.hgap = flow.vgap = 0;
        _container = [[WASContainer alloc] initWithFrame:[UIScreen mainScreen] .applicationFrame ];  
        _container.backgroundColor = [UIColor grayColor];
        _container.layoutManager = flow;
    }
    self.view = _container;
}

- (WASContainer *)container
{
    return _container;
}

- (void) dealloc
{
    [_container release]; _container = nil;
    [super dealloc];
}

@end
