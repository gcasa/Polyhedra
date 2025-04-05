#ifndef _PSOPERATORS_H_
#define _PSOPERATORS_H_

#import <AppKit/AppKit.h>

/* PostScript-style drawing operators implemented in ObjC1.0 style using NSBezierPath */

void PSsetrgbcolor(float r, float g, float b);
void PSsetgray(float gray);
void PSmoveto(float x, float y);
void PSlineto(float x, float y);
void PSfill(void);
void PSstroke(void);
void PSsetlinewidth(float width);

#endif /* _PSOPERATORS_H_ */
