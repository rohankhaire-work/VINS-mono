#pragma once
#include <string>
#include <vector>

struct ImuData
{
  double timestamp;
  double wx, wy, wz;
  double ax, ay, az;
};

struct ImageData
{
  double timestamp;
  std::string filename;
};

class DatasetParser
{
public:
  virtual ~DatasetParser() {}

  virtual bool LoadIMU(const std::string &imuFile, std::vector<ImuData> &imus) = 0;

  virtual bool LoadImages(const std::string &imageFile, const std::string &imagePath,
                          std::vector<ImageData> &images)
    = 0;
};
