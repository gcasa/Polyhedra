//
//  PolyhedraSheetController.h
//  Polyhedra
//
//  Created by Gregory Casamento on 6/24/26.
//

#import <AppKit/AppKit.h>
#import <Foundation/Foundation.h>

@class PolyhedraView;

@interface PolyhedraSheetController : NSObject
{
    IBOutlet NSWindow *_window;
    IBOutlet PolyhedraView *_view;
    
    // Buttons...
    IBOutlet id _random;
    IBOutlet id _tetrahedron;
    IBOutlet id _cube;
    IBOutlet id _octahedron;
    IBOutlet id _dodecahedron;
    IBOutlet id _icosahedron;
}

- (IBAction) setSelectedIndex: (id)sender;
- (IBAction) kickIt: (id)sender;

- (NSWindow *) window;
- (PolyhedraView *) view;

@end
