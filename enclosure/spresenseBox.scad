//---------------------------------------------------------
//  Uses YAPP (Yet Another Parameterized Projectbox) generator
//
//  This is a box for Sony Spresense with LTE extension board and camera
//
//  Version 1.0 (2022-07-01)
//---------------------------------------------------------
include <lib/YAPPgenerator_v14.scad>

printBaseShell      = true;
printLidShell       = true;

wallThickness       = 1.3;
basePlaneThickness  = 1.3;
lidPlaneThickness   = 1.3;

baseWallHeight      = 13;
lidWallHeight       = 20;

// Total height of box = basePlaneThickness + lidPlaneThickness 
//                     + baseWallHeight + lidWallHeight
pcbLength           = 50;
pcbWidth            = 45;
pcbThickness        = 1.5;
                            
// padding between pcb and inside wall
paddingFront        = 6.0;
paddingBack         = 2.0;
paddingRight        = 2.0;
paddingLeft         = 2.0;

// ridge where base and lid off box can overlap
// Make sure this isn't less than lidWallHeight
ridgeHeight         = 3;
ridgeSlack          = 0.2;

roundRadius         = 2.0;

// How much the PCB needs to be raised from the base
// to leave room for solderings and whatnot
standoffHeight      = 11.0;
pinDiameter         = 1.6;
pinHoleSlack        = 0.1;
standoffDiameter    = 4;


//-- D E B U G -------------------
showSideBySide      = true;
hideLidWalls        = false;
onLidGap            = 6;
shiftLid            = 10;
colorLid            = "yellow";
hideBaseWalls       = false;
colorBase           = "white";
showPCB             = false;
showMarkers         = true;
inspectX            = 0;  // 0=none, >0 from front, <0 from back
inspectY            = 0;  // 0=none, >0 from left, <0 from right


//-- pcb_standoffs  -- origin is pcb[0,0,0]
// (0) = posx
// (1) = posy
// (2) = { yappBoth | yappLidOnly | yappBaseOnly }
// (3) = { yappHole, YappPin }
pcbStands = [
                [1,           1,          yappBoth, yappPin] 
               ,[11,  pcbWidth-3,          yappBoth, yappPin]
               ,[pcbLength-3, 1,          yappBoth, yappPin]
               ,[pcbLength-3, pcbWidth-3, yappBoth, yappPin]
             ];     

//-- Lid plane    -- origin is pcb[0,0,0]
// (0) = posx
// (1) = posy
// (2) = width
// (3) = length
// (4) = angle
// (5) = { yappRectangle | yappCircle }
// (6) = { yappCenter }
cutoutsLid =  [
                  [(pcbWidth/2)+6,  (pcbWidth/2), 8, 8, 0, yappCircle, yappCenter]         // lens
                //, [9,  ((pcbWidth/2)+0.5), 9, 20, 0, yappCircle]         // lens
                //, [10, ((pcbWidth/2)+0.5), 9, 20, 0, yappCircle]         // lens
                //, [30, pcbWidth-3, 6, 6, 0, yappRectangle, yappCenter]   // flash LED
              ];

//-- base plane    -- origin is pcb[0,0,0]
// (0) = posx
// (1) = posy
// (2) = width
// (3) = length
// (4) = angle
// (5) = { yappRectangle | yappCircle }
// (6) = { yappCenter }
cutoutsBase =   [
                    [13, (pcbWidth/2)-7,  6, 1.5, 25, yappRectangle]
                  , [17, (pcbWidth/2)-7, 15, 1.5, 25, yappRectangle]
                  , [21, (pcbWidth/2)-7, 15, 1.5, 25, yappRectangle]
                  , [25, (pcbWidth/2)-7, 15, 1.5, 25, yappRectangle]
                  , [29, (pcbWidth/2)-7, 15, 1.5, 25, yappRectangle]
                  , [29, (pcbWidth/2)+0,  6, 1.5, 25, yappRectangle]
                ];

