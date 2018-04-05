function calc_hole_count(frame=81, frameEdge=5, switch=14, switchGap=5) = 
    ( (frame - (2*frameEdge) + switchGap) / (switch + switchGap));

function calc_hole_offset(pos=0, gap=5, switch=14, count=1) = ( pos + (switch + gap) * count );

function switch_size(size=1,x=14,z=1.5) = ([x,x*size,z]);

module OrthoSmall(frame_x=119,frame_y=81,frame_z=1.5) {
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

module SwitchHole(size=1,pos_x=0,pos_y=0,ortho=false,gap=5) {
    sx = switch_size(size)[0]; 
    sy = ((ortho)&&(size>1)) ? 
        switch_size(size)[1] + gap :
        switch_size(size)[1];

    translate([pos_x,pos_y,0])
    cube([sx,sy,1.5], false);
    translate([pos_x+1,pos_y-1,0])
    cube([3.15,sy+1.6,1.5], false);
    translate([pos_x+9.85,pos_y-1,0])
    cube([3.15,sy+1.6,1.5], false);
    if (size>=2) { // if hole greater than 2u add stabs
        translate([pos_x-1,pos_y+0.6,0])
        cube([sx+2,8,1.5],false);
        translate([pos_x-1,pos_y+sy-8.6,0])
        cube([sx+2,8,1.5],false);
    }
}

module MountingHoles(x=0,y=0,fx=0,fy=0,hr=1.5) {
    translate([x,y,0])
    cylinder(h=1.5,r=hr);
    translate([fx-x,y,0])
    cylinder(h=1.5,r=hr);
    translate([fx-x,fy-y,0])
    cylinder(h=1.5,r=hr);
    translate([x,fy-y,0])
    cylinder(h=1.5,r=hr);
}

projection(cut = true) OrthoSmall();

