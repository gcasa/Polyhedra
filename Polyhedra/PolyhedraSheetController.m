//
//  PolyhedraSheetController.m
//  Polyhedra
//
//  Created by Gregory Casamento on 6/24/26.
//

#import <AppKit/AppKit.h>
#import <Foundation/Foundation.h>

#import "PolyhedraSheetController.h"
#import "PolyhedraView.h"

@implementation PolyhedraSheetController

- (instancetype) init
{
    self = [super init];
    if (self != nil)
    {
        if (![NSBundle loadNibNamed: @"Polyhedra" owner: self])
        {
            NSLog(@"Failed to load nib");
        }
    }
    return self;
}

- (IBAction) setSelectedIndex: (id)sender
{
    [_view setSelectedIndex: sender];
}

- (IBAction) kickIt: (id)sender
{
    [_view kickIt: sender];
}

- (NSWindow *) window
{
    return _window;
}

- (NSView *) view
{
    return _view;
}
@end
