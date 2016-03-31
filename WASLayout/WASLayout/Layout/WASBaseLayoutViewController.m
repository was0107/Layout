//
//  WASBaseLayoutViewController.m
//  WASLayoutManager
//
//  Created by allen.wang on 11/19/12.
//  Copyright (c) 2012 b5m. All rights reserved.
//

#import "WASBaseLayoutViewController.h"

@interface WASBaseLayoutViewController()
@property (nonatomic, strong) WASContainer *container;

@end


@implementation WASBaseLayoutViewController
@synthesize container = _container;


- (void) loadView
{
    [super loadView];
    if (!_container) {
        WASFlowLayout *flow = [[WASFlowLayout alloc] init];
        flow.newAlign = WASFlowLayout.LEFT;
        flow.hgap = flow.vgap = 0;
        _container = [[WASContainer alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _container.backgroundColor = [UIColor grayColor];
        _container.layoutManager = flow;
    }
    self.view = _container;
}

- (WASContainer *)container
{
    return _container;
}


@end
