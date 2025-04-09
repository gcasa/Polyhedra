//
//  PolyhedraView.h
//  Polyhedra
//
//  Created by Gregory John Casamento on 4/4/25.
//

#import <ScreenSaver/ScreenSaver.h>

//#define SPRING_K        0.2
#define SPRING_K        0.15
#define SPRING_REST_LEN        150

// #define DAMPING        0.1
#define DAMPING            0.05

#define DEPTH            2
//#define MASS            10
#define MASS            15

#define TETRAHEDRON        0
#define CUBE            1
#define OCTAHEDRON        2
#define DODECAHEDRON        3
#define ICOSAHEDRON        4

#define NUM_POLYHEDRA        (ICOSAHEDRON + 1)

#define MAX_NUM_VERTICES    20
#define    MAX_NUM_ADJACENTS    5
#define MAX_NUM_FACES        20
#define MAX_VERTICES_PER_FACE    5

#define INIT_VELOCITY        10
#define MAX_VEL            100

typedef struct
{
  float    x,y,z;
} D3_PT;

typedef struct
{
  float    mass;
  D3_PT    vel;
  D3_PT    pos;
  NSPoint screenPos;
} VERTEX;

extern float randBetween(float lower, float upper);

// Distance between two points.  Inlined for efficiency.
float distance(float xcrd, float ycrd, float zcrd);

float distance(float xcrd, float ycrd, float zcrd)
{
  return sqrt(xcrd * xcrd + ycrd * ycrd + zcrd * zcrd);
}

@interface PolyhedraView : ScreenSaverView
{
    int        polyhedron;
    int        selectedIndex;
    int        numVertices;
    int        numAdjacents;
    int        numFaces;
    int        numDrawFaces;
    int        verticesPerFace;
    int        realAdjacents;
    
    VERTEX     vertices[MAX_NUM_VERTICES];
    float      restLengths[MAX_NUM_VERTICES][MAX_NUM_VERTICES];
    BOOL       isAdjacent[MAX_NUM_VERTICES][MAX_NUM_VERTICES];
    
    D3_PT      perspectivePt;
    D3_PT      backTopRight;
    
    float      damping;
    
    BOOL       noAnimation;
    int        backStep;
    id         inspectorPanel;
}

- (id) useNewFrame: (NSRect)frameRect;

- (id) perspectiveLineFrom: (D3_PT)pt1 to: (D3_PT)pt2;
- (id) drawBoxInColour: (float)theGray;
- (id) drawPolyhedron;
- (id) erasePolyhedron;
- (id) frameChanged: (NSRect)frameRect;

- (id) setSelectedIndex: (id)sender;
- (id) kickIt: (id)sender;
- (id) inspector: (id)sender;

@end
