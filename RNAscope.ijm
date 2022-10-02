  requires("1.33s"); 
  run("Set Measurements...", "area mean integrated area_fraction display redirect=None decimal=3");
   dir = getDirectory("Choose a input Directory ");
   dir2 = getDirectory("_Choose an output Directory ");
   setBatchMode(true);
   count = 0;
   countFiles(dir);
   n = 0;
   processFiles(dir);
   print(count+" files processed");
   
   function countFiles(dir) {
      list = getFileList(dir);
      for (i=0; i<list.length; i++) {
          if (endsWith(list[i], "/"))
              countFiles(""+dir+list[i]);
          else
              count++;
      }
  }

   function processFiles(dir) {
      list = getFileList(dir);
      for (i=0; i<list.length; i++) {
          if (endsWith(list[i], "/"))
              processFiles(""+dir+list[i]);
          else {
             showProgress(n++, count);
             path = dir+list[i];
             processFile(path);
          }
      }
  }

  function processFile(path) {
  	print(path);
       if (endsWith(path, ".png"))
           open(path);
run("Duplicate...", " ");
run("Duplicate...", " ");
// RED STUFF 
// Color Thresholder 2.0.0-rc-61/1.51n
// Autogenerated macro, single images only!
min=newArray(3);
max=newArray(3);
filter=newArray(3);
a=getTitle();
run("HSB Stack");
run("Convert Stack to Images");
selectWindow("Hue");
rename("0");
selectWindow("Saturation");
rename("1");
selectWindow("Brightness");
rename("2");
min[0]=23;
max[0]=226;
filter[0]="stop";
min[1]=28;
max[1]=255;
filter[1]="pass";
min[2]=50;
max[2]=231;
filter[2]="pass";
for (i=0;i<3;i++){
  selectWindow(""+i);
  setThreshold(min[i], max[i]);
  run("Convert to Mask");
  if (filter[i]=="stop")  run("Invert");
}
imageCalculator("AND create", "0","1");
imageCalculator("AND create", "Result of 0","2");
for (i=0;i<3;i++){
  selectWindow(""+i);
  close();
}
selectWindow("Result of 0");
close();
selectWindow("Result of Result of 0");
rename(a);
// Colour Thresholding-------------


run("Measure");
original1 = File.getName(path);
saveAs("Tiff", dir2+ original1 +"_Red.tif");
close();

//Brown STUFF//

// Color Thresholder 2.0.0-rc-61/1.51n
// Autogenerated macro, single images only!
min=newArray(3);
max=newArray(3);
filter=newArray(3);
a=getTitle();
run("HSB Stack");
run("Convert Stack to Images");
selectWindow("Hue");
rename("0");
selectWindow("Saturation");
rename("1");
selectWindow("Brightness");
rename("2");
min[0]=23;
max[0]=34;
filter[0]="pass";
min[1]=53;
max[1]=255;
filter[1]="pass";
min[2]=0;
max[2]=213;
filter[2]="pass";
for (i=0;i<3;i++){
  selectWindow(""+i);
  setThreshold(min[i], max[i]);
  run("Convert to Mask");
  if (filter[i]=="stop")  run("Invert");
}
imageCalculator("AND create", "0","1");
imageCalculator("AND create", "Result of 0","2");
for (i=0;i<3;i++){
  selectWindow(""+i);
  close();
}
selectWindow("Result of 0");
close();
selectWindow("Result of Result of 0");
rename(a);
// Colour Thresholding-------------

run("Analyze Particles...", "size=0-30 circularity=0.90-1.00 show=Masks");
run("Measure");
original2 = File.getName(path);
saveAs("Tiff", dir2+original2+"_Brown.tif");
close();
close();

// Amount of Tissue Calculation

run("Gaussian Blur...", "sigma=2");
// Color Thresholder 2.0.0-rc-61/1.51n
// Autogenerated macro, single images only!
min=newArray(3);
max=newArray(3);
filter=newArray(3);
a=getTitle();
run("HSB Stack");
run("Convert Stack to Images");
selectWindow("Hue");
rename("0");
selectWindow("Saturation");
rename("1");
selectWindow("Brightness");
rename("2");
min[0]=14;
max[0]=53;
filter[0]="pass";
min[1]=20;
max[1]=255;
filter[1]="pass";
min[2]=0;
max[2]=255;
filter[2]="pass";
for (i=0;i<3;i++){
  selectWindow(""+i);
  setThreshold(min[i], max[i]);
  run("Convert to Mask");
  if (filter[i]=="stop")  run("Invert");
}
imageCalculator("AND create", "0","1");
imageCalculator("AND create", "Result of 0","2");
for (i=0;i<3;i++){
  selectWindow(""+i);
  close();
}
selectWindow("Result of 0");
close();
selectWindow("Result of Result of 0");
rename(a);
// Colour Thresholding-------------
run("Close-");
run("Measure");
original3 = File.getName(path);
saveAs("Tiff", dir2+original3+"_Tissue.tif");
close();
}