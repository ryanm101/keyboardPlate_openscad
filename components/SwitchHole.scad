use <funcs.scad>

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