$fn = 60;
wall = 2;

tolerance_x = 0.5;
tolerance_y = 0.5;
tolerance_z = 0.2;

screw_padding = 1.86;
screw = 3.3 + tolerance_x;
screw_distance = screw_padding + screw / 2;
screew_plate = screw_padding*2+screw;
depth_below = 9;
depth_above = 2;
total_depth = depth_below + depth_above+wall;
height = 48.14;
width = 128.11;

function split(total, steps) = [0 : total / (steps - 1) : total];

module screw_hole(position) {
    translate(position) {
        cylinder(total_depth + wall, d = screw, true);
    }
}

module main_box() {
    thickness = 1.8 + tolerance_z;
    length_between_screw_h = 118.45;
    length_between_screw_w = 38.4;
    inner_wall = wall;
    cable_hole = 20;
    
    difference() {
        cube([width + wall * 2, height + wall, total_depth + wall]);
        translate([wall+screew_plate, 0, wall]) {
            cube([width-screew_plate*2, height, total_depth]);
        }
        translate([wall, 0, wall + depth_below]) {
            cube([width, height, thickness]);
        }
        translate([wall, screew_plate, wall]) {
            cube([width, height - screew_plate * 2, depth_below - wall]);
        }
        screw_hole([wall + screw_distance, screw_distance, 0]);
        screw_hole([wall + screw_distance, height - screw_distance, 0]);
        screw_hole([wall + width - screw_distance, height - screw_distance, 0]);
        screw_hole([wall + width - screw_distance, screw_distance, 0]);
        translate([width + wall * 1.5, height / 2, wall + depth_below / 2]) {
            cube([wall, cable_hole, depth_below], true);
        }
    }
}

screen_total_width = 30;
screen_height = 10.5;
screen_depth = 8.3;
screen_width = 22.9;
screen_rail_width = (screen_total_width - screen_width) / 2;

module rail(position) {
    translate(position) {
        cube([screen_rail_width, height, total_depth - screen_height]); 
    }
}

module screen_screw_hole(position) {
    screw_hole = 2.5;
    translate(position) {
        cylinder(total_depth + wall, d = screw_hole, true);
    }
}

module gauge_box() {
    screw_padding = 1.3;
    pcb_tickness = 1.55 + tolerance_z;
    padding = 10;
    width = screen_total_width + padding * 2;
    screen_count = 3;
    
    difference() {
        cube([width + wall, height + wall, total_depth + wall]);
        translate([0, 0, wall]) {
            difference() {
                cube([width, height, total_depth]);
                rail([padding, 0, 0]);
                rail([padding + screen_total_width - screen_rail_width, 0, 0]);
                difference() {
                    union() {
                        translate([0, 0, total_depth - wall * 2]) {
                            cube([screew_plate, height, wall]);
                        }
                        translate([width - screew_plate, 0, total_depth - wall * 2]) {
                            cube([screew_plate, height, wall]);
                        }
                    }
                    screw_hole([screew_plate / 2, screew_plate / 2, 0]);
                    screw_hole([width - screew_plate / 2, screew_plate / 2, 0]);
                }
            }
        }
        for (i = split(height - padding * 2, screen_count)) {
            screen_screw_hole([padding + screen_rail_width / 2, padding + i, 0]);
            screen_screw_hole([padding + screen_total_width - screen_rail_width / 2, padding + i, 0]);
        }
    }
}

main_box();

translate([width + wall * 2, 0, 0]) {
    gauge_box();
}
