/*
Copyright (C) 2022 Paolo Loberto - MrLoba81
    https://github.com/MrLoba81
    https://www.instagram.com/mrloba81/

- OpenScad Reglette Power switch (C5 or C7 Connector)
  https://en.wikipedia.org/wiki/IEC_60320

This program is free software: you can redistribute it and/or modify it under the terms of the version 3 GNU General Public License as published by the Free Software Foundation. This program is distributed in the hope that it will be useful,but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See theGNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.                                                       
29/07/2022 - First release 
*/
$fn=100;

// - Connector type
connectorType = 0;// [0:C7, 1:C5]

module innerCylinderHole() {
    translate([0,0.2,0])
        rotate([90,0,0])
        linear_extrude(10)
        circle(d=4.1);
}

module cylinder(size) {
    difference() {
        rotate([90,0,0])
        linear_extrude(12+5.5)
        circle(d=size);
        translate([0,0.005,0])
        rotate([90,0,0])
        linear_extrude(12.01+5.5)
        circle(d=3.8);
        
        innerCylinderHole();
        
        color("WHITE")
        translate([-2.3,-(17.51),-0.4])
        cube([4.6,7.5,0.8]);
    }
}

module connector() {
    union() {
        //cube([15.4,1,7.1]);
        translate([3.55,5.5,3.55])
        cylinder(7.1);
        translate([15.4-3.55,5.5,3.55])
        cylinder(7.1);
    }
}

module threeConnectors() {
    //color("RED")
    union() {
        
        //cube([15.4,1,7.1]);
        translate([3.55,5.5,3.55])
        cylinder(5.8);
        translate([15.4-3.55,5.5,3.55])
        cylinder(5.8);
        
        translate([7.7,5.5,7.4])
        cylinder(5.8);
    }
}

module cover() {
    translate([50,0,0]) {
        union() {
            cube([35,30,1]);
            translate([1,1,1])
            difference(){
                cube([33-0.4,28-0.4,4]);
                translate([1,1,0.01])
                cube([31-0.4,26-0.4,4.03]);
            }
        }
    }
}


union() {
    difference() {
        cube([35,30,25]);
        translate([1,1,1])
        cube([33,28,25]);
        translate([0,30/2+15.4/2,0])
        rotate([0,0,-90])
        translate([3.55,5.5,3.55])
        innerCylinderHole();
        translate([0,30/2+15.4/2,0])
        rotate([0,0,-90])
        translate([15.4-3.55,5.5,3.55])
        innerCylinderHole();
        
        //Button
        translate([35/2-14.2/2,30-1.025,10])
        cube([14.2,2.05,9]);
        //wires
        translate([35-1.025,30/2-2,1])
        cube([2.05,4,3]);
    }
    
    translate([0,30/2+15.4/2,0])
    rotate([0,0,-90]) {
        if (connectorType == 0) connector();
        else threeConnectors();
    }
}

cover();