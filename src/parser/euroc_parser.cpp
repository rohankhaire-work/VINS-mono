#include "dataset_parser.h"
#include <fstream>
#include <sstream>
#include <iostream>

class EurocParser : public DatasetParser
{
public:
  bool LoadIMU(const std::string &imuFile, std::vector<ImuData> &imus) override
  {
    std::ifstream f(imuFile);
    if(!f.is_open())
      return false;

    std::string line;
    while(getline(f, line))
    {
      if(line.empty() || line[0] == '#')
        continue;

      std::stringstream ss(line);
      std::string field;

      ImuData d;

      // timestamp (ns)
      getline(ss, field, ',');
      long long t_ns = std::stoll(field);
      d.timestamp = t_ns * 1e-9; // convert to seconds

      // wx
      getline(ss, field, ',');
      d.wx = std::stod(field);

      // wy
      getline(ss, field, ',');
      d.wy = std::stod(field);

      // wz
      getline(ss, field, ',');
      d.wz = std::stod(field);

      // ax
      getline(ss, field, ',');
      d.ax = std::stod(field);

      // ay
      getline(ss, field, ',');
      d.ay = std::stod(field);

      // az
      getline(ss, field, ',');
      d.az = std::stod(field);

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
      char comma;
      ss >> im.timestamp >> comma >> im.filename;
      im.timestamp *= 1e-9;
      im.filename = imagePath + im.filename;

      images.push_back(im);
    }
    return true;
  }
};
