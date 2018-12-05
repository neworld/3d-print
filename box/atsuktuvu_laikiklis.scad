length = 140;
hole_space = 20;
pertvaros = [hole_space * 1.5 : hole_space * 4 : length];
wall = 1.6;

module hole() { 
    cylinder(3.2, d1 = 3, d2 = 6, center = true);
}

difference() {
    union() {
        cube([length,20, 3]);
        cube([length, wall, 40]);
        translate([0, 20, 0]) {
            cube([length, wall, 40]);
        }
        difference() {
            for (i = pertvaros) { 
                translate([i - 1.5, 0, 0]) {
                    cube([2, 20, 50]);
                }
            }
            translate([0, 0, 25]) {
                rotate([30, 0, 0]) {
                    cube([length,40, 30]);
                }
            }
        }
    }
    for (i = [hole_space : hole_space : length - hole_space]) {
        translate([i, 0, 25]) {
            rotate([90, 0, 0]) {
                scale([1, 1.3, 1]) {
                    cylinder(80, d = 10, center = true);
                }
            }
        }
    }
    translate([40, 10, 1.5]) {
        hole();
    }
    translate([length - 40, 10, 1.5]) {
        hole();
    }
    translate([length / 8 + 20, 10, 0]) {
    //    hole();
    }
    translate([length / 4 * 3 - 20, 10, 0]) {
    //    hole();
    }
}