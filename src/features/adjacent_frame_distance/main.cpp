#include <iostream>

#include "project.h"
#include "Image.h"
#include "OpticalFlow.h"

void optflowNDirDiff(const DImage& im1, const DImage& im2) {
  double alpha= 1;
  double ratio=0.5;
  int minWidth= 40;
  int nOuterFPIterations = 3;
  int nInnerFPIterations = 1;
  int nSORIterations= 20;
  DImage vx,vy,warpI2;

  OpticalFlow::Coarse2FineFlow(vx,vy,warpI2,im1,im2,alpha,ratio,minWidth,nOuterFPIterations,nInnerFPIterations,nSORIterations);

  array<double, N> feats;
  vx.AngleMagnitude(vy, feats);
}

void optflowDiff(const DImage& im1, const DImage& im2) {
  double alpha= 1;
  double ratio=0.5;
  int minWidth= 40;
  int nOuterFPIterations = 3;
  int nInnerFPIterations = 1;
  int nSORIterations= 20;
  DImage vx,vy,warpI2;

  OpticalFlow::Coarse2FineFlow(vx,vy,warpI2,im1,im2,alpha,ratio,minWidth,nOuterFPIterations,nInnerFPIterations,nSORIterations);

  double magnitude = vx.Magnitude(vy);
  std::cout << magnitude << endl;
}

void grayDiff(const DImage& im1, const DImage& im2) {
  DImage gray1, gray2, gdiff;
  im1.desaturate(gray1);
  im2.desaturate(gray2);
  gdiff.Subtract(gray1, gray2);
  std::cout << gdiff.sum() << endl;
}

void RGBDiff(const DImage& im1, const DImage& im2) {
  DImage diff;
  diff.Subtract(im1, im2);
  std::cout << diff.sum() << endl;
}

int main(int argc, char *argv[]){
  if (argc != 4) {
    std::cerr << "usage: " << argv[0] << " image1 image2 difftype(optdiff|optdiff_8|graydiff|rgbdiff)\n";
    std::cerr << "\n";
    std::cerr << "optdiff : sum of optical flow differences between image1 and image2\n";
    std::cerr << "optdiff_8 : sum of optical flow differences of each 8 directions between image1 and image2\n";
    std::cerr << "graydiff : sum of pixel differences in grayscale between image1 and image2\n";
    std::cerr << "rgbdiff : sum of pixel differences in RGB between image1 and image2\n";
    return 1;
  }
  DImage Im1, Im2;
  Im1.imread(argv[1]);
  Im2.imread(argv[2]);
  std::string difftype(argv[3]);
  if(difftype == "optdiff"){ optflowDiff(Im1, Im2); }
  else if(difftype == "optdiff_8"){ optflowNDirDiff(Im1, Im2); }
  else if(difftype == "graydiff"){ grayDiff(Im1, Im2); }
  else if(difftype == "rgbdiff"){ RGBDiff(Im1, Im2); }
  else { std::cerr << "difftype mismatch (optdiff|optdiff_8|graydiff|rgbdiff)\n"; }

  return 0;
}
