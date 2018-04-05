use <components\SwitchHole.scad>
use <components\MountHoles.scad>

function calc_hole_count(frame=81, frameEdge=5, switch=14, switchGap=5) = 
    ( (frame - (2*frameEdge) + switchGap) / (switch + switchGap));

function calc_hole_offset(pos=0, gap=5, switch=14, count=1) = ( pos + (switch + gap) * count );

module OrthoKeypad(frame_x=119,frame_y=81,frame_z=1.5) {
    // Gap around frame
    edge = 5;
    switch_gap = 5;
        
    //Build the Switch holes
    switch_size = 1;
    switch_x = switch_size(switch_size)[0];
    switch_y = switch_size(switch_size)[1];
    switch_z = switch_size(switch_size)[2];
    
    columns = floor(calc_hole_count(frame_x, edge, switch_x, switch_gap));
    rows = floor(calc_hole_count(frame_y, edge, switch_y, switch_gap));
    
    difference() {
        cube([frame_x,frame_y,frame_z], false);
        for (row = [0:1:rows-1]) {
            py = calc_hole_offset(edge, switch_gap, switch_y, row);
            translate([edge,py,0])
            cube([switch_x,switch_y,switch_z], false);
            for (column = [0:1:columns-1]) {
                px = calc_hole_offset(edge, switch_gap, switch_x, column);
                SwitchHole(switch_size,px,py,true,switch_gap);
            };
        };
        MountingHoles(3,3,frame_x,frame_y);
    };
}

projection(cut = true) OrthoKeypad();

