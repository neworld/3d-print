difference() {
    union() {
        cube([240,20, 4]);
        cube([240, 4, 40]);
        translate([0, 20, 0]) {
            cube([240, 4, 60]);
        }
        for (i = [40 : 40 : 200]) { 
            translate([i - 1.5, 0, 0]) {
                cube([3, 20, 40]);
            }
        }
    }
    for (i = [20 : 40 : 220]) {
        translate([i, 0, 20]) {
            rotate([120, 0, 0]) {
                cylinder(80, d = 15, center = true);
            }
        }
    }
    translate([60, 10, 0]) {
        cylinder(20, d = 5, center = true);
    }
    translate([240 - 60, 10, 0]) {
        cylinder(20, d = 5, center = true);
    }
}