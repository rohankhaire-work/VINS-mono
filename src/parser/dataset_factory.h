#pragma once
#include <string>
#include "dataset_parser.h"
#include "euroc_parser.cpp"
#include "uzh_parser.cpp"
#include "tumvi_parser.cpp"
#include "simulation_parser.cpp"

class DatasetFactory
{
public:
  static DatasetParser *Create(const std::string &type);
};
