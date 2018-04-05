function calc_hole_count(frame=81, frameEdge=5, switch=14, switchGap=5) = 
    ( (frame - (2*frameEdge) + switchGap) / (switch + switchGap));

function calc_hole_offset(pos=0, gap=5, switch=14, count=1) = ( pos + (switch + gap) * count );

function switch_size(size=1,x=14,z=1.5) = ([x,x*size,z]);