//-- front plane  -- origin is pcb[0,0,0]
// (0) = posy
// (1) = posz
// (2) = width
// (3) = height
// (4) = angle
// (5) = { yappRectangle | yappCircle }
// (6) = { yappCenter }
cutoutsFront =  [
                ];

//-- back plane  -- origin is pcb[0,0,0]
// (0) = posy
// (1) = posz
// (2) = width
// (3) = height
// (4) = angle
// (5) = { yappRectangle | yappCircle }
// (6) = { yappCenter }
cutoutsBack =   [
                ];

//-- left plane   -- origin is pcb[0,0,0]
// (0) = posx
// (1) = posz
// (2) = width
// (3) = height
// (4) = angle
// (5) = { yappRectangle | yappCircle }
// (6) = { yappCenter }
cutoutsLeft =   [
                    [11, 3, 15, 10, 0, yappRectangle, yappCenter] // SD card
                ];

//-- right plane   -- origin is pcb[0,0,0]
// (0) = posx
// (1) = posz
// (2) = width
// (3) = height
// (4) = angle
// (5) = { yappRectangle | yappCircle }
// (6) = { yappCenter }
cutoutsRight =  [
                    //[shellLength-13, -7, 4, 6.5, 0, yappRectangle] // power cord
                ];

//-- connectors -- origen = box[0,0,0]
// (0) = posx
// (1) = posy
// (2) = screwDiameter
// (3) = insertDiameter
// (4) = outsideDiameter
// (5) = { yappAllCorners }
connectors   =  [
                 //   [8, 8, 2.5, 3.8, 5, yappAllCorners]
                 // , [30, 8, 5, 5, 5]
                ];

//-- base mounts -- origen = box[x0,y0]
// (0) = posx | posy
// (1) = screwDiameter
// (2) = width
// (3) = height
// (4..7) = yappLeft / yappRight / yappFront / yappBack (one or more)
// (5) = { yappCenter }
baseMounts   = [
               ];

//-- snap Joins -- origen = box[x0,y0]
// (0) = posx | posy
// (1) = width
// (2..5) = yappLeft / yappRight / yappFront / yappBack (one or more)
// (n) = { yappSymmetric }
snapJoins   =     [
                    [25, 5, yappLeft],
                    [2, 5, yappRight],
                  , [(shellWidth/2)-2.5, 5, yappFront]
                ];
               
//-- origin of labels is box [0,0,0]
// (0) = posx
// (1) = posy/z
// (2) = orientation
// (3) = plane {lid | base | left | right | front | back }
// (4) = font
// (5) = size
// (6) = "label text"
labelsPlane =  [
               ];
               
module baseHookOutside()
{
  translate([(shellLength/2)-6,shellWidth-wallThickness,0])
  {
    difference()
    {
      union()
      {
        cube([12,10,10]);
        translate([0,10,5])
          rotate([0,90,0])
            cylinder(d=10, h=12);
      }
      translate([-1,10,5])
      {
        rotate([0,90,0])
          color("red") cylinder(d=5.2, h=17);
      }
      translate([3.8,0,-0.5])
        cube([4.4,16,11]);
    }
  
  } // translate
  
} //  baseHook()

module lidHookInside()
{
  
  translate([(pcbWidth/2)+22, (pcbWidth/2)-7, -lidPlaneThickness])
  rotate([-180, 0, 180]) {
      cylinder(6, d=2.2, true);
      cylinder(4, d=4, true);
     
      translate([12.5, 0, 0]) {
         cylinder(6, d=2.2, true);
         cylinder(4, d=4, true);
      }
      
      translate([12.5, 21, 0]) {
         cylinder(6, d=2.2, true);
         cylinder(4, d=4, true);
      }
      
      translate([0, 21, 0]) {
         cylinder(6, d=2.2, true);
         cylinder(4, d=4, true);
      }
  }
} //  lidHookInside()

//---- This is where the magic happens ----
YAPPgenerate();
