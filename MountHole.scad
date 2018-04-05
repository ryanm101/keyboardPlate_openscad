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