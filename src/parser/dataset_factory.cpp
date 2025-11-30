#include "dataset_factory.h"

DatasetParser *DatasetFactory::Create(const std::string &type)
{
  if(type == "euroc")
    return new EurocParser();
  if(type == "uzh")
    return new UzhParser();
  if(type == "tumvi")
    return new TumViParser();
  if(type == "simulation")
    return new SimulationParser();

  std::cerr << "Unknown dataset type: " << type << std::endl;
  return nullptr;
}
