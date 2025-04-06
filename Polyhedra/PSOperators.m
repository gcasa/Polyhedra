//
//  PSOperators.m
//  Polyhedra
//
//  Created by Gregory John Casamento on 4/4/25.
//

#import "PSOperators.h"

static NSColor *_currentStrokeColor = nil;
static NSColor *_currentFillColor = nil;
static NSBezierPath *_currentPath = nil;

static void _PSEnsurePath(void)
{
    if (!_currentPath) {
        _currentPath = [NSBezierPath bezierPath]; // retain];
    }
}

void PSsetlinewidth(float width)
{
    _PSEnsurePath();
    [_currentPath setLineWidth:width];
}

void PSsetrgbcolor(float r, float g, float b)
{
    _currentFillColor = [NSColor colorWithCalibratedRed:r green:g blue:b alpha:1.0];
    _currentStrokeColor = _currentFillColor;
}

void PSsetgray(float gray)
{
    _currentFillColor = [NSColor colorWithCalibratedWhite:gray alpha:1.0];
    _currentStrokeColor = _currentFillColor;
}

void PSmoveto(float x, float y)
{
    _PSEnsurePath();
    [_currentPath moveToPoint:NSMakePoint(x, y)];
}

void PSlineto(float x, float y)
{
    _PSEnsurePath();
    [_currentPath lineToPoint:NSMakePoint(x, y)];
}

void PSfill(void)
{
    if (_currentFillColor) {
        [_currentFillColor setFill];
    } else {
        [[NSColor blackColor] setFill];
    }
    [_currentPath fill];
    _currentPath = nil;
}

void PSstroke(void)
{
    if (_currentStrokeColor) {
        [_currentStrokeColor setStroke];
    } else {
        [[NSColor blackColor] setStroke];
    }
    [_currentPath stroke];
    _currentPath = nil;
}
