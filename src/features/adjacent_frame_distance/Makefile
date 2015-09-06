CXX = g++
CXXFLAGS = -O2 -g -fmessage-length=0 -DNDEBUG
# opencv include path
CPPFLAGS = -I/usr/local/Cellar/opencv/2.4.9/include
# opencv lib path
LDFLAGS = -L/usr/local/Cellar/opencv/2.4.9/lib

OBJS = main.o OpticalFlow.o Stochastic.o GaussianPyramid.o

LDLIBS =  -lopencv_core -lopencv_imgproc -lopencv_calib3d -lopencv_video \
          -lopencv_features2d -lopencv_ml -lopencv_highgui -lopencv_objdetect \
          -lopencv_contrib -lopencv_legacy -lopencv_gpu

TARGET = imgdiff

.PHONY: all
all: $(TARGET)
$(TARGET):  $(OBJS)
	$(CXX) $(LDFLAGS) $^ $(LDLIBS) -o $@

.PHONY: clean
clean:
	rm -f $(OBJS) $(TARGET)
