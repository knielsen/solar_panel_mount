// Angle of the plate holding the solar cell
angle=45; // [90]
// Height
height=100;
// Width
width=100;
// Thickness
thick = 1.6;
// ??
text_depth=1;

$fa = 10;
$fs = 0.2;

module for_vertical_print_internal() {
  M = [ [   1,   0,   0,   0 ],
        [   0,   1,   0,   0 ],
        [   0,   1,   1,   0 ],
        [   0,   0,   0,   1 ]];
  intersection() {
    children();
    translate([0, 0, -1])
      multmatrix(M)
        children();
  }
}

module text_for_3dprint(t) {
  for_vertical_print_internal() {
    rotate([90, 0, 180])
      linear_extrude(height=text_depth, convexity=10)
        text(t, halign="center", valign="center", size=10/50*height);
  }
}

module holder() {
  difference() {
    rotate([angle, 0, 0]) {
      translate([0, 0, -100])
        cube([width, height, 6.6+100], center=false);
    }
    rotate([angle, 0, 0]) {
      translate([-.5, 4, thick])
        cube([width+1, height+1, 6.6], center=false);
    }
    translate([0, 0, -5*height])
      cube([5*width, 5*height, 10*height], center=true);
    translate([-1, height*cos(angle)-thick*sin(angle), -1]) {
      cube([5*width, 5*height, 5*height], center=false);
    }
    translate([-1, 0, height*sin(angle)])
      cube([500, 500, 50]);
    translate([width-text_depth+0.01, height*cos(angle)/1.5, height*sin(angle)/3])
      rotate([0, 0, -90])
        text_for_3dprint(str(angle, "°"));
  }
}

holder();
