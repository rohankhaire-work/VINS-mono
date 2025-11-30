#include "dataset_parser.h"
#include <fstream>
#include <sstream>
#include <iostream>

class SimulationParser : public DatasetParser
{
public:
  bool LoadIMU(const std::string &imuFile, std::vector<ImuData> &imus) override
  {
    std::ifstream f(imuFile);
    if(!f.is_open())
      return false;

    std::string line;
    while(std::getline(f, line))
    {
      if(line.empty() || line[0] == '#')
        continue;

      std::stringstream ss(line);
      ImuData d;

      ss >> d.timestamp; // already in seconds
      ss >> d.wx >> d.wy >> d.wz;
      ss >> d.ax >> d.ay >> d.az;

      imus.push_back(d);
    }

    return true;
  }

  bool LoadImages(const std::string &imageFile, const std::string &imagePath,
                  std::vector<ImageData> &images) override
  {
    std::ifstream f(imageFile);
    if(!f.is_open())
      return false;

    std::string s;
    while(getline(f, s))
    {
      if(s.empty() || s[0] == '#')
        continue;

      std::stringstream ss(s);
      ImageData im;
      ss >> im.timestamp >> im.filename;
      im.filename = imagePath + im.filename;

      images.push_back(im);
    }
    return true;
  }
};